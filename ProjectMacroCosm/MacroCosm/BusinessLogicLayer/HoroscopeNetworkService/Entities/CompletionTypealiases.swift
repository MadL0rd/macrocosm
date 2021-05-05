//  CompletionTypealiases.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Alamofire

typealias GetSettingsCompletion = (Result<GetDaylyPredictionRequestResult, NetworkServiceError>) -> Void
