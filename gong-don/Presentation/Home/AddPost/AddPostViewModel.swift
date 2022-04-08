//
//  AddPostViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/11.
//

import Foundation
import Photos

class AddPostViewModel {
    var addPostModel: AddPostModel = AddPostModel(category: "", content: "", fileUrls: [], price: -1, tags: [], title: "", wrtId: nil)
    
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    func requestAddPost() {
        guard let wrtId = self.getUserId() else {
            return
        }
        
        self.addPostModel.wrtId = wrtId
        self.addPostModel.tags = TagList.shared.tagList
        TagList.shared.tagList = []
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
    
    func textFieldDidChange(text: String, tag: Int) {
        switch(tag) {
        case 0:
            self.addPostModel.title = text
        case 1:
            self.addPostModel.price = Int(text) ?? -1
        default:
            print("Wrong tag")
        }
    }
    
    func setCategory(title: String) {
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

// photo
extension AddPostViewModel {
//    func aurhorizePhotoAccess() {
//        let photoAurhorizationStatus = PHPhotoLibrary.authorizationStatus()
//        
//        switch photoAurhorizationStatus {
//        case .notDetermined:
//            print("응답 안함")
//            PHPhotoLibrary.requestAuthorization({ (status) in
//               switch status {
//               case .denied:
//                   print("접근 불허")
//               case .authorized:
//                   print("접근 허용")
//               default: break
//               }
//           })
//        case .restricted:
//            print("접근 제한")
//        case .denied:
//            print("접근 불허")
//        case .authorized:
//            print("접근 허용")
//        case .limited:
//            print("제한된 접근 허용")
//        default: break
//        }
//    }
}
