//
//  AuthService.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/26.
//

import Foundation
import Alamofire

struct AuthService {
    static let shared = AuthService()
    
    func emailAuth(model: AuthModel) {
        let url = APIConstants.userAuthURL
        let body: Parameters = [ "email": model.email ]
        
        RequestData().sendRequest(url: url, body: body, model: AuthResponse.self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? AuthResponse {
                    print(data.token)
                    print("Email Auth Success!!")
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
