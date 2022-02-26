//
//  APIConstants.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct APIConstants {
    static let baseURL = "http://choco-one.iptime.org:11104"
    // 로그인 URL
    static let userSignInURL = baseURL + "/api/user/signin"
    // 회원가입 URL
    static let userSignUpURL = baseURL + "/api/user/signup"
    // 이메일 인증 URL
    static let userAuthURL = baseURL + "/api/user/auth"
}
