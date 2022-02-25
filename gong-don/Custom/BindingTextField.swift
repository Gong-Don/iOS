//
//  UnderLineTextField.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/14.
//

import UIKit

class BindingTextField: UITextField {
    let textFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    let actionColor = UIColor.blue01
    let errorColor = UIColor.systemRed
    let defaultColor = UIColor.systemGray4
        
    init() {
        super.init(frame: CGRect())
        self.setUpValue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Setting Methods
extension BindingTextField {
    func setUpValue() {
        self.font = self.textFont
        self.clearButtonMode = .always
        self.autocapitalizationType = .none
        
        self.setUpBorder()
        self.setLeftPadding(10)
    }
    
    func setUpBorder() {
        let borderWidth: CGFloat = 1
        let cornerRadius: CGFloat = 4

        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = self.defaultColor.cgColor
    }
    
    func setLeftPadding(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        
        self.leftView = paddingView
        self.leftViewMode = .always
    }

}
