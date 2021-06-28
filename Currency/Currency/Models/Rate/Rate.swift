//
//  Rate.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation

class Rate {
    
    var currencyName: String
    var rate: Double
    
    init(currencyName: String, rate: Double) {
        self.currencyName = currencyName
        self.rate = rate
    }
}
