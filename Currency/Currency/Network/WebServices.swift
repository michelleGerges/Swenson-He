//
//  WebServices.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation

struct WebServices {
    static let BaseUrl = "http://data.fixer.io/api/"
    
    struct Endpoints {
        static let SupportedSymbols = "symbols"
        static let LatestRates = "latest"
    }
    
    static let apiKey = "9659606938b62e881ef980f87fca1533"
}
