//
//  AuthModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/26.
//

import Foundation

struct AuthResponse: Decodable {
    var accessToken: String
}

struct AuthModel {
    var email: String
}
