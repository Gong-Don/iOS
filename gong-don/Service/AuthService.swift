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
    
    func emailAuth(model: AuthModel,
                   errorHandler: @escaping (String, String)->Void,
                   endHandler: @escaping (String, Bool)->Void) {
        let url = APIConstants.userAuthURL
        let body: Parameters = [ "email": model.email ]
        
        RequestData().sendRequest(url: url, body: body, model: AuthResponse.self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? AuthResponse {
                    endHandler(data.accessToken, true)
                    print("Email Auth Success!!")
                }
            case.pathErr:
                print("pathErr")
            case.requestErr(let message):
                errorHandler("잘못된 입력", "\(message)")
                print("requestErr: \(message)")
            case.serverErr:
                print("serverErr")
            case.networkFail:
                print("networkFail")
            }
        }
    }
}
