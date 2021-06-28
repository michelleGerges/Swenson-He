//
//  CurrencyPickerTableCell.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import UIKit

protocol CurrencyPickerTableCellProtocol {
    var currancyTitle: String { get }
}

class CurrencyPickerTableCell: UITableViewCell {

    @IBOutlet private var currancyTitleLabel: UILabel!
    
    func configure(_ model: CurrencyPickerTableCellProtocol) {
        self.currancyTitleLabel.text = model.currancyTitle
    }
}
