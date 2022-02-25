//
//  SignUpViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation
import UIKit

struct SignUpViewModel {
    var password: String = ""
    var isValidInfo: [Bool] = [false, false, false, false]  // email, pwd, pwd check, nickname
    
    func requestSignUp(name: String, email: String, password: String, endHandler: @escaping ()->Void) {
        UserService.shared.signUp(name: name, email: email, password: password, endHandler: endHandler)
    }
}

extension SignUpViewModel {
    mutating func evaluateValidation(tag: Int, test: NSPredicate = NSPredicate(), textField: BindingTextField) {
        let validColor = textField.actionColor.cgColor
        let invalidColor = textField.defaultColor.cgColor
        
        if tag != 2 {
            self.isValidInfo[tag] = test.evaluate(with: textField.text)
        } else {
            self.isValidInfo[tag] = self.password == textField.text ? true : false
        }
       
        textField.layer.borderColor = self.isValidInfo[tag] ? validColor : invalidColor
    }
    
    mutating func textFieldDidChange(textField: BindingTextField) -> Bool {
        switch textField.tag {
        case 0: // email
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            self.evaluateValidation(tag: 0, test: emailTest, textField: textField)
            
        case 1: // password
            let pwRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
            let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
            self.evaluateValidation(tag: 1, test: pwTest, textField: textField)
            self.password = textField.text ?? ""
            
        case 2: // check password
            self.evaluateValidation(tag: 2, textField: textField)
            
        case 3: // nickname
            let nicknameRegEx = "[가-힣A-Za-z0-9_-]{2,8}"
            let nicknameTest = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
            self.evaluateValidation(tag: 3, test: nicknameTest, textField: textField)

        default: return false
        }
        
        for valid in isValidInfo { if !valid { return false } }
        
        return true
    }
}

extension SignUpViewModel {
    func storeUserAccount(email: String, password: String) {
        if KeyChain.shared.readUser() == nil {
            KeyChain.shared.createUser(User(email: email, password: password))
        } else if KeyChain.shared.deleteUser() {
            KeyChain.shared.createUser(User(email: email, password: password))
        }
    }
}
