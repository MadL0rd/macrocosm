//
//  TodayViewModelProtocol.swift
//  MacroCosm
//
//  Created by Антон Текутов on 30.03.2021.
//

protocol TodayViewModelProtocol: class {
    
    var zodiacPredictionWillChange: (() -> Void)? { get set }
    var zodiacPredictionDidChanged: ((ZodiacPrediction) -> Void)? { get set }

    func loadData()
}
