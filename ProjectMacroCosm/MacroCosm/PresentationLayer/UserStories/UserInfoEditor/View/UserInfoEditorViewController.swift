//
//  UserInfoEditorViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit

final class UserInfoEditorViewController: UIViewController {
    
    var viewModel: UserInfoEditorViewModelProtocol!
    var coordinator: UserInfoEditorCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    let saveButton = ButtonWithTouchSize()
    
    private var _view: UserInfoEditorView {
        return view as! UserInfoEditorView
    }
    
    override func loadView() {
        self.view = UserInfoEditorView()
    }
    
    var userDataIsFilled: Bool {
        return viewModel.userInfo.isFilled
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSelf()
    }
    
    private func configureSelf() {
        _view.dateButton.addTarget(self, action: #selector(userDataButtonDidTapped(sender:)), for: .touchUpInside)
        _view.timeButton.addTarget(self, action: #selector(userDataButtonDidTapped(sender:)), for: .touchUpInside)
        _view.locationButton.addTarget(self, action: #selector(userDataButtonDidTapped(sender:)), for: .touchUpInside)
        
        let saveText = R.string.localizable.saveButton()
        let saveFont = R.font.gilroyRegular(size: 12)!
        let textWidth = saveText.width(with: saveFont)
        saveButton.frame = CGRect(x: 0,
                                  y: 0,
                                  width: textWidth + 14,
                                  height: 24)
        saveButton.backgroundColor = R.color.tintColorDark()
        saveButton.titleLabel?.font = saveFont
        saveButton.setTitleColor(R.color.tintColorLight(), for: .normal)
        saveButton.setTitle(saveText, for: .normal)
        saveButton.setTitle(saveText, for: .selected)
        saveButton.setDefaultAreaPadding()
        saveButton.addTarget(self, action: #selector(saveButtonDidTapped), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: saveButton)
        navigationItem.rightBarButtonItem = menuBarItem
        
        saveButton.alpha = 0
        
        let info = viewModel.userInfo
        if info.isFilled {
            if let date = info.date {
                setBirthDate(date)
            }
            if let time = info.time {
                setBirthTime(time)
            }
            if let location = info.birthLocation {
                returnUserBirthLocation(location)
            }
            saveButton.isHidden = true
        }
    }
    
    // MARK: - Private methods

    private func setBirthDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: date)
        _view.setTitleToButton(button: _view.dateButton, title: dateString)
        
        viewModel.userInfo.date = date
        dataIsFilledCheck()
    }
    
    private func setBirthTime(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: date)
        _view.setTitleToButton(button: _view.timeButton, title: timeString)
        
        viewModel.userInfo.time = date
        dataIsFilledCheck()
    }
    
    private func dataIsFilledCheck() {
        if userDataIsFilled {
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                self?.saveButton.alpha = 1
            }
        }
    }
    
    // MARK: - UI elements actions
    
    @objc private func saveButtonDidTapped(sender: ButtonWithTouchSize) {
        sender.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        coordinator.showMainScreen()
    }
    
    @objc private func userDataButtonDidTapped(sender: UIButton) {
        sender.tapAnimation()
        
        switch sender {
        case _view.dateButton:
            showAlertWithDatePicker(title: R.string.localizable.datePickerTitleDate(),
                                    startDate: viewModel.userInfo.date,
                                    datePickerMode: .date,
                                    returnHandler: setBirthDate(_:))
        case _view.timeButton:
            showAlertWithDatePicker(title: R.string.localizable.datePickerTitleDate(),
                                    startDate: viewModel.userInfo.time,
                                    datePickerMode: .time,
                                    returnHandler: setBirthTime(_:))
        default:
            coordinator.openModuleWithOutput(.locationPickerContainer(output: self))
        }
    }
}

// MARK: - LocationPickerContainerOutput

extension UserInfoEditorViewController: LocationPickerContainerOutput {
    func returnUserBirthLocation(_ location: UserBirthLocation) {
        _view.setTitleToButton(button: _view.locationButton, title: location.title)
        
        viewModel.userInfo.birthLocation = location
        
        dataIsFilledCheck()
    }
}
