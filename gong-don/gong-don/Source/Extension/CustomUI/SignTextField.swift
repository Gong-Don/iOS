//
//  SignTextField.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/14.
//

import UIKit

class SignTextField: UITextField {
    var textFont: UIFont = UIFont.systemFont(ofSize: 15)
    let bottomLine = CALayer()
    
    init() {
        super.init(frame: CGRect())
        self.font = textFont
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBottomLine() {
        self.bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height+10, width: self.frame.width, height: 1.5)
        self.bottomLine.backgroundColor = UIColor.systemGray6.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(self.bottomLine)
    }
}
