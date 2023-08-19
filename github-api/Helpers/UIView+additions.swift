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
    func addSubviewPinnedToEdges(_ subview: UIView, top: CGFloat? = 0, bottom: CGFloat? = 0, leading: CGFloat? = 0, trailing: CGFloat? = 0, additionalConstraints: [NSLayoutConstraint]? = nil, useSafeArea: Bool = false) {
    
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        var layoutConstraints = [NSLayoutConstraint]()
        if let topValue = top {
            let topConstraint = useSafeArea ? subview.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: topValue) : subview.topAnchor.constraint(equalTo: self.topAnchor, constant: topValue)
            layoutConstraints.append(topConstraint)
        }
        if let bottomValue = bottom {
            let bottomConstraint = useSafeArea ? subview.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -bottomValue) : subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottomValue)
            layoutConstraints.append(bottomConstraint)
        }
        if let leadingValue = leading {
            let leadingConstraint = useSafeArea ? subview.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: leadingValue) : subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingValue)
            layoutConstraints.append(leadingConstraint)
        }
        if let trailingValue = trailing {
            let trailingConstraint = useSafeArea ? subview.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -trailingValue) : subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -trailingValue)
            layoutConstraints.append(trailingConstraint)
        }
        if top == nil, bottom == nil {
            let centerYConstraint = useSafeArea ? subview.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor) : subview.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            layoutConstraints.append(centerYConstraint)
        }
        if leading == nil, trailing == nil {
            let centerXConstraint = useSafeArea ? subview.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor) : subview.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            layoutConstraints.append(centerXConstraint)
        }
        if let additionalConstraints = additionalConstraints {
            layoutConstraints.append(contentsOf: additionalConstraints)
        }
        NSLayoutConstraint.activate(layoutConstraints)
    }
}
