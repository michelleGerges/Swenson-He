//
//  GradientView.swift
//  Currency
//
//  Created by michelle gergs on 28/06/2021.
//

import UIKit

class GradientView: UIView {

    @IBInspectable var startColor: UIColor = UIColor.white {
        didSet {
            self.gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    @IBInspectable var endColor: UIColor = UIColor.black {
        didSet {
            self.gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }

    lazy var gradientLayer: CAGradientLayer = {

        let obj = CAGradientLayer ()
        
        obj.startPoint = CGPoint (x: 0, y: 0)
        obj.endPoint = CGPoint (x: 1, y: 1)

        return obj
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.gradientLayer.frame = self.bounds
    }
}
