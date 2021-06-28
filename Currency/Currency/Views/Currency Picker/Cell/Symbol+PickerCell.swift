//
//  Symbol+PickerCell.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation

extension Symbol: CurrencyPickerTableCellProtocol {
    var currancyTitle: String {
        return self.countryName + " - " + self.currencyName
    }
}
