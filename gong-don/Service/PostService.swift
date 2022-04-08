//
//  PostService.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/10.
//

import Foundation
import Alamofire

struct PostService {
    static let shared = PostService()
    
    // MARK: - Get Post List Service
    func getPostList(category: String, successHandler: @escaping ([PostModel])->Void) {
        var url = APIConstants.getPostListURL
        if category != "ALL" {
            url = APIConstants.getCategoryPostListURL + "/\(category)"
        }
        
        RequestData().sendRequest(url: url, body: nil, method: .get, model: [PostModel].self) { response in
            switch(response) {
            case.success(let data):
                if let data = data as? [PostModel] {
                    print("Get Post List Success!!")
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
    
    // MARK: - Add Post Service
    func addPost(model: AddPostModel) {
        let url = APIConstants.postURL
        
        let body: Parameters = [
            "category": model.category,
            "content": model.content,
            "price": model.price,
            "title": model.title,
            "wrtId": model.wrtId!,
            "tags": model.tags
        ]
        
        RequestData().sendRequest(url: url, body: body, method: .post, model: AddPostResponse.self) { response in
            switch(response) {
            case.success(let message):
                print("Add Post Success!!")
                print("\(message)")
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


