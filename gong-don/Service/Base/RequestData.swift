//
//  RequestData.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/22.
//

import Alamofire

struct RequestData {
    
    func sendRequest<T:Decodable>(url: String, body: Parameters, model: T.Type,
                                  completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json" ]
        
        let dataRequest = AF.request (
            url, method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: header
        )
        
        dataRequest.responseData { (response) in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.value else { return }
                completion(self.judgeStatus(status: statusCode, data: data, model: model))
            case .failure(let err):
                print(err)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus<T:Decodable>(status: Int, data: Data, model: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch status {
        case 200:
//            guard let decodedData = try? decoder.decode(model, from: data) else {
//                return .pathErr
//            }
            return .success
        case 400..<500:
            guard let decodedData = try? decoder.decode(ErrorModel.self, from: data) else {
                return .pathErr
            }
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
