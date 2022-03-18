//
//  AddPostView.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/09.
//

import UIKit
import SnapKit
import Then

class AddPostView: UIViewController, ViewProtocol {
    
    var addPostViewModel = AddPostViewModel()

    let titleLabel = UILabel().then {
        $0.text = "제목"
    }
    
    let titleTextField = BindingTextField().then {
        $0.placeholder = "제목 입력"
        $0.tag = 0
    }
    
    let categoryLabel = UILabel().then {
        $0.text = "카테고리"
    }
    
    var categoryBtn: UIButton! {
        didSet {
            let handler: (UIAction) -> Void
            handler = { item in
                self.categoryBtn.setTitle(item.title, for: .normal)
                self.categoryBtn.setTitleColor(.black, for: .normal)
                self.addPostViewModel.setCategory(title: item.title)
                self.changeCompleteButtonMode()
            }
            
            self.categoryBtn.setDetailTitle(title: "선택", color: .systemGray)
            self.categoryBtn.menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: Category.map {
                UIAction(title: $0, handler: handler)
            })
            self.categoryBtn.showsMenuAsPrimaryAction = true
        }
    }
    
    let priceLabel = UILabel().then {
        $0.text = "가격"
    }
    
    let priceTextField = BindingTextField().then {
        $0.placeholder = "가격 입력"
        $0.keyboardType = .numberPad
        $0.tag = 1
    }
    
    let tagTextField = BindingTextField().then {
        $0.placeholder = "태그를 입력하세요 (최대 5개)"
        $0.tag = 2
    }
    
    let pictureBtn = UIButton(color: .systemGray5, radius: 4).then {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        $0.setImage(UIImage(systemName: "camera", withConfiguration: largeConfig), for: .normal)
        $0.tintColor = .black
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "작업 내용"
    }
    
    let descroptionTextView = UITextView().then {
        $0.textColor = .systemGray4
        $0.text = " 내용 입력"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    let completeBtn = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        $0.changeButtonMode(isChange: false, color: .blue04)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpValue()
        self.setUpView()
        self.setConstraints()
        
        self.setAction()
        
        _ = [
            self.titleTextField,
            self.priceTextField,
            self.tagTextField,
        ].map {
            $0.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Action Setting Method
    func setAction() {
        _ = [
            self.titleTextField,
            self.priceTextField,
            self.tagTextField
        ].map {
            $0.addAction(self.textFieldDidChange($0), for: .editingChanged)
        }
        
        self.completeBtn.addAction(UIAction { _ in
            self.addPostViewModel.requestAddPost()
            self.popView()
        }, for: .touchUpInside)
    }

    // MARK: - View Protocol Methods
    func setUpValue() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.title = "글 등록"
        
        self.categoryBtn = UIButton()
        self.descroptionTextView.delegate = self
    }
    
    func setUpView() {
        _ = [
            self.titleLabel,
            self.titleTextField,
            self.categoryLabel,
            self.categoryBtn,
            self.priceLabel,
            self.priceTextField,
            self.tagTextField,
            self.pictureBtn,
            self.descriptionLabel,
            self.descroptionTextView,
            self.completeBtn
        ].map {
            self.view.addSubview($0)
        }
    }
    
    func setConstraints() {
        let defaultTopMargin = 80
        let textFieldHeight: CGFloat = 47
        let itemSpacing: CGFloat = 50
        let tabBarHeight: CGFloat =  self.tabBarController?.tabBar.frame.size.height ?? 0
        
        // title
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(defaultTopMargin + 40)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.titleTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLabel)
            make.leading.equalTo(self.titleLabel).offset(80)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(textFieldHeight)
        }
        
        // category
        self.categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(itemSpacing)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.categoryBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.categoryLabel)
            make.leading.equalTo(self.categoryLabel).offset(80)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(textFieldHeight)
        }
        
        // price
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.categoryLabel).offset(itemSpacing)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.priceTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.priceLabel)
            make.leading.equalTo(self.categoryLabel).offset(80)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(textFieldHeight)
        }
        
        // tag
        self.tagTextField.snp.makeConstraints { make in
            make.top.equalTo(self.priceLabel).offset(itemSpacing)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(textFieldHeight)
        }
        
        // picture
        self.pictureBtn.snp.makeConstraints { make in
            make.top.equalTo(self.tagTextField).offset(itemSpacing+10)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(textFieldHeight)
        }
        
        // description
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.pictureBtn).offset(itemSpacing+10)
            make.leading.equalToSuperview().offset(20)
        }
        
        self.descroptionTextView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel).offset(30)
            make.bottom.equalTo(self.completeBtn).offset(-70)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        // complete button
        self.completeBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-tabBarHeight-10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(textFieldHeight)
        }
    }
}

extension AddPostView {
    func changeCompleteButtonMode() {
        self.completeBtn.changeButtonMode(isChange: self.addPostViewModel.checkAllInputFill(), color: .blue04)
    }
}

// MARK: - TextView Delegtate
extension AddPostView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .systemGray4 {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty  {
            textView.text = " 내용 입력"
            textView.textColor = .systemGray4
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor != .systemGray4 {
            self.addPostViewModel.addPostModel.content = textView.text
            self.changeCompleteButtonMode()
        }
    }
}

// MARK: - TextField Delegete
extension AddPostView: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChange(_ textField: BindingTextField) -> UIAction {
        return UIAction { _ in
            self.addPostViewModel.textFieldDidChange(textField: textField)
            self.changeCompleteButtonMode()
        }
    }
}
