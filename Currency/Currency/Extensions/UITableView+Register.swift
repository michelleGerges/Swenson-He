//
//  UITableView+Register.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNibFor(cellClass: UITableViewCell.Type) {
        self.register(UINib(nibName: cellClass.cellNibName, bundle: nil),
                      forCellReuseIdentifier: cellClass.cellIdentifier)
    }
    
    func registerClassFor(cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.cellIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type) -> T {
        guard let cell: T = self.dequeueReusableCell(withIdentifier: cellClass.cellIdentifier) as? T else {
            fatalError("no \(cellClass.cellIdentifier) registered")
        }
        return cell
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, indexPath: IndexPath) -> T {
        guard let cell: T = self.dequeueReusableCell(withIdentifier: cellClass.cellIdentifier,
                                                     for: indexPath) as? T else {
            fatalError("no \(cellClass.cellIdentifier) registered")
        }
        return cell
    }
}

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return NSStringFromClass(Self.self)
    }
    
    static var cellNibName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
}
