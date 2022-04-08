//
//  AddPostView.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/09.
//

import UIKit
import SnapKit
import Then

class AddPostView: UIViewController, ViewProtocol, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var addPostViewModel = AddPostViewModel()
    
    // title
    let titleLabel = UILabel().then {
        $0.text = "제목"
    }
    
    let titleTextField = BindingTextField().then {
        $0.placeholder = "제목 입력"
        $0.tag = 0
    }
    
    // category
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
    
    // price
    let priceLabel = UILabel().then {
        $0.text = "가격"
    }
    
    let priceTextField = BindingTextField().then {
        $0.placeholder = "가격 입력"
        $0.keyboardType = .numberPad
        $0.tag = 1
    }
    
    // tag
    let tagLabel = UILabel().then {
        $0.text = "태그 (0/5)"
    }
    
    let tagScrollView = HorizontalScrollView().then {
        $0.stackView.spacing = 7
    }
    
    let tagAddBtn = UIButton().then {
        $0.setDetailTitle(title: "추가", color: .systemGray)
    }
    
    // picture
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    let pictureBtn = UIButton(color: .systemGray5, radius: 4).then {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        $0.setImage(UIImage(systemName: "camera", withConfiguration: largeConfig), for: .normal)
        $0.tintColor = .black
    }
    
    // description
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
    
    // complete
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
        ].map {
            $0.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.updateSelectedTags()
    }
    
    // MARK: - Action Setting Method
    func setAction() {
        _ = [
            self.titleTextField,
            self.priceTextField,
        ].map {
            $0.addAction(self.textFieldDidChange($0), for: .editingChanged)
        }
        
        // tag
        self.tagAddBtn.addAction(self.pushTagSearchView(), for: .touchDown)
        
        // picture
        self.pictureBtn.addAction(UIAction { _ in
            
        }, for: .touchUpInside)
        
        // complete
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
            self.tagLabel,
            self.tagScrollView,
            self.tagAddBtn,
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
        let leftMargin = 20
        let rightMargin = -20
        let labelRightMargin = 80
        let textFieldHeight: CGFloat = 47
        let itemSpacing: CGFloat = 50
        let tabBarHeight: CGFloat =  self.tabBarController?.tabBar.frame.size.height ?? 0
        
        // title
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(defaultTopMargin + 40)
            make.leading.equalToSuperview().offset(leftMargin)
        }
        
        self.titleTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLabel)
            make.leading.equalTo(self.titleLabel).offset(labelRightMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        // category
        self.categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).offset(itemSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
        }
        
        self.categoryBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.categoryLabel)
            make.leading.equalTo(self.categoryLabel).offset(labelRightMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        // price
        self.priceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.categoryLabel).offset(itemSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
        }
        
        self.priceTextField.snp.makeConstraints { make in
            make.centerY.equalTo(self.priceLabel)
            make.leading.equalTo(self.categoryLabel).offset(labelRightMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        // tag
        self.tagLabel.snp.makeConstraints { make in
            make.top.equalTo(self.priceLabel).offset(itemSpacing+10)
            make.leading.equalToSuperview().offset(leftMargin)
        }
        
        self.tagAddBtn.snp.makeConstraints { make in
            make.centerY.equalTo(self.tagLabel)
            make.leading.equalTo(self.tagLabel).offset(labelRightMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
        
        self.tagScrollView.snp.makeConstraints { make in
            make.top.equalTo(self.tagLabel).offset(0)
            make.leading.equalToSuperview().offset(leftMargin-5)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(0)
        }
        
        // picture
        self.pictureBtn.snp.makeConstraints { make in
            make.top.equalTo(self.tagScrollView).offset(itemSpacing)
            make.leading.equalToSuperview().offset(leftMargin)
            make.height.equalTo(textFieldHeight)
            make.width.equalTo(textFieldHeight)
        }
        
        // description
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.pictureBtn).offset(itemSpacing+10)
            make.leading.equalToSuperview().offset(leftMargin)
        }
        
        self.descroptionTextView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel).offset(30)
            make.bottom.equalTo(self.completeBtn).offset(-70)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
        }
        
        // complete button
        self.completeBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-tabBarHeight-10)
            make.leading.equalToSuperview().offset(leftMargin)
            make.trailing.equalToSuperview().offset(rightMargin)
            make.height.equalTo(textFieldHeight)
        }
    }
}

extension AddPostView {
    func changeCompleteButtonMode() {
        self.completeBtn.changeButtonMode(isChange: self.addPostViewModel.checkAllInputFill(), color: .blue04)
    }
    
    func pushTagSearchView() -> UIAction {
        let modalAction = UIAction { _ in
            let VC = TagSearchView()
            VC.modalTransitionStyle = .coverVertical
            VC.modalPresentationStyle = .automatic
            self.pushView(VC: VC)
        }
        
        return modalAction
    }
    
    func updateSelectedTags() {
        self.tagScrollView.stackView.arrangedSubviews.filter({$0 is UIButton}).forEach {$0.removeFromSuperview()}
        TagList.shared.tagList.forEach { name in
            let button = UIButton()
            button.setTitle("  \(name) 🅧  ", for: .normal)
            button.setTitleColor(.blue01, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.backgroundColor = .systemGray6
            button.layer.cornerRadius = 15
            button.addAction(UIAction { _ in
                TagList.shared.tagList = TagList.shared.tagList.filter { $0 != name }
                self.updateSelectedTags()
            }, for: .touchUpInside)
            
            self.tagScrollView.stackView.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.height.equalTo(30)
            }
        }
        
        self.tagLabel.text = "태그 (\(TagList.shared.tagList.count)/5)"
        self.updateTagScrollViewConstraints()
        self.tagAddBtn.isEnabled = (TagList.shared.tagList.count < 5)
    }
    
    func updateTagScrollViewConstraints() {
        let count = TagList.shared.tagList.count
        self.tagScrollView.snp.updateConstraints { make in
            make.top.equalTo(self.tagLabel).offset(count > 0 ? 40 : 0)
            make.height.equalTo(count > 0 ? 30 : 0)
        }
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
            self.addPostViewModel.textFieldDidChange(text: textField.text ?? "", tag: textField.tag)
            self.changeCompleteButtonMode()
        }
    }
}
