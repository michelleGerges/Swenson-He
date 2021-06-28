//
//  CurrencyPickerViewController.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import UIKit
import PanModal
import PromiseKit
import SkeletonView

protocol CurrenciesPickerViewModelrProtocol {
    func getAllCurrenices() -> Promise<[Symbol]>
}

protocol CurrencyPickerViewControllerDelegate {
    func currencyPickerViewController(_ viewController: CurrencyPickerViewController,
                                      didSelect symbol: Symbol)
}

class CurrencyPickerViewController: UIViewController {

    @IBOutlet private var currenciesTableView: UITableView!

    var currenciesViewModel: CurrenciesPickerViewModelrProtocol!
    var delegate: CurrencyPickerViewControllerDelegate?
    
    var symbols = [Symbol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.symbols.isEmpty {
            self.loadCurrencies()
        }
    }
    
    func setupTableView() {
        self.currenciesTableView.estimatedRowHeight = 100.0
        self.currenciesTableView.dataSource = self
        self.currenciesTableView.delegate = self
        self.currenciesTableView.registerNibFor(cellClass: CurrencyPickerTableCell.self)
        self.currenciesTableView.registerSkeleton(cellClass: CurrencyPickerTableCell.self)
    }
    
    func loadCurrencies() {
        self.currenciesTableView.showSkeleton()
        firstly {
            self.currenciesViewModel.getAllCurrenices()
        }.done {
            self.symbols = $0
            self.currenciesTableView.reloadData()
        }.catch {
            self.alertError($0.message)
            self.dismiss(animated: true, completion: nil)
        }.finally {
            self.view.hideSkeleton(reloadDataAfter: true, transition: SkeletonTransitionStyle.none)
        }
    }
}

extension CurrencyPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.delegate?.currencyPickerViewController(self, didSelect: self.symbols[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CurrencyPickerViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symbols.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellClass: CurrencyPickerTableCell.self)
        cell.configure(self.symbols[indexPath.row])
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CurrencyPickerTableCell.cellSkeletonIdentifier
    }
}

extension CurrencyPickerViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var allowsTapToDismiss: Bool {
        return true
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(44.0)
    }
}
