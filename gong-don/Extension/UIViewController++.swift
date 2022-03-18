//
//  UIViewController++.swift
//  gong-don
//
//  Created by 김동규 on 2022/02/14.
//

import UIKit

extension UIViewController {
    
    func pushView(VC: UIViewController) {
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func popView() {
        self.navigationController?.popViewController(animated: true)
    }
}

// Navigation Bar Setting
extension UIViewController {
    func setUpNavBar() {
        let navigationBar = self.navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .systemGray3
        navigationBarAppearance.backgroundColor = .white
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        navigationBar?.tintColor = .black
        navigationBar?.topItem?.backButtonTitle = ""
    }
}

extension UIViewController {
    func animateWithKeyboard(noti: NSNotification, animations: ((_ keyboardFrame: CGRect) -> Void)?) {
        // Extract the duration of the keyboard animation
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = noti.userInfo![durationKey] as! Double
        
        // Extract the final frame of the keyboard
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrameValue = noti.userInfo![frameKey] as! NSValue
        
        // Extract the curve of the iOS keyboard animation
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let curveValue = noti.userInfo![curveKey] as! Int
        let curve = UIView.AnimationCurve(rawValue: curveValue)!
        
        // Create a property animator to manage the animation
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            // Perform the necessary animation layout updates
            animations?(keyboardFrameValue.cgRectValue)
            
            // Required to trigger NSLayoutConstraint changes
            // to animate
            self.view?.layoutIfNeeded()
        }
        
        // Start the animation
        animator.startAnimation()
    }
}
