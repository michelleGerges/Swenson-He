//
//  Symbol.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation

class Symbol {
    
    var currencyName: String
    var countryName: String
    
    init(currencyName: String, countryName: String) {
        self.currencyName = currencyName
        self.countryName = countryName
    }
}
