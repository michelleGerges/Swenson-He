//
//  CurrencyAPIs.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Moya

enum CurrencyAPIs {
    case allCurrenies
    case latestRates(baseCurrency: String)
}

extension CurrencyAPIs: TargetType {
    
    var baseURL: URL {
        guard let url = URL (string: WebServices.BaseUrl) else {
            fatalError("invalid base url")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .allCurrenies:
            return WebServices.Endpoints.SupportedSymbols
        case .latestRates:
            return WebServices.Endpoints.LatestRates
        }
    }
    
    var method: Method {
        switch self {
        case .allCurrenies:
            return .get
        case .latestRates:
            return .get
        }
    }
    
    var sampleData: Data {
        Data ()
    }
    
    var task: Task {
        switch self {
        case .allCurrenies:
            return Task.requestParameters(parameters: ["access_key": WebServices.apiKey],
                                          encoding: URLEncoding.default)
        case .latestRates(let baseCurrency):
            return Task.requestParameters(parameters: ["access_key": WebServices.apiKey,
                                                       "base": baseCurrency],
                                          encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
