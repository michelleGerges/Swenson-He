//
//  NetworkManager+Currency.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation
import PromiseKit

extension NetworkManager: CurrenciesServicesProtocol {
    func loadAllCurrencies() -> Promise<SymbolsResponse> {
        return self.currencyProvider.requestPromise(CurrencyAPIs.allCurrenies)
    }
    
    func loadLatestRates(baseCurrency: String) -> Promise<RatesResponse> {
        return self.currencyProvider.requestPromise(CurrencyAPIs.latestRates(baseCurrency: baseCurrency))
    }
}
