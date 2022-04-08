//
//  PostModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/10.
//

import Foundation

let Category = ["디자인", "IT", "미디어", "번역", "문서", "스터디"]

struct PostModel: Decodable {
    let postId: Int
    let wrtId: Int
    let wrtName: String
    let category: String
    let title: String
    let content: String
    let price: Int
    let likeCnt: Int
    let date: String
    let matchingStatus: Bool
    let fileUrls: [String]
}

struct AddPostModel {
    var category: String
    var content: String
    var fileUrls: [String]
    var price: Int
    var tags: [String]
    var title: String
    var wrtId: Int?
}

struct AddPostResponse: Decodable {
    let code: Int
    let message: String
}
