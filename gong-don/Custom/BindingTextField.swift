//
//  UnderLineTextField.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/14.
//

import UIKit
import SnapKit
import Then

class BindingTextField: UITextField {
    
//    var errorlabel = UILabel().then {
//        $0.font = UIFont.systemFont(ofSize: 14)
//        $0.textColor = .systemRed
//    }
    
    var tryCount: Int = 0
    
    let textFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    let actionColor = UIColor.blue01
    let errorColor = UIColor.systemRed
    let defaultColor = UIColor.systemGray4
    
    var isWrong: Bool = false
        
    init() {
        super.init(frame: CGRect())
        
        self.setAction()
        self.setUpValue()
//        self.setUpView()
//        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action Setting Method
    func setAction() {
        
        self.addAction(UIAction(handler: { _ in
            self.tryCount += 1
        }), for: .editingDidEnd)
//        
//        // 회색? 빨간색?
//        self.addAction(UIAction(handler: { _ in
//            self.layer.borderColor =
//        }), for: .editingDidEnd)
    }
    
    // MARK: - View Setting Methods
    func setUpValue() {
        self.font = self.textFont
        self.clearButtonMode = .always
        self.autocapitalizationType = .none
        
        self.setUpBorder()
        self.setLeftPadding(10)
    }
    
//    func setUpView() {
//        self.addSubview(self.errorlabel)
//    }
//
//    func setConstraints() {
//        self.errorlabel.snp.makeConstraints { make in
//            make.top.equalTo(self).offset(55)
//            make.leading.equalTo(self)
//            make.trailing.equalTo(self)
//        }
//    }
    
    func setUpBorder() {
        let borderWidth: CGFloat = 1
        let cornerRadius: CGFloat = 4
        let borderColor: CGColor = self.defaultColor.cgColor

        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor
    }
    
    func setLeftPadding(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        
        self.leftView = paddingView
        self.leftViewMode = .always
    }

}

//extension BindingTextField {
//
//    func setUpErrorLabel(text: String) {
//        self.errorlabel.text = text
//        self.layer.borderColor = self.errorColor.cgColor
//
//        self.isWrong = true
//    }
//
//    func deleteErrorLabel() {
//        self.errorlabel.text = ""
//        self.layer.borderColor = self.actionColor.cgColor
//
//        self.isWrong = false
//    }
//}
