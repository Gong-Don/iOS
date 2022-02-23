//
//  SignInViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation
import UIKit

struct SignInViewModel {
    var vc: UIViewController = UIViewController()
    var isValidInfo: [Bool] = [false, false]  // email, pwd
}

extension SignInViewModel {
    func requestSignIn(email: String, password: String) {
        UserService.shared.signIn(email: email, password: password) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? SignInModel {
                    UserDefaults.standard.set(data.email, forKey: "userEmail")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    
                    print("Sign In Success!!")
            
                    self.vc.pushView(VC: TabBarController())
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
//            textField.deleteErrorLabel()
        } else {
            textField.layer.borderColor = textField.defaultColor.cgColor
            self.isValidInfo[index] = false
//            textField.setUpErrorLabel(text: errorText)
        }
    }
    
    mutating func textFieldDidChange(textField: BindingTextField) -> Bool {
        if textField.tag == 0 {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            
            self.evaluateText(test: emailTest, textField: textField)
//            let errorText = textField.text == "" ? "이메일을 입력해주세요." : "올바른 이메일 주소를 입력해주세요."
            
        } else {
            let pwRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
            let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
            
            self.evaluateText(test: pwTest, textField: textField)
//            let errorText = textField.text == "" ? "비밀번호를 입력해주세요." : "영문+숫자+특수문자 조합 8자리 이상 입력해주세요."
//
        }
        
        let returnValue = self.isValidInfo[0] && self.isValidInfo[1] ? true : false
        return returnValue
    }
}
