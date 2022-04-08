//
//  TagService.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/24.
//

import Foundation
import Alamofire

struct TagService {
    static let shared = TagService()
    
    func getTagList(successHandler: @escaping ([String: Int])->Void) {
        let url = APIConstants.tagURL
        
        RequestData().sendRequest(url: url, body: nil, method: .get, model: [String: Int].self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? [String: Int] {
                    print("Get Tag List Success!!")
                    successHandler(data)
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
