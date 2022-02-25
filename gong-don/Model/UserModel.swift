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
    let email: String
    let password: String
}

struct SignUpModel: Encodable {
    let name: String
    let email: String
    let password: String
}
