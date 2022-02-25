//
//  UserService.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation
import Alamofire

struct UserService {
    static let shared = UserService()
    
    
    
    // MARK: - Sign In Service
    func signIn(model: SignInModel, endHandler: @escaping ()->Void) {
        let url = APIConstants.userSignInURL
        let body: Parameters = [
            "email": model.email,
            "password": model.password
        ]
        
        RequestData().sendRequest(url: url, body: body, model: UserModel.self) { response in
            switch(response) {
            case.success:
//                if let data = data as? UserModel {
//                    isNetworking = true
//                    UserDefaults.standard.set(data.email, forKey: "userEmail")
//                    UserDefaults.standard.set(data.password, forKey: "userPassword")
//                    UserDefaults.standard.set(true, forKey: "isLogin")
//                    print("Sign In Success!!")
//                }
                print("Sign In Success!!")
                endHandler()
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
    
    // MARK: - Sign Up Service
    func signUp(model: SignUpModel, endHandler: @escaping ()->Void) {
        let url = APIConstants.userSignUpURL
        let body: Parameters = [
            "name": model.name,
            "email": model.email,
            "password": model.password
        ]
        
        RequestData().sendRequest(url: url, body: body, model: UserModel.self) { response in
            switch(response) {
            case.success:
//                if let data = data as? UserModel {
//                    isNetworking = true
//                    UserDefaults.standard.set(data.email, forKey: "userEmail")
//                    UserDefaults.standard.set(data.name, forKey: "userName")
//                    UserDefaults.standard.set(true, forKey: "isLogin")
//                    print("Sign Up Success!!")
//                }
                print("Sign Up Success!!")
                endHandler()
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
