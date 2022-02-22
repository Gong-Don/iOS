//
//  SignUpViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct SignUpViewModel {
    let user: SignUpModel = SignUpModel(name: "", email: "", password: "")
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
}
