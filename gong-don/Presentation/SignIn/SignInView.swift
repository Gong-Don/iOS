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
    
    let emailTextField = UnderLineTextField().then {
        $0.placeholder = "이메일"
        $0.tag = 1
    }
    
    let pwTextField = UnderLineTextField().then {
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
        $0.tag = 2
    }
    
    let signInBtn = UIButton(color: .blue02).then {
        $0.setDetailTitle(title: "로그인", color: .white, size: 17, weight: .bold)
    }
    
    let findPwBtn = UIButton().then {
        $0.setDetailTitle(title: "비밀번호 찾기", color: UIColor.init(r: 117, g: 117, b: 117), size: 14)
    }
    
    let signUpBtn = UIButton(color: .blue02).then {
        $0.setDetailTitle(title: "회원가입", color: .white, size: 17, weight: .bold)
    }
    
    let autoSignInBtn = UIButton().then {
        $0.tintColor = .black
        $0.setDetailTitle(title: "자동 로그인 ", color: .black, size: 13, hover: false)
        $0.setImage(UIImage(systemName: "square"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        $0.semanticContentAttribute = .forceRightToLeft
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
        
        self.setAction()
        
        self.emailTextField.delegate = self
        self.pwTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.emailTextField.addBottomLine()
        self.pwTextField.addBottomLine()
    }
    
    // MARK: - Action Setting Methods
    func setAction() {
        self.signInBtn.addAction(UIAction(handler: { _ in
            self.signInViewModel.requestSignIn(vc: self,
                                               email: self.emailTextField.text ?? "",
                                               password: self.pwTextField.text ?? "")
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
            make.top.equalTo(self.pwTextField).offset(90)
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

extension SignInView: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            self.emailTextField.deleteRequestLabel()
        } else {
            self.pwTextField.deleteRequestLabel()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            if !emailTest.evaluate(with: self.emailTextField.text) {
                self.emailTextField.bottomLine.backgroundColor = UIColor.red.cgColor
                self.emailTextField.addRequestLabel(vc: self, text: "올바른 이메일 주소를 입력해주세요.")
            }
        } else {
            let pwRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
            let pwTest = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
            if !pwTest.evaluate(with: self.pwTextField.text) {
                self.pwTextField.bottomLine.backgroundColor = UIColor.red.cgColor
                self.pwTextField.addRequestLabel(vc: self, text: "영문+숫자+특수문자 조합 8자리 이상 입력해주세요.")
            }
        }
    }
}
