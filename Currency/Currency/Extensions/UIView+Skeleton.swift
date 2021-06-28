//
//  UIView+Skeleton.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import UIKit
import SkeletonView

extension UIView {
    func showSkeleton() {
        self.showAnimatedGradientSkeleton(usingGradient: SkeletonAppearance.default.gradient,
                                          animation: GradientDirection.topLeftBottomRight.slidingAnimation(),
                                          transition: SkeletonTransitionStyle.none)
    }
    
    func hideSkeleton() {
        self.hideSkeleton(reloadDataAfter: true,
                          transition: SkeletonTransitionStyle.crossDissolve(0.5))
    }
}

extension UITableView {
    
    func registerSkeleton(cellClass: UITableViewCell.Type) {
        self.register(UINib(nibName: cellClass.cellNibName, bundle: nil),
                      forCellReuseIdentifier: cellClass.cellSkeletonIdentifier)
    }
}

extension UITableViewCell {
    
    static var cellSkeletonIdentifier: String {
        return self.cellIdentifier + "+Skeleton"
    }
    
    var isSkeletonCell: Bool {
        return (self.reuseIdentifier == Self.cellSkeletonIdentifier)
    }
}
