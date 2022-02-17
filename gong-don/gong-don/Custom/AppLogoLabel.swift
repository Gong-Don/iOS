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
        self.text = "공돈"
        self.textColor = UIColor.blue01
        self.font = UIFont.systemFont(ofSize: 38, weight: .black)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
