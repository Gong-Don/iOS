//
//  CustomSearchController.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/15.
//

import UIKit
import SnapKit

class CustomSearchController: UISearchController {    
    init() {
        super.init(searchResultsController: nil)
        
        self.setUpSearchController()
        self.setUpSerachBar()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSearchController() {
        self.hidesNavigationBarDuringPresentation = false
        self.obscuresBackgroundDuringPresentation = false
    }
    
    func setUpSerachBar() {
        self.searchBar.placeholder = "검색어 입력"
        self.searchBar.showsCancelButton = false
        
        self.searchBar.searchTextField.tintColor = .blue01
        self.searchBar.searchTextField.backgroundColor = .white
        
        self.searchBar.layer.borderWidth = 2
        self.searchBar.layer.cornerRadius = 10
        self.searchBar.layer.borderColor =  UIColor.blue01.cgColor
    }
    
    func changeStyle(color: UIColor = .blue01) {
        self.searchBar.layer.borderWidth = 0
        
        self.searchBar.searchTextField.layer.borderWidth = 2
        self.searchBar.searchTextField.layer.cornerRadius = 10
        self.searchBar.searchTextField.layer.borderColor =  color.cgColor
    }
}


