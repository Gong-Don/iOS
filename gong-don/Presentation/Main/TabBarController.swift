//
//  TabBarController.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/15.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setInstance()
        self.setUpStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setInstance() {
        let firstTab = HomeView()
        let secondTab = TaskListView()
        let thirdTab = ProfileView()
        
        firstTab.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 1)
        secondTab.tabBarItem = UITabBarItem(title: "작업목록", image: UIImage(systemName: "heart"), tag: 2)
        thirdTab.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person"), tag: 3)
        
        let firstNav = UINavigationController(rootViewController: firstTab)
        
        setViewControllers([firstNav, secondTab, thirdTab], animated: false)
    }
    
    func setUpStyle() {
        UITabBar.clearShadow()
        self.tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }

}
