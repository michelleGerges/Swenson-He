//
//  RateTableCell.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import UIKit

protocol RateTableCellProtocol {
    var countryName: String? { get }
    var currencyRateFormatted: String { get }
}

class RateTableCell: UITableViewCell {
    
    @IBOutlet private var counrtyNameLabel: UILabel!
    @IBOutlet private var currencyRateLabel: UILabel!
    
    func configure(_ model: RateTableCellProtocol) {
        self.counrtyNameLabel.text = model.countryName
        self.currencyRateLabel.text = model.currencyRateFormatted
    }
}
