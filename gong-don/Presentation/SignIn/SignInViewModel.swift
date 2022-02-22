//
//  SignInViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation
import UIKit

struct SignInViewModel {
    let signIn: SignInModel = SignInModel(email: "", password: "")
}

extension SignInViewModel {
    func requestSignIn(vc: SignInView, email: String, password: String) {
        UserService.shared.signIn(email: email, password: password) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? SignInModel {
                    UserDefaults.standard.set(data.email, forKey: "userEmail")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    
                    print("Sign In Success!!")
            
                    vc.pushView(VC: TabBarController())
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
