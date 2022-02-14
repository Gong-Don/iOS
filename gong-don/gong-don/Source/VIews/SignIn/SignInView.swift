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
    
    lazy var emailTextField: SignTextField = {
        let emailTextField = SignTextField()
        emailTextField.placeholder = "이메일"
        return emailTextField
    }()
    
    lazy var pwTextField: SignTextField = {
        let pwTextField = SignTextField()
        pwTextField.placeholder = "비밀번호"
        pwTextField.isSecureTextEntry = true
        return pwTextField
    }()
    
    lazy var signInBtn: UIButton = {
        let signInBtn = UIButton(color: .blue02)
        signInBtn.setDetailTitle(title: "로그인", color: .white, size: 17, weight: .bold)
        return signInBtn
    }()
    
    lazy var findPwBtn: UIButton = {
        let findPwBtn = UIButton()
        findPwBtn.setDetailTitle(title: "비밀번호 찾기", color: UIColor.init(r: 117, g: 117, b: 117), size: 14)
        return findPwBtn
    }()
    
    lazy var signUpBtn: UIButton = {
        let signUpBtn = UIButton(color: .blue02)
        signUpBtn.setDetailTitle(title: "회원가입", color: .white, size: 17, weight: .bold)
        signUpBtn.addAction(UIAction(handler: { _ in
            self.pushView(VC: SignUpView())
        }), for: .touchUpInside)
        return signUpBtn
    }()
    
    lazy var autoSignInBtn: UIButton = {
        let autoSignInBtn = UIButton()
        autoSignInBtn.tintColor = .black
        autoSignInBtn.setDetailTitle(title: "자동 로그인 ", color: .black, size: 13, hover: false)
        autoSignInBtn.setImage(UIImage(systemName: "square"), for: .normal)
        autoSignInBtn.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        autoSignInBtn.semanticContentAttribute = .forceRightToLeft
        autoSignInBtn.addAction(UIAction(handler: { _ in
            self.autoSignInBtn.isSelected.toggle()
        }), for: .touchUpInside)
        return autoSignInBtn
    }()

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.emailTextField.addBottomLine()
        self.pwTextField.addBottomLine()
    }
    
    // MARK: - View Setting Mathods
    func setUpValue() {
        self.view.backgroundColor = .white
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
        
        self.appLogoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(200)
            make.centerX.equalToSuperview()
        }
        
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.appLogoLabel).offset(100)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        self.pwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField).offset(90)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        self.signInBtn.snp.makeConstraints { make in
            make.top.equalTo(self.pwTextField).offset(70)
            make.width.equalTo(86)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        self.autoSignInBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.signInBtn)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        self.findPwBtn.snp.makeConstraints { make in
            make.top.equalTo(self.signInBtn).offset(50)
            make.centerX.equalToSuperview()
        }
        
        self.signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(self.findPwBtn).offset(50)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
}
