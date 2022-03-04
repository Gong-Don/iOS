//
//  SignInViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct SignInViewModel {
    var signInModel: SignInModel = SignInModel(email: "", password: "")
    var isValidInfo: [Bool] = [false, false]  // email, pwd
    
    func requestSignIn(successHandler: @escaping ()->Void, errorHandler: @escaping (String, String)->Void) {
        UserService.shared.signIn(model: self.signInModel, successHandler: successHandler, errorHandler: errorHandler)
    }
}

extension SignInViewModel {
    mutating func evaluateValidation(tag: Int, test: NSPredicate, textField: BindingTextField) {
        let validColor = textField.actionColor.cgColor
        let invalidColor = textField.defaultColor.cgColor
        
        self.isValidInfo[tag] = test.evaluate(with: textField.text)
        textField.layer.borderColor = self.isValidInfo[tag] ? validColor : invalidColor
    }
        
    mutating func textFieldDidChange(textField: BindingTextField) -> Bool {
        if textField.tag == 0 {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            self.evaluateValidation(tag: 0, test: emailTest, textField: textField)
            self.signInModel.email = textField.text ?? ""
            
        } else {
            let pwRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
            let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
            self.evaluateValidation(tag: 1, test: pwTest, textField: textField)
            self.signInModel.password = textField.text ?? ""
        }
        
        return self.isValidInfo[0] && self.isValidInfo[1] ? true : false
    }
}

extension SignInViewModel {
    func storeUserAccount() {
        if KeyChain.shared.readUser() == nil {
            KeyChain.shared.createUser(
                UserKeyChain(email: self.signInModel.email, password: self.signInModel.password)
            )
        } else if KeyChain.shared.deleteUser() {
            KeyChain.shared.createUser(
                UserKeyChain(email: self.signInModel.email, password: self.signInModel.password)
            )
        }
    }
    
    func deleteUserAccount() {
        _ = KeyChain.shared.deleteUser()
    }
    
    func checkUserAccount() -> UserKeyChain? {
        guard let user = KeyChain.shared.readUser() else {
            return nil
        }
        if user.password == "" {
            return nil
        } else {
            return user
        }
    }
}
