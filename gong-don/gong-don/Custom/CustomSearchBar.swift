//
//  SearchBar.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/15.
//

import UIKit

class CustomSearchBar: UISearchBar {
    init() {
        super.init(frame: CGRect())
        
        self.placeholder = "검색어 입력"
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.blue01.cgColor
        
        self.searchTextField.tintColor = .blue01
        self.searchTextField.backgroundColor = .white
//        self.searchTextField.leftView?.tintColor = .blue01
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
