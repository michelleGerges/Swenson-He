//
//  CurrenciesViewController.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import UIKit
import PromiseKit
import SkeletonView

protocol CurrenciesRatesViewModelrProtocol {
    func getLatestRates(baseCurrency: String) -> Promise<[Rate]>
}

protocol CurrenciesCoordinator {
    func navigateToCurrenciesPicker(delegate: CurrencyPickerViewControllerDelegate)
    func navigateToCalculator(base: Symbol, selectedCurrency: Rate)
}

class CurrenciesViewController: UIViewController {

    @IBOutlet private var selectedCurrencyView: UIView!
    @IBOutlet private var selectedCurrencyLabel: UILabel!
    @IBOutlet private var ratesTableView: UITableView!
    
    var currenciesRatesViewModel: CurrenciesRatesViewModelrProtocol!
    var currenciesCoordinator: CurrenciesCoordinator!
    
    var rates = [Rate]()
    var selectedBaseCurency: Symbol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
    }
    
    func setupTableView() {
        self.ratesTableView.estimatedRowHeight = 100.0
        self.ratesTableView.dataSource = self
        self.ratesTableView.delegate = self
        self.ratesTableView.registerNibFor(cellClass: RateTableCell.self)
        self.ratesTableView.registerSkeleton(cellClass: RateTableCell.self)
    }
    
    func loadRatesForCurrency(_ symbol: Symbol) {
        
        self.view.showSkeleton()
        firstly {
            self.currenciesRatesViewModel.getLatestRates(baseCurrency: symbol.currencyName)
        }.done {
            self.rates = $0
            self.ratesTableView.reloadData()
        }.catch {
            self.alertError($0.message)
        }.finally {
            self.view.hideSkeleton()
        }
    }
    
    @IBAction func selectBaseCurrencyAction(_:UIButton) {
        self.currenciesCoordinator.navigateToCurrenciesPicker(delegate: self)
    }
}

extension CurrenciesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let baseCurrency = self.selectedBaseCurency else { return }
        self.currenciesCoordinator.navigateToCalculator(base: baseCurrency,
                                                        selectedCurrency: self.rates[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CurrenciesViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: RateTableCell.self)
        cell.configure(self.rates[indexPath.row])
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return RateTableCell.cellSkeletonIdentifier
    }
}

extension CurrenciesViewController: CurrencyPickerViewControllerDelegate {
    
    func currencyPickerViewController(_ viewController: CurrencyPickerViewController, didSelect symbol: Symbol) {
        
        self.selectedCurrencyLabel.text = symbol.currencyName
        self.ratesTableView.tableHeaderView = self.selectedCurrencyView
        self.selectedBaseCurency = symbol
        self.loadRatesForCurrency(symbol)
    }
}
