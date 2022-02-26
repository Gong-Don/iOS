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

struct SignInResponse: Decodable {
    let userId: Int
}

struct SignUpResponse: Decodable {
    let status: Int
    let message: String
}

struct SignInModel {
    var email: String
    var password: String
}

struct SignUpModel {
    var name: String
    var email: String
    var password: String
}
