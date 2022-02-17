//
//  SignUpModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct SignUpModel: Codable {
    let userId: Int
    let name: String
    let email: String
    let password: String
}
