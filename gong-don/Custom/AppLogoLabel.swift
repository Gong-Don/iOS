//
//  AppLogoLabel.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/12.
//

import UIKit

class AppLogoLabel: UILabel {

    init() {
        super.init(frame: CGRect())
        self.text = "GongDon"
        self.textColor = UIColor.blue01
        self.font = UIFont.systemFont(ofSize: 38, weight: .heavy)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
