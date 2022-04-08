//
//  UIButton++.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/14.
//

import UIKit

extension UIButton {
    
    convenience init(color: UIColor, radius: CGFloat = 4) {
        self.init(frame: CGRect())
        
        self.backgroundColor = color
        self.layer.cornerRadius = radius
        
        self.addAction(UIAction(handler: { _ in
            self.backgroundColor = color.withAlphaComponent(0.8)
        }), for: .touchDown)
        self.addAction(UIAction(handler: { _ in
            self.backgroundColor = color
        }), for: .touchUpOutside)
        self.addAction(UIAction(handler: { _ in
            self.backgroundColor = color
        }), for: .touchUpInside)
    }
    
    func setDetailTitle(title: String, color: UIColor,
                        size: CGFloat = 15, weight: UIFont.Weight = .regular, hover: Bool = true) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)
        if hover { self.setTitleColor(color.withAlphaComponent(0.5), for: .highlighted) }
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.systemGray2.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowPath = nil
    }
    
    func changeButtonMode(isChange: Bool, color: UIColor) {
        if isChange {
            self.backgroundColor = color
            self.isEnabled = true
        } else {
            self.backgroundColor = color.withAlphaComponent(0.5)
            self.isEnabled = false
        }
    }
}
