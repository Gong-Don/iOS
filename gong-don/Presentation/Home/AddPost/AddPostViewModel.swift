//
//  AddPostViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/11.
//

import Foundation

struct AddPostViewModel {
    var addPostModel: AddPostModel = AddPostModel(category: "", content: "", price: -1, title: "", wrtId: nil)
    
    mutating func requestAddPost() {
        guard let wrtId = self.getUserId() else {
            return
        }
                
        self.addPostModel.wrtId = wrtId
        PostService.shared.addPost(model: self.addPostModel)
    }
}

extension AddPostViewModel {
    func getUserId() -> Int? {
        guard let user = KeyChain.shared.readUser() else {
            return nil
        }
  
        return user.userId
    }
    
    func checkAllInputFill() -> Bool {
        let post = self.addPostModel
        if (post.category != "" && post.content != "" && post.price >= 0 && post.title != "") {
            return true
        }
        return false
    }
    
    mutating func textFieldDidChange(textField: BindingTextField) {
        switch(textField.tag) {
        case 0:
            self.addPostModel.title = textField.text ?? ""
        case 1:
            if let text = textField.text {
                self.addPostModel.price = Int(text) ?? -1
            }
        default:
            print("Wrong tag")
        }
    }
    
    mutating func setCategory(title: String) {
        var category: String
        
        switch (title) {
        case "디자인": category = "DESIGN"
        case "IT": category = "IT"
        case "미디어": category = "MEDIA"
        case "번역": category = "TRANSLATION"
        case "문서": category = "DOCUMENT"
        case "스터디": category = "STUDY"
        default: category = ""
        }
        
        self.addPostModel.category = category
    }
}
