//
//  UserModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct ErrorModel: Codable {
    let code: Int
    let message: String
}

struct SignUpModel: Codable {
    let name: String
    let email: String
    let password: String
}

struct SignInModel: Codable {
    let email: String
    let password: String
}
