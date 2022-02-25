//
//  NetworkResult.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

enum NetworkResult<T>{
    case success
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
