//
//  SignUpViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct SignUpViewModel {
    var password: String = ""
    var isValidInfo: [Bool] = [false, false, false, false]  // email, pwd, pwd check, nickname
}

extension SignUpViewModel {
    func requestSignUp(name: String, email: String, password: String) -> Bool {
        var success: Bool = false
        UserService.shared.signUp(name: name, email: email, password: password) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? SignUpModel {
                    success = true
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
        return success
    }
    
    mutating func textFieldDidChange(textField: BindingTextField) -> Bool {
        let validColor = textField.actionColor.cgColor
        let invalidColor = textField.defaultColor.cgColor
        
        func setBorderColor(tag: Int) {
            textField.layer.borderColor = self.isValidInfo[tag] ? validColor : invalidColor
        }
        
        switch textField.tag {
        case 0: // email
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            
            self.isValidInfo[0] = emailTest.evaluate(with: textField.text)
            setBorderColor(tag: 0)
            
        case 1: // password
            let pwRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
            let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
            
            self.password = textField.text ?? ""
            self.isValidInfo[1] = pwTest.evaluate(with: textField.text)
            setBorderColor(tag: 1)
            
        case 2: // check password
            self.isValidInfo[2] = self.isValidInfo[1] && self.password == textField.text ? true : false
            setBorderColor(tag: 2)
            
        case 3: // nickname
            if let count = textField.text?.count {
                self.isValidInfo[3] = 2 <= count && count <= 8 ? true : false
                setBorderColor(tag: 3)
            }

        default: return false
        }
        
        for valid in isValidInfo { if !valid { return false } }
        
        return true
    }
}
