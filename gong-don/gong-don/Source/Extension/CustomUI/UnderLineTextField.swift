//
//  UnderLineTextField.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/14.
//

import UIKit

class UnderLineTextField: UITextField {
    var textFont: UIFont = UIFont.systemFont(ofSize: 15)
    let bottomLine = CALayer()
        
    init() {
        super.init(frame: CGRect())
        self.font = textFont
        self.addAction(UIAction(handler: { _ in
            self.bottomLine.backgroundColor = UIColor.blue02.cgColor
        }), for: .editingDidBegin)
        self.addAction(UIAction(handler: { _ in
            self.bottomLine.backgroundColor = UIColor.systemGray5.cgColor
        }), for: .editingDidEnd)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBottomLine() {
        self.bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height+10, width: self.frame.width, height: 1.5)
        self.bottomLine.backgroundColor = UIColor.systemGray5.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(self.bottomLine)
    }
}
