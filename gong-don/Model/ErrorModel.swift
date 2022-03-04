//
//  ErrorModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/04.
//

import Foundation

struct ErrorModel: Decodable {
    let code: Int
    let message: String
}
