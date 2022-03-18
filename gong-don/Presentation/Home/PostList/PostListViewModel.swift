//
//  PostListViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/11.
//

import Foundation

class PostListViewModel {
    var postList: [PostModel] = []
    
    func requestPostList(categoryTitle: String = "ALL", successHandler: @escaping () -> Void) {
        var category = "ALL"
        
        switch (categoryTitle) {
        case "디자인": category = "DESIGN"
        case "IT": category = "IT"
        case "미디어": category = "MEDIA"
        case "번역": category = "TRANSLATION"
        case "문서": category = "DOCUMENT"
        case "스터디": category = "STUDY"
        default: category = "ALL"
        }
        
        PostService.shared.getPostList(category: category, successHandler: { data in
            self.postList = data
            successHandler()
        })
    }
}
