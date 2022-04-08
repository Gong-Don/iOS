//
//  TagSearchView.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/24.
//

import UIKit
import SnapKit
import Then

class TagSearchView: UIViewController, ViewProtocol {
    let tagSearchViewModel = TagSearchViewModel()
    
    let tagSearchBar = UISearchBar().then {
        $0.placeholder = "추가할 태그를 입력하세요"
        $0.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        $0.returnKeyType = .done
    }
    
    let tagTableView = UITableView()
    
    var addBarBtn: UIBarButtonItem {
        let button = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(self.touchUpAddBtn))
        button.tintColor = .blue01
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tagSearchViewModel.requestTagList(successHandler: self.successHandler)
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
    }
    
    func setUpValue() {
        self.view.backgroundColor = .white
    
        self.tagSearchBar.searchTextField.delegate = self
        self.tagTableView.dataSource = self
        self.tagTableView.delegate = self
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.titleView = self.tagSearchBar
        self.navigationItem.rightBarButtonItem = self.addBarBtn
    }
    
    func setUpView() {
        self.view.addSubview(self.tagTableView)
    }
    
    func setConstraints() {
        self.tagTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

extension TagSearchView {
    func successHandler() {
        self.tagSearchViewModel.fileteredData = Array(self.tagSearchViewModel.tagModel.tagResponse.keys)
        self.tagSearchViewModel.fileteredData.sort()
        self.tagTableView.reloadData()
    }
    
    @objc func touchUpAddBtn() {
        if let tag = self.tagSearchBar.searchTextField.text, tag != "" {
            if !TagList.shared.tagList.contains(tag) { TagList.shared.tagList.append(tag) }
            self.popView()
        }
    }
}

extension TagSearchView: UISearchTextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        if text == "" {
            self.successHandler()
            return
        }
        
        self.tagSearchViewModel.filterTags(str: text)
        self.tagTableView.reloadData()
    }
}

extension TagSearchView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tagSearchViewModel.fileteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tagSearchViewModel.fileteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            let tag = self.tagSearchViewModel.fileteredData[indexPath.row]
            if !TagList.shared.tagList.contains(tag) { TagList.shared.tagList.append(tag) }
            self.popView()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
