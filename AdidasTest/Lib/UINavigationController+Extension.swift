//
//  UINavigationController+Extension.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 22/11/2020.
//

import UIKit

struct NavigationTransitionDuration {
    static let push = 0.3
    static let pop = 0.8
}

extension UINavigationController {
    func customPush(_ viewController: UIViewController, animationOption: UIView.AnimationOptions? = nil, duration: Double? = nil) {
        self.navigationBar.topItem?.title = ""
        self.pushViewController(viewController, animated: false)
        if let transitionView = self.view {
            UIView.transition(with: transitionView, duration: duration ?? NavigationTransitionDuration.push, options: animationOption ?? .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
