//
//  UserModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct SignInResponse: Decodable {
    var userId: Int
}

struct SignUpResponse: Decodable {
    let code: Int
    let message: String
}

struct SignInModel {
    var email: String
    var password: String
}

struct SignUpModel {
    var email: String
    var name: String
    var password: String
    var tokenId: String
}
