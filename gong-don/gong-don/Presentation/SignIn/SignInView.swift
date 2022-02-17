//
//  SignInView.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/11.
//

import UIKit
import SnapKit

class SignInView: UIViewController, ViewProtocol {
    
    let appLogoLabel: AppLogoLabel = AppLogoLabel()
    
    let emailTextField: UnderLineTextField = {
        let emailTextField = UnderLineTextField()
        emailTextField.placeholder = "이메일"
        return emailTextField
    }()
    
    let pwTextField: UnderLineTextField = {
        let pwTextField = UnderLineTextField()
        pwTextField.placeholder = "비밀번호"
        pwTextField.isSecureTextEntry = true
        return pwTextField
    }()
    
    let signInBtn: UIButton = {
        let signInBtn = UIButton(color: .blue02)
        signInBtn.setDetailTitle(title: "로그인", color: .white, size: 17, weight: .bold)
        return signInBtn
    }()
    
    let findPwBtn: UIButton = {
        let findPwBtn = UIButton()
        findPwBtn.setDetailTitle(title: "비밀번호 찾기", color: UIColor.init(r: 117, g: 117, b: 117), size: 14)
        return findPwBtn
    }()
    
    let signUpBtn: UIButton = {
        let signUpBtn = UIButton(color: .blue02)
        signUpBtn.setDetailTitle(title: "회원가입", color: .white, size: 17, weight: .bold)
        return signUpBtn
    }()
    
    let autoSignInBtn: UIButton = {
        let autoSignInBtn = UIButton()
        autoSignInBtn.tintColor = .black
        autoSignInBtn.setDetailTitle(title: "자동 로그인 ", color: .black, size: 13, hover: false)
        autoSignInBtn.setImage(UIImage(systemName: "square"), for: .normal)
        autoSignInBtn.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        autoSignInBtn.semanticContentAttribute = .forceRightToLeft
        return autoSignInBtn
    }()

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
        
        self.setAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.emailTextField.addBottomLine()
        self.pwTextField.addBottomLine()
    }
    
    // MARK: - Action Setting Methods
    func setAction() {
        self.signInBtn.addAction(UIAction(handler: { _ in
            self.pushView(VC: TabBarController())
        }), for: .touchUpInside)
        
        self.signUpBtn.addAction(UIAction(handler: { _ in
            self.pushView(VC: SignUpView())
        }), for: .touchUpInside)
        
        self.autoSignInBtn.addAction(UIAction(handler: { _ in
            self.autoSignInBtn.isSelected.toggle()
        }), for: .touchUpInside)
    }
    
    
    // MARK: - View Setting Methods
    func setUpValue() {
        self.view.backgroundColor = .white
        self.title = "로그인"
//        self.navigationController?.navigationBar.isHidden = true
        
        // NavigationBar Setting
        let navigationBar = self.navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .systemGray3
        navigationBarAppearance.backgroundColor = .white
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationBar?.tintColor = .black
        navigationBar?.topItem?.backButtonTitle = ""
    }
    
    func setUpView() {
        _ = [
            self.appLogoLabel,
            self.emailTextField,
            self.pwTextField,
            self.signInBtn,
            self.findPwBtn,
            self.signUpBtn,
            self.autoSignInBtn
        ].map {
            self.view.addSubview($0)
        }
    }
    
    func setConstraints() {
        let leftMargin: CGFloat = 40
        let rightMargin: CGFloat = -40
        
        // Logo
        self.appLogoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(200)
            make.centerX.equalToSuperview()
        }
        
        // Email
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.appLogoLabel).offset(100)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        // Password
        self.pwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField).offset(90)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        // Sign In
        self.signInBtn.snp.makeConstraints { make in
            make.top.equalTo(self.pwTextField).offset(70)
            make.width.equalTo(86)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        // Auto SignIn
        self.autoSignInBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.signInBtn)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        // Find Password
        self.findPwBtn.snp.makeConstraints { make in
            make.top.equalTo(self.signInBtn).offset(50)
            make.centerX.equalToSuperview()
        }
        
        // Sign Up
        self.signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(self.findPwBtn).offset(50)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
}
