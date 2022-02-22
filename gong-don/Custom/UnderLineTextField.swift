//
//  UnderLineTextField.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/14.
//

import UIKit
import SnapKit

class UnderLineTextField: UITextField {
    var textFont: UIFont = UIFont.systemFont(ofSize: 15)
    let bottomLine = CALayer()
    let requestLabel = UILabel()
        
    init() {
        super.init(frame: CGRect())
        self.font = textFont
        self.clearButtonMode = .always
        
        self.addAction(UIAction(handler: { _ in
            self.bottomLine.backgroundColor = UIColor.blue01.cgColor
        }), for: .editingDidBegin)
        self.addAction(UIAction(handler: { _ in
            self.bottomLine.backgroundColor = UIColor.systemGray5.cgColor
        }), for: .editingDidEnd)
        
        self.autocapitalizationType = .none
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
    
    func addRequestLabel(vc: UIViewController, text: String) {
        self.requestLabel.font = UIFont.systemFont(ofSize: 15)
        self.requestLabel.text = text
        self.requestLabel.textColor = .red
        vc.view.addSubview(self.requestLabel)
        self.requestLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    
    func deleteRequestLabel() {
        self.requestLabel.text = ""
    }
}
