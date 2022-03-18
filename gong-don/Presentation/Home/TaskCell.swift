//
//  ProgressCell.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/15.
//

import UIKit
import SnapKit

class TaskCell: UICollectionViewCell, ViewProtocol {
    static let cellIdentifier: String = "TaskCell"
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "안드 할사람 손"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return titleLabel
    }()
    
    let descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "지금 열심히 ui 만들고 있는중..."
        return descLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "2021.01.26"
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return dateLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setting Methods
    func setUpValue() {
        self.backgroundColor = .blue03
        self.layer.cornerRadius = 6
    }
    
    func setUpView() {
        _ = [
            self.titleLabel,
            self.descLabel,
            self.dateLabel
        ].map { 
            self.contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        let padding: CGFloat = 10
        let labelSpacing: CGFloat = 40
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
        }
        
        self.descLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(labelSpacing)
            make.leading.equalToSuperview().offset(padding)
        }
        
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.descLabel).offset(labelSpacing)
            make.leading.equalToSuperview().offset(padding)
        }
    }
}
