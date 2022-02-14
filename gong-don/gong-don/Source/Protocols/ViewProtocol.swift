//
//  ViewProtocol.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/12.
//

import Foundation

protocol ViewProtocol {
    func setUpValue()       // 요소 내용 설정
    func setUpView()        // 뷰 구성요소 세팅
    func setConstraints()   // 뷰 구성요소 제약 설정
}
