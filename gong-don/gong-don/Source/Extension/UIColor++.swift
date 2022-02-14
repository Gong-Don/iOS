//
//  UIColor++.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/13.
//

import UIKit

extension UIColor {
    
    class var blue01: UIColor {
        return UIColor.systemBlue
    }
    
    class var blue02: UIColor {
        return UIColor(r: 64, g: 95, b: 157)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
