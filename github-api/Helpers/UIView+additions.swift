//
//  UIView+additions.swift
//  Footbolico
//
//  Created by Kristoffer Anger on 2019-11-19.
//  Copyright © 2019 Kriang. All rights reserved.
//

import UIKit

extension UIView {
    
    func elevate(height: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.shadowRadius = height
        self.layer.shadowOpacity = 0.2
    }
}
