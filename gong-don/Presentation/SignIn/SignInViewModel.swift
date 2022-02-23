//
//  SignInViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct SignInViewModel {
    var isValidInfo: [Bool] = [false, false]  // email, pwd
}

extension SignInViewModel {
    func requestSignIn(email: String, password: String) -> Bool {
        var success: Bool = false
        UserService.shared.signIn(email: email, password: password) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? SignInModel {
                    success = true
                    UserDefaults.standard.set(data.email, forKey: "userEmail")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    print("Sign In Success!!")
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
        
        if textField.tag == 0 {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            
            self.isValidInfo[0] = emailTest.evaluate(with: textField.text)
            textField.layer.borderColor = self.isValidInfo[0] ? validColor : invalidColor
            
        } else {
            let pwRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
            let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
            
            self.isValidInfo[1] = pwTest.evaluate(with: textField.text)
            textField.layer.borderColor = self.isValidInfo[1] ? validColor : invalidColor
        }
        
        let returnValue = self.isValidInfo[0] && self.isValidInfo[1] ? true : false
        return returnValue
    }
}
