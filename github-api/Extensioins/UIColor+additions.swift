//
//  UIColor+additions.swift
//  Footbolico
//
//  Created by Kristoffer Anger on 2019-11-19.
//  Copyright © 2019 Kriang. All rights reserved.
//

import UIKit

let kPeachColor = 0xFFD4B2FF
let kYellowColor = 0xFFF6BDFF
let kGreenColor = 0xCEEDC7FF
let kTealColor = 0x86C8BCFF

extension UIColor {
    
    public convenience init(hex: Int) {
        let components = UIColor.componentsFrom(hexNumber: hex)
        self.init(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }
    
    private static func componentsFrom(hexNumber: Int) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        a = CGFloat(hexNumber & 0x000000ff) / 255
        return (r, g, b, a)
    }
}
