//
//  SignUpView.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/13.
//

import UIKit
import SnapKit
import Then

class SignUpView: UIViewController, ViewProtocol {
    
    var signUpViewModel: SignUpViewModel = SignUpViewModel()

    let appLogoLabel: AppLogoLabel = AppLogoLabel()
    
    let emailTextField = UnderLineTextField().then {
        $0.placeholder = "이메일"
    }
    
    let emailAuthBtn = UIButton(color: .blue01, radius: 15).then {
        $0.setDetailTitle(title: "이메일 인증", color: .white, weight: .semibold)
    }
    
    let pwTextField = UnderLineTextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
    }
    
    let checkPwTextField = UnderLineTextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.isSecureTextEntry = true
    }
    
    let nicknameTextField = UnderLineTextField().then {
        $0.placeholder = "닉네임"
    }
    
    let signUpBtn = UIButton(color: .blue02).then {
        $0.setDetailTitle(title: "회원가입", color: .white, size: 17, weight: .bold)
    }
    
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
        
        _ = [
            self.emailTextField,
            self.pwTextField,
            self.checkPwTextField,
            self.nicknameTextField
        ].map {
            $0.addBottomLine()
        }
    }
    
    // MARK: - Action Setting Methods
    func setAction() {
        self.signUpBtn.addAction(UIAction(handler: { _ in
            self.signUpViewModel.requestSignUp(name: self.nicknameTextField.text ?? "",
                                               email: self.emailTextField.text ?? "",
                                               password: self.pwTextField.text ?? "")
        }), for: .touchUpInside)
    }
    
    // MARK: - View Setting Methods
    func setUpValue() {
        self.view.backgroundColor = .white
        self.title = "회원가입"
    }

    func setUpView() {
        _ = [
            self.appLogoLabel,
            self.emailTextField,
            self.emailAuthBtn,
            self.pwTextField,
            self.checkPwTextField,
            self.nicknameTextField,
            self.signUpBtn
        ].map {
            self.view.addSubview($0)
        }
    }

    func setConstraints() {
        let leftMargin: CGFloat = 40
        let rightMargin: CGFloat = -40
        let textFieldSpacing: CGFloat = 80
        let emailAutnBtnWidth: CGFloat = 90
        
        // Logo
        self.appLogoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        // Email
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.appLogoLabel).offset(100)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalTo(self.emailAuthBtn).offset(-emailAutnBtnWidth)
        }
        
        // Email Auth
        self.emailAuthBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(self.emailTextField)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.width.width.equalTo(emailAutnBtnWidth)
        }
        
        // Password
        self.pwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        // Password Check
        self.checkPwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.pwTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        // Nickname
        self.nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.checkPwTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        // Sign Up
        self.signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameTextField).offset(100)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }

}
