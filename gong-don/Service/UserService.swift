//
//  UserService.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation
import Alamofire

protocol UserServiceProtocol {
    
}

struct UserService {
    static let userShared = UserService()
    
    func signIn(email: String,
                password: String,
                completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let url = APIConstants.userSignInURL
        let header: HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization": UserDefaults.standard.string(forKey: "token") ?? ""
        ]
        let body: Parameters = [
            "email": email,
            "password":password
        ]
        
        let dataRequest = AF.request(url, method: .post, parameters: body,
                                     encoding: URLEncoding.default, headers: header)
        
        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                guard let data = response.value else {
                    return
                }
                completion(judgeSignInData(status: statusCode, data: data))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeSignInData(status: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<SignInModel>.self, from: data) else {
            return .pathErr
        }
        
        switch status {
        case 200:
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
