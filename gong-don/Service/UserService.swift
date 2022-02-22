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
    
    func signIn(email: String,
                password: String,
                completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.userSignInURL
        let body: Parameters = [
            "email": email,
            "password":password
        ]
        
        let requestData: RequestData = RequestData()
        requestData.sendRequest(url: url, body: body, model: SignInModel.self, completion: completion)
    }
    
    func signUp(name: String,
                email: String,
                password: String,
                completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.userSignUpURL
        let body: Parameters = [
            "name": name,
            "email": email,
            "password":password
        ]
        
        let requestData: RequestData = RequestData()
        requestData.sendRequest(url: url, body: body, model: SignUpModel.self, completion: completion)
    }
}
