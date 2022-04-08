//
//  TagSearchViewModel.swift
//  gong-don
//
//  Created by 김동규 on 2022/03/24.
//

import Foundation
import UIKit

class TagSearchViewModel {
    var fileteredData: [String] = []
    
    var tagModel: TagModel = TagModel(tagResponse: [:])
    
    func requestTagList(successHandler: @escaping () -> Void) {
        TagService.shared.getTagList() { data in
            self.tagModel.tagResponse = data
            successHandler()
        }
    }
    
    func filterTags(str: String) {
        let str = str.lowercased()
        fileteredData = []
        for key in self.tagModel.tagResponse.keys {
            if (key.lowercased().contains(str)) {
                fileteredData.append(key)
            }
        }
        fileteredData.sort()
    }
}
