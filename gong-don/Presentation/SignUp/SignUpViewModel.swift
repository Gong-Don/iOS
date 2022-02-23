//
//  SignUpViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation
import UIKit

struct SignUpViewModel {
    var vc: UIViewController = UIViewController()
    var password: String = ""
    var isValidInfo: [Bool] = [false, false, false, false]  // email, pwd, pwd check, nickname
}

extension SignUpViewModel {
    func requestSignUp(name: String, email: String, password: String) {
        UserService.shared.signUp(name: name, email: email, password: password) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? SignUpModel {
                    UserDefaults.standard.set(data.email, forKey: "userEmail")
                    UserDefaults.standard.set(data.name, forKey: "userName")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    
                    print("Sign Up Success!!")
                }
            case.pathErr:
                print("pathErr")
            case.requestErr(let message):
                print("requestErr: \(message)")
            case.serverErr:
                print("serverErr")
            case.networkFail:
                print("networkFail")
            }
        }
    }
    
    mutating func evaluateText(test: NSPredicate, textField: BindingTextField) {
        let index: Int = textField.tag
        
        if test.evaluate(with: textField.text) {
            textField.layer.borderColor = textField.actionColor.cgColor
            self.isValidInfo[index] = true
        } else {
            textField.layer.borderColor = textField.defaultColor.cgColor
            self.isValidInfo[index] = false
        }
    }
    
    mutating func textFieldDidChange(textField: BindingTextField) -> Bool {
        switch textField.tag {
            
        case 0:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            
            self.evaluateText(test: emailTest, textField: textField)
            
        case 1:
            let pwRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
            let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
            
            self.evaluateText(test: pwTest, textField: textField)
            self.password = textField.text ?? ""
            
        case 2:
            if self.isValidInfo[1] && self.password == textField.text {
                textField.layer.borderColor = textField.actionColor.cgColor
                self.isValidInfo[2] = true
            } else {
                textField.layer.borderColor = textField.defaultColor.cgColor
                self.isValidInfo[2] = false
            }
            
        case 3:
            if let count = textField.text?.count {
                if 2 <= count && count <= 8 {
                    textField.layer.borderColor = textField.actionColor.cgColor
                    self.isValidInfo[3] = true
                } else {
                    textField.layer.borderColor = textField.defaultColor.cgColor
                    self.isValidInfo[3] = false
                }
            }
            
        default:
            return false
        }
        
        for valid in isValidInfo { if !valid { return false } }
        return true
    }
}
