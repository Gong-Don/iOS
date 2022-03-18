//
//  PostListView.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/10.
//

import UIKit
import SnapKit
import Then

class PostListView: UIViewController, ViewProtocol {
    let postListViewModel = PostListViewModel()
    
    let searchController = CustomSearchController().then {
        $0.changeStyle()
    }
    
    let horizontalScrollView = HorizontalScrollView()
    
    let postTableView = UITableView()
    
    let addPostBtn = UIButton().then {
        $0.tintColor = .blue01
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 30, weight: .semibold, scale: .large), forImageIn: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
        
        self.setAction()
        
        self.postListViewModel.requestPostList(
            categoryTitle: "전체",
            successHandler: self.successHandler)
        
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        self.postTableView.register(PostCell.self, forCellReuseIdentifier: PostCell.cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    func setAction() {
        self.searchController.searchBar.searchTextField.addAction(UIAction(handler: { _ in
            self.popView()
        }), for: .touchDown)
        
        self.addPostBtn.addAction(UIAction(handler: { _ in
            self.pushView(VC: AddPostView())
        }), for: .touchUpInside)
    }
    
    // MARK: - View Protocol Methods
    func setUpValue() {
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true

        let cancelBtnItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(self.touchUpCancelBtnItem))
        cancelBtnItem.image = UIImage(systemName: "xmark")
        cancelBtnItem.tintColor = .blue01
        self.navigationItem.rightBarButtonItem = cancelBtnItem
    
        self.navigationItem.titleView = self.searchController.searchBar
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setUpView() {
        let categoryData = ["전체"] + Category
        categoryData.forEach { name in
            let button = UIButton()
            button.setTitleColor(.systemGray, for: .normal)
            button.setTitle(name, for: .normal)
            button.addAction(UIAction(handler: { _ in
                self.postListViewModel.requestPostList(categoryTitle: name, successHandler: self.successHandler)
            }), for: .touchUpInside)
            self.horizontalScrollView.stackView.addArrangedSubview(button)
        }
        
        _ = [
            self.horizontalScrollView,
            self.postTableView,
            self.addPostBtn
        ].map {
            self.view.addSubview($0)
        }
    }
    
    func setConstraints() {
        let viewSideMargin: CGFloat = 40
        let leftMargin: CGFloat = viewSideMargin / 2
        let rightMargin: CGFloat = -viewSideMargin / 2
//        let tabBarHeight: CGFloat =  self.tabBarController?.tabBar.frame.size.height ?? 0
        
        self.horizontalScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(leftMargin+10)
            make.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        self.postTableView.snp.makeConstraints { make in
            make.top.equalTo(self.horizontalScrollView).offset(40)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.bottom.equalToSuperview()
        }
        
        self.addPostBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
    }
}

extension PostListView {
    @objc func touchUpCancelBtnItem() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func successHandler() {
        DispatchQueue.main.async {
            self.postTableView.reloadData()
        }
    }
}

extension PostListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.postListViewModel.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.cellIdentifier, for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        
        let post = self.postListViewModel.postList[indexPath.row]
        cell.titleLabel.text = post.title
        cell.dateLabel.text = post.date
        cell.descLabel.text = post.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = PostDetailView()
        let post = self.postListViewModel.postList[indexPath.row]
        
        vc.titleLabel.text = post.title
        vc.categoryLabel.text = "카테고리 : \(post.category)"
        vc.priceLabel.text = "가격 : \(post.price)"
        vc.descLabel.text = post.content
        
        self.pushView(VC: vc)
    }
}
