//
//  SearchView.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/10.
//

import UIKit
import SnapKit

class SearchView: UIViewController, ViewProtocol {
    
    let searchController = CustomSearchController().then {
        $0.changeStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.definesPresentationContext = true
    }
    
    func setUpValue() {
        self.view.backgroundColor = .white
    
        self.navigationItem.titleView = self.searchController.searchBar
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setUpView() {
        
    }
    
    func setConstraints() {
        
    }
}

extension SearchView: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.pushView(VC: PostListView())
    }
}
