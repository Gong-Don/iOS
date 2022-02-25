//
//  UserModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct ErrorModel: Decodable {
    let code: Int
    let message: String
}

struct UserModel: Decodable {
    let userId: Int
}

struct SignInModel: Encodable {
    var email: String
    var password: String
}

struct SignUpModel: Encodable {
    var name: String
    var email: String
    var password: String
}
