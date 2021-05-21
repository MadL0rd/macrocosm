//  CompletionTypealiases.swift
//  MacroCosm
//
//  Created by Антон Текутов on 31.03.2021.
//

import Alamofire

typealias GetPredictionCompletion = (Result<GetDaylyPredictionRequestResult, NetworkServiceError>) -> Void
typealias GetDateCompletion = (Result<GetDateRequestResult, NetworkServiceError>) -> Void
