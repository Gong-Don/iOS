//
//  SignUpView.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/13.
//

import UIKit
import SnapKit

class SignUpView: UIViewController, ViewProtocol {

    let appLogoLabel: AppLogoLabel = AppLogoLabel()
    
    lazy var emailTextField: SignTextField = {
        let emailTextField = SignTextField()
        emailTextField.placeholder = "이메일"
        return emailTextField
    }()
    
    lazy var emailAuthBtn: UIButton = {
        let emailAuthBtn = UIButton(color: .blue01, radius: 15)
        emailAuthBtn.setDetailTitle(title: "이메일 인증", color: .white)
        return emailAuthBtn
    }()
    
    lazy var pwTextField: SignTextField = {
        let pwTextField = SignTextField()
        pwTextField.placeholder = "비밀번호"
        return pwTextField
    }()
    
    lazy var checkPwTextField: SignTextField = {
        let checkPwTextField = SignTextField()
        checkPwTextField.placeholder = "비밀번호 확인"
        return checkPwTextField
    }()
    
    lazy var nicknameTextField: SignTextField = {
        let nicknameTextField = SignTextField()
        nicknameTextField.placeholder = "닉네임"
        return nicknameTextField
    }()
    
    lazy var signUpBtn: UIButton = {
        let signUpBtn = UIButton(color: .blue02)
        signUpBtn.setDetailTitle(title: "회원가입", color: .white, size: 17, weight: .bold)
        return signUpBtn
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
        
        _ = [
            self.emailTextField,
            self.pwTextField,
            self.checkPwTextField,
            self.nicknameTextField
        ].map {
            $0.addBottomLine()
        }
    }
    
    // MARK: - View Setting Mathods
    func setUpValue() {
        self.view.backgroundColor = .white
        self.navigationItem.titleView = self.appLogoLabel
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "로그인"
    }

    func setUpView() {
        _ = [
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
        
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(220)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalTo(self.emailAuthBtn).offset(-5)
        }
        
        self.emailAuthBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(self.emailTextField)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.width.width.equalTo(90)
        }
        
        self.pwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        self.checkPwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.pwTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        self.nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.checkPwTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        self.signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameTextField).offset(100)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }

}
