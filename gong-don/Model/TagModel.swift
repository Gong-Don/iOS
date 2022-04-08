//
//  TagModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/24.
//

import Foundation

struct TagModel {
    var tagResponse: [String: Int]
}

struct TagList {
    static var shared = TagList()
    var tagList: [String] = []
}
