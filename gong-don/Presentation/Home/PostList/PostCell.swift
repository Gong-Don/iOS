//
//  PostCell.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/13.
//

import UIKit
import SnapKit
import Then

class PostCell: UITableViewCell, ViewProtocol {
    static let cellIdentifier: String = "PostCell"
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    let dateLabel = UILabel().then {
        var date = ["", "", ""] // year, month, day
 
        if let text = $0.text {
            for i in 0..<3 {
                var startIdx = i == 0 ? text.startIndex : text.index(text.startIndex, offsetBy: 3 * i + 2)
                var endIdx = text.index(startIdx, offsetBy: 3 * i + 4)
                date[i] = String(text[startIdx..<endIdx])
            }
        }
    }

    let descLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpValue()
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpValue() {
    
    }
    
    func setUpView() {
        _ = [
            self.titleLabel,
            self.descLabel
        ].map { 
            self.contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        let padding: CGFloat = 10
        let labelSpacing: CGFloat = 40
        
        self.titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
        }
        
        self.descLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(labelSpacing)
            make.bottom.equalToSuperview().offset(-padding)
            make.leading.equalToSuperview().offset(padding)
        }
    }
}
