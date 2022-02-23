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
    
    let emailTextField = BindingTextField().then {
        $0.placeholder = "이메일(example@gongdon.com)"
        $0.tag = 0
    }
    
    let emailAuthBtn = UIButton(color: .blue01, radius: 18).then {
        $0.setDetailTitle(title: "이메일 인증", color: .white, weight: .semibold)
    }
    
    let pwTextField = BindingTextField().then {
        $0.placeholder = "비밀번호(영문+숫자+특수문자 조합 8자리 이상)"
        $0.isSecureTextEntry = true
        $0.tag = 1
    }
    
    let checkPwTextField = BindingTextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.isSecureTextEntry = true
        $0.tag = 2
    }
    
    let nicknameTextField = BindingTextField().then {
        $0.placeholder = "닉네임(2~8자리)"
        $0.tag = 3
    }
    
    let signUpBtn = UIButton(color: .blue02.withAlphaComponent(0.5)).then {
        $0.setDetailTitle(title: "회원가입", color: .white, size: 17, weight: .bold)
        $0.isEnabled = false
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
        
        self.setAction()
        
        self.signUpViewModel.vc = self
    }
    
    // MARK: - Action Setting Method
    func setAction() {
        _ = [
            self.emailTextField,
            self.pwTextField,
            self.checkPwTextField,
            self.nicknameTextField
        ].map {
            $0.addAction(self.textFieldDidChange($0), for: .editingChanged)
        }
        
        self.signUpBtn.addAction(UIAction(handler: { _ in
            self.signUpViewModel.requestSignUp(
                name: self.nicknameTextField.text ?? "",
                email: self.emailTextField.text ?? "",
                password: self.pwTextField.text ?? "")
        }), for: .touchUpInside)
    }
    
    // MARK: - View Protocol Methods
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
        let leftMargin: CGFloat = 20
        let rightMargin: CGFloat = -20
        let textFieldHeight: CGFloat = 47
        let textFieldSpacing: CGFloat = 70
        let emailAutnBtnWidth: CGFloat = 90
        
        // Logo
        self.appLogoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(170)
            make.centerX.equalToSuperview()
        }
        
        // Email
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.appLogoLabel).offset(120)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalTo(self.emailAuthBtn).offset(-(emailAutnBtnWidth+10))
            make.height.equalTo(textFieldHeight)
        }
        
        // Email Auth
        self.emailAuthBtn.snp.makeConstraints{ make in
            make.centerY.equalTo(self.emailTextField)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.width.width.equalTo(emailAutnBtnWidth)
            make.height.equalTo(textFieldHeight-10)
        }
        
        // Password
        self.pwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        // Password Check
        self.checkPwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.pwTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        // Nickname
        self.nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.checkPwTextField).offset(textFieldSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        // Sign Up
        self.signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(self.nicknameTextField).offset(100)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }

}

extension SignUpView: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(_ textField: BindingTextField) -> UIAction {
        let changedAction = UIAction { _ in
            self.signUpBtn.changeButtonMode(
                isChange: self.signUpViewModel.textFieldDidChange(textField: textField),
                color: .blue02)
            
            if textField.tag == 1 {
                self.checkPwTextField.text = ""
                self.checkPwTextField.layer.borderColor = self.checkPwTextField.defaultColor.cgColor
            }
        }

        return changedAction
    }
}
