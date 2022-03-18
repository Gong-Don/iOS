//
//  PostDetailView.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/18.
//

import UIKit
import SnapKit
import Then

class PostDetailView: UIViewController, ViewProtocol {
    let titleLabel = UILabel()
    
    let categoryLabel = UILabel()
    
    let priceLabel = UILabel()
    
    let descLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
    }
    
    func setUpValue() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
    func setUpView() {
        _ = [
            self.titleLabel,
            self.categoryLabel,
            self.priceLabel,
            self.descLabel
        ].map {
            self.view.addSubview($0)
        }
    }
    
    func setConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
        }
        
        self.categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(40)
        }
        
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.categoryLabel).offset(40)
        }
        
        self.descLabel.snp.makeConstraints { make in
            make.top.equalTo(self.priceLabel).offset(40)
        }
    }
    
}
