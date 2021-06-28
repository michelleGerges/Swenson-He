//
//  NetworkManager.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation
import Moya
import Moya_ObjectMapper

class NetworkManager: NSObject {

    lazy var currencyProvider: MoyaProvider<CurrencyAPIs> = {
        return MoyaProvider <CurrencyAPIs> (plugins: [NetworkLoggerPlugin.networkLogger])
    } ()
}
