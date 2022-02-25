//
//  ProfileView.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/16.
//

import UIKit

class ProfileView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SignInViewModel().deleteUserAccount()
        self.popView()
    }
}
