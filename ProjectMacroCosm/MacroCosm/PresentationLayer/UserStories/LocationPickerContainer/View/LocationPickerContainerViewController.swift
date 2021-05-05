//
//  LocationPickerContainerViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 01.04.2021.
//

import UIKit
import LocationPicker

final class LocationPickerContainerViewController: UIViewController {

    var viewModel: LocationPickerContainerViewModelProtocol!
    var coordinator: LocationPickerContainerCoordinatorProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIStyleManager.setUIBarButtonItemsDefault()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIStyleManager.setUIBarButtonItemsClear()
    }
    
    private var _view: LocationPickerContainerView {
        return view as! LocationPickerContainerView
    }

    override func loadView() {
        self.view = LocationPickerContainerView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        _view.closeButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        setupLicationPicker()
    }
    
    private func setupLicationPicker() {
        // This location picker break custom configuration of navigation controller
        // so resolution is to put it into container view
        
        let locationPicker = LocationPickerViewController()

        // button placed on right bottom corner
        locationPicker.showCurrentLocationButton = true // default: true

        // ignored if initial location is given, shows that location instead
        locationPicker.showCurrentLocationInitially = true // default: true

        locationPicker.mapType = .standard // default: .Hybrid

        // for searching, see `MKLocalSearchRequest`'s `region` property
        locationPicker.useCurrentLocationAsHint = true // default: false

        locationPicker.searchBarPlaceholder = "Search places" // default: "Search or enter an address"

        locationPicker.searchHistoryLabel = "Previously searched" // default: "Search History"

        // optional region distance to be used for creation region when user selects place from search results
        locationPicker.resultRegionDistance = 500 // default: 600

        locationPicker.completion = { [ weak self ] location in
            guard let location = location
            else { return }
            UIStyleManager.setUIBarButtonItemsClear()
            let birthLocation = UserBirthLocation(title: location.name ?? location.address,
                                                  latitude: location.location.coordinate.latitude,
                                                  longitude: location.location.coordinate.longitude)
            self?.viewModel.output?.returnUserBirthLocation(birthLocation)
            self?.coordinator.dismiss()
        }

        let navController = UINavigationController(rootViewController: locationPicker)
        addChildViewControllerToView(vc: navController, into: _view.containerView)
    }
    
    // MARK: - UI elements actions
    
    @objc private func backButtonTapped(sender: UIButton) {
        UIStyleManager.setUIBarButtonItemsClear()
        coordinator.dismiss()
    }
}
