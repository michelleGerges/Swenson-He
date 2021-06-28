//
//  CalculatorViewController.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet private var baseCurrencyTextField: UITextField!
    @IBOutlet private var selectedCurrencyTextField: UITextField!
    
    @IBOutlet private var baseCurrencyLabel: UILabel!
    @IBOutlet private var selectedCurrencyLabel: UILabel!
    
    var baseCurrency: Symbol!
    var selecteCurrencyRate: Rate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.baseCurrencyTextField.placeholder = "1.0"
        self.selectedCurrencyTextField.placeholder = String(format: "%.2f", self.selecteCurrencyRate.rate)
        
        self.baseCurrencyLabel.text = baseCurrency.currencyName
        self.selectedCurrencyLabel.text = selecteCurrencyRate.currencyName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.baseCurrencyTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @IBAction func currencyTextChanged(_:Any) {
        
        guard let valueString = self.baseCurrencyTextField.text,
              let value = Double (valueString) else {
            self.selectedCurrencyTextField.text = nil
            return
        }
        
        self.selectedCurrencyTextField.text = String(format: "%.2f", value * self.selecteCurrencyRate.rate)
    }
}
