//
//  HorizontalScrollView.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/11.
//

import UIKit
import Then

class HorizontalScrollView: UIScrollView {
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 30
    }

    init() {
        super.init(frame: CGRect())
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.showsHorizontalScrollIndicator = false
        self.bounces = false
        
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}
