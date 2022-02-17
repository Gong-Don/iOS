//
//  GenericResponse.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

// 데이터를 JSON 데이터 포맷으로 자유롭게 Decoding, Encoding 할 수 있도록 해주는 protocol
struct GenericResponse<T: Codable>: Codable {
    var message: String
    var data: T?
    
    enum CondingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
