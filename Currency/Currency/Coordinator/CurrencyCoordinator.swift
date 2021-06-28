//
//  CurrencyCoordinator.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation
import UIKit

class CurrencyCoordinator {
    
    let container = CurrenciesContainer()
    let navigationController = UINavigationController()
    
    func start() {
        let windowd = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
        windowd?.rootViewController = self.navigationController
        
        let vc = self.container.resolveCurrenciesRatesViewController()
        vc.currenciesCoordinator = self
        self.navigationController.setViewControllers([vc], animated: true)
    }
    
    private lazy var currenciesPicekrVC: CurrencyPickerViewController = {
        return self.container.resolveCurrenciesPickerViewController()
    } ()
}

extension CurrencyCoordinator: CurrenciesCoordinator {
    
    func navigateToCurrenciesPicker(delegate: CurrencyPickerViewControllerDelegate) {
        self.currenciesPicekrVC.delegate = delegate
        self.navigationController.presentPanModal(self.currenciesPicekrVC)
    }
    
    func navigateToCalculator(base: Symbol, selectedCurrency: Rate) {
        let vc = self.container.resolveCalculatorViewController()
        vc.baseCurrency = base
        vc.selecteCurrencyRate = selectedCurrency
        self.navigationController.show(vc, sender: self)
    }
}
