//
//  KeyboardProtocol.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/25.
//

import Foundation

protocol KeyboardProtocol {
    func addKeyBoardAnimation(sender: AnyObject)
    func setKeyBoardAction()
    func removeKeyBoardAction()
    func keyboardWillShow(noti: NSNotification)
    func keyboardWillHide(noti: NSNotification)
}
