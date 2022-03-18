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
    
    let requestErrTitle = "잘못된 입력"
    let networkFail = (title: "네트워크 연결 끊김", message: "연결을 확인하고 다시 시도하세요.")
    
    // MARK: - Sign In Service
    func signIn(model: SignInModel, errorHandler: @escaping (String, String)->Void, successHandler: @escaping (Int)->Void) {
        let url = APIConstants.userSignInURL
        let body: Parameters = [
            "email": model.email,
            "password": model.password
        ]
        
        RequestData().sendRequest(url: url, body: body, method: .post, model: SignInResponse.self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? SignInResponse {
                    print("Sign In Success!!")
                    successHandler(data.userId)
                }
            case.pathErr:
                print("pathErr")
            case.requestErr(let message):
                print("requestErr: \(message)")
                errorHandler(self.requestErrTitle, "\(message)")
            case.serverErr:
                print("serverErr")
            case.networkFail:
                print("networkFail")
                errorHandler(self.networkFail.title, self.networkFail.message)
            }
        }
    }
    
    // MARK: - Sign Up Service
    func signUp(model: SignUpModel, successHandler: @escaping ()->Void, errorHandler: @escaping (String, String)->Void) {
        let url = APIConstants.userSignUpURL

        let body: Parameters = [
            "email": model.email,
            "name": model.name,
            "password": model.password,
            "tokenId": model.tokenId
        ]
        
        RequestData().sendRequest(url: url, body: body, method: .post, model: SignUpResponse.self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? SignUpResponse {
                    print("Sign Up Success!!")
                    print(data.message)
                    successHandler()
                }
            case.pathErr:
                print("pathErr")
            case.requestErr(let message):
                print("requestErr: \(message)")
                errorHandler(self.requestErrTitle, "\(message)")
            case.serverErr:
                print("serverErr")
            case.networkFail:
                print("networkFail")
                errorHandler(self.networkFail.title, self.networkFail.message)
            }
        }
    }
}
