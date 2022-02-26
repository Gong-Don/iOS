//
//  Alert.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/26.
//

import UIKit

struct Alert {
    var alertController: UIAlertController
    var title: String
    var message: String
    
    init(title: String, message: String) {
        self.title = title
        self.message = message
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func showAlert() -> UIAlertController {
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        self.alertController.addAction(okAction)
        
        return self.alertController
    }
}

struct ActionSheet {}
