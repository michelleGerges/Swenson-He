//
//  Rate+RateCell.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation

extension Rate: RateTableCellProtocol {
    var countryName: String? {
        return self.currencyName
    }
    
    var currencyRateFormatted: String {
        return String(format: "%.2f", self.rate)
    }
}
