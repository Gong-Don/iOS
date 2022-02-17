//
//  HomeView.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/14.
//

import UIKit

class HomeView: UIViewController, ViewProtocol {
    let viewSideMargin: CGFloat = 40
    let celllineSpacing: CGFloat = 16
    
    let appLogoLabel: AppLogoLabel = AppLogoLabel()
    
    let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.text = "공부하면서 돈벌자"
        subTitleLabel.textColor = .systemGray
        subTitleLabel.font = UIFont.systemFont(ofSize: 17)
        return subTitleLabel
    }()
    
    let searchBar: CustomSearchBar = CustomSearchBar()
    
    var taskCollectionView: UICollectionView! {
        didSet {
            let flowLayout = UICollectionViewFlowLayout()
            let cellWidth: CGFloat = self.view.frame.width - self.viewSideMargin
            
            flowLayout.minimumLineSpacing = self.celllineSpacing
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: self.celllineSpacing, right: 0)
            flowLayout.itemSize = CGSize(width: cellWidth, height: 120)
            
            taskCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
            taskCollectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.cellIdentifier)
            
            taskCollectionView.delegate = self
            taskCollectionView.dataSource = self
        }
    }
    
    let addBtn: UIButton = {
        let addBtn = UIButton()
        addBtn.tintColor = .blue01
        addBtn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addBtn.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .semibold, scale: .large), forImageIn: .normal)
        return addBtn
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - View Setting Mathods
    func setUpValue() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        self.taskCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    func setUpView() {
        _ = [
            self.appLogoLabel,
            self.subTitleLabel,
            self.searchBar,
            self.taskCollectionView,
            self.addBtn
        ].map {
            self.view.addSubview($0)
        }
    }
    
    func setConstraints() {
        
        let leftMargin: CGFloat = self.viewSideMargin / 2
        let rightMargin: CGFloat = -self.viewSideMargin / 2
        
        self.appLogoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        self.subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.appLogoLabel).offset(50)
            make.centerX.equalToSuperview()
        }
        
        self.searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.subTitleLabel).offset(50)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        self.taskCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar).offset(55+self.celllineSpacing)
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        self.addBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
    }
}


 // MARK: - UICollection
extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.cellIdentifier, for: indexPath) as? TaskCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
