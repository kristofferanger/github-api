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
    
    /** convenience method to add subview with constraints with one method. Default inset value is 0 on each side, when set to nil the constraint will be ignored, when set to nil on oposite sides the subview will be centered
     */
    func addSubviewPinnedToEdges(_ subview: UIView, top: CGFloat? = 0, bottom: CGFloat? = 0, leading: CGFloat? = 0, trailing: CGFloat? = 0, additionalConstraints: [NSLayoutConstraint]? = nil) {
        
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        var layoutConstraints = [NSLayoutConstraint]()
        
        if let topValue = top {
            layoutConstraints.append(subview.topAnchor.constraint(equalTo: self.topAnchor, constant: topValue))
        }
        if let bottomValue = bottom {
            layoutConstraints.append(subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottomValue))
        }
        if let leadingValue = leading {
            layoutConstraints.append(subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingValue))
        }
        if let trailingValue = trailing {
            layoutConstraints.append(subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -trailingValue))
        }
        if top == nil, bottom == nil {
            layoutConstraints.append(subview.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        }
        if leading == nil, trailing == nil {
            layoutConstraints.append(subview.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        }
        if let additionalConstraints = additionalConstraints {
            layoutConstraints.append(contentsOf: additionalConstraints)
        }
        NSLayoutConstraint.activate(layoutConstraints)
    }
}
