//
//  TodayViewController.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

import UIKit
import GoogleMobileAds

final class TodayViewController: UIViewController {

    var viewModel: TodayViewModelProtocol!
    var coordinator: TodayCoordinatorProtocol!
    
    var predictionBlocks = [PredictionBlock]()
    var rewardedAd: GADRewardedAd?
    
    private var _view: TodayView {
        return view as! TodayView
    }

    override func loadView() {
        self.view = TodayView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        
        _view.predictionsTableView.dataSource = self
        _view.predictionsTableView.delegate = self

        viewModel.zodiacPredictionWillChange = { [ weak self ] in
            self?._view.setLoadingState(isActive: true, animated: false)
        }
        
        viewModel.zodiacPredictionDidChanged = { [ weak self ] prediction in
            DispatchQueue.main.async {
                self?.setPrediction(prediction)
            }
        }
        viewModel.loadData()
        
        // rewarded ads test
        loadAd()
    }
    
    private func loadAd() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313",
                           request: request) { [ weak self ] ad, error in
            guard error == nil
            else {
                print(error!)
                return
            }
            ad?.fullScreenContentDelegate = self
            self?.rewardedAd = ad
        }
    }
    
    private func showAd() {
        guard let ad = rewardedAd
        else { return }
        
        ad.present(fromRootViewController: self) {
            print("Reward user")
        }
    }
    
    private func setPrediction(_ prediction: ZodiacPrediction) {
        _view.setLoadingState(isActive: false)
        
        _view.imageView.setDefaultLoadingInicator()
        _view.imageView.sd_setImage(with: prediction.zodiacImageUrl, completed: nil)
        _view.infoLabel.text = prediction.prediction.info
        
        predictionBlocks = prediction.prediction.predictionBlocks
        _view.predictionsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension TodayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictionBlocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PredictionTableViewCell.identifier, for: indexPath) as! PredictionTableViewCell
        
        cell.setContent(predictionBlocks[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TodayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("kek")
        tableView.cellForRow(at: indexPath)?.tapAnimation()
        showAd()
    }
}

// MARK: - GADFullScreenContentDelegate

extension TodayViewController: GADFullScreenContentDelegate {
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print(error)
    }
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadAd()
    }
}
