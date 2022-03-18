//
//  APIConstants.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/17.
//

import Foundation

struct APIConstants {
    static let baseURL = "http://choco-one.iptime.org:11104"
    // 로그인
    static let userSignInURL = baseURL + "/api/user/signin"
    // 회원가입
    static let userSignUpURL = baseURL + "/api/user/signup"
    // 이메일 인증
    static let userAuthURL = baseURL + "/api/user/auth"
    // 모든 글 가져오기
    static let getPostListURL = baseURL + "/api/post/all"
    // 카테고리 글 가져오기
    static let getCategoryPostListURL = baseURL + "/api/post/category"
    // 글 등록
    static let postURL = baseURL + "/api/post"
}
