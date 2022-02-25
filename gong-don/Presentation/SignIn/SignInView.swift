//
//  SignInView.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/11.
//

import UIKit
import SnapKit
import Then

class SignInView: UIViewController, ViewProtocol {
    var signInViewModel: SignInViewModel = SignInViewModel()
    
    let appLogoLabel: AppLogoLabel = AppLogoLabel()
    
    let emailTextField = BindingTextField().then {
        $0.placeholder = "이메일(example@gongdon.com)"
        $0.tag = 0
    }
    
    let pwTextField = BindingTextField().then {
        $0.placeholder = "비밀번호(영문+숫자+특수문자 조합 8자리 이상)"
        $0.isSecureTextEntry = true
        $0.tag = 1
    }
    
    let signInBtn = UIButton(color: .blue02.withAlphaComponent(0.5)).then {
        $0.setDetailTitle(title: "로그인", color: .white, size: 17, weight: .bold)
        $0.isEnabled = false
    }
    
    let findPwBtn = UIButton().then {
        $0.setDetailTitle(title: "비밀번호 찾기", color: UIColor.init(r: 117, g: 117, b: 117), size: 14)
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
        
        self.checkKeyChain()
    }
    
    // MARK: - Action Setting Method
    func setAction() {
        // TextField
        _ = [
            self.emailTextField,
            self.pwTextField
        ].map {
            $0.addAction(self.textFieldDidChange($0), for: .editingChanged)
        }
        
        // Sign In
        self.signInBtn.addAction(UIAction(handler: { _ in
            self.signInViewModel.requestSignIn(endHandler: self.signInEndHandler)
        }), for: .touchUpInside)
        
        // Sign Up
        self.signUpBtn.addAction(UIAction(handler: { _ in
            self.pushView(VC: SignUpView())
        }), for: .touchUpInside)
    }
    
    // MARK: - View Protocol Methods
    func setUpValue() {
        self.view.backgroundColor = .white
        self.title = "로그인"
        
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
        ].map {
            self.view.addSubview($0)
        }
    }
    
    func setConstraints() {
        let leftMargin: CGFloat = 20
        let rightMargin: CGFloat = -20
        let textFieldHeight: CGFloat = 47
        let logoTopMargin: CGFloat = self.view.frame.size.height / 4
        
        // Logo
        self.appLogoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(logoTopMargin)
            make.centerX.equalToSuperview()
        }
        
        // Email
        self.emailTextField.snp.makeConstraints { make in
            make.top.equalTo(self.appLogoLabel).offset(100)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        // Password
        self.pwTextField.snp.makeConstraints { make in
            make.top.equalTo(self.emailTextField).offset(70)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        // Sign In
        self.signInBtn.snp.makeConstraints { make in
            make.top.equalTo(self.pwTextField).offset(70)
            make.width.equalTo(86)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        // Find Password
        self.findPwBtn.snp.makeConstraints { make in
            make.top.equalTo(self.signInBtn).offset(50)
            make.centerX.equalToSuperview()
        }
        
        // Sign Up
        self.signUpBtn.snp.makeConstraints { make in
            make.top.equalTo(self.findPwBtn).offset(70)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
}

extension SignInView {
    func checkKeyChain() {
        if let user = self.signInViewModel.checkUserAccount() {
            self.emailTextField.text = user.email
            self.pwTextField.text = user.password
            self.signInViewModel.requestSignIn(endHandler: self.signInEndHandler)
        }
    }
    
    func signInEndHandler() -> Void {
        self.pushView(VC: TabBarController())
        self.signInViewModel.storeUserAccount()
    }
}

extension SignInView: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(_ textField: BindingTextField) -> UIAction {
        let changedAction = UIAction { _ in
            self.signInBtn.changeButtonMode(
                isChange: self.signInViewModel.textFieldDidChange(textField: textField),
                color: .blue02
            )
        }

        return changedAction
    }
}
