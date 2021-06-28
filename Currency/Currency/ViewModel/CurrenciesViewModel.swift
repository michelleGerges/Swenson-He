//
//  CurrenciesViewModel.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import PromiseKit

protocol CurrenciesServicesProtocol {
    func loadAllCurrencies() -> Promise<SymbolsResponse>
    func loadLatestRates(baseCurrency: String) -> Promise<RatesResponse>
}

class CurrenciesViewModel: NSObject {
    var apiClient: CurrenciesServicesProtocol!
}

extension CurrenciesViewModel: CurrenciesRatesViewModelrProtocol {
    
    func getLatestRates(baseCurrency: String) -> Promise<[Rate]> {
        
        return Promise <[Rate]> { resolver in
            
            firstly {
                self.apiClient.loadLatestRates(baseCurrency: baseCurrency)
            }.done { response in
                let rates = response.rates?.map({
                    Rate (currencyName: $0, rate: $1)
                })
                resolver.fulfill(rates ?? [])
            }.catch {
                resolver.reject($0)
            }
        }
    }
}

extension CurrenciesViewModel: CurrenciesPickerViewModelrProtocol {
    
    func getAllCurrenices() -> Promise<[Symbol]> {
        
        return Promise <[Symbol]> { resolver in
            
            firstly {
                self.apiClient.loadAllCurrencies()
            }.done { response in
                let symbols = response.symbols?.map({
                    Symbol (currencyName: $0, countryName: $1)
                })
                resolver.fulfill(symbols ?? [])
            }.catch {
                resolver.reject($0)
            }
        }
    }
}
