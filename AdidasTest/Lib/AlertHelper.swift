//
//  AlertHelper.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 22/11/2020.
//

import UIKit

struct AlertHelper {

    static func simpleAlert(title: String? = nil, message: String? = nil, vc: UIViewController? = nil) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)

        if let viewController = vc {
            viewController.present(alertController, animated: true)
        } else if let topVC = UIApplication.topPresentedViewController {
            topVC.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIApplication {
    static var topNavigationViewController: UINavigationController? {
        return self.topPresentedViewController as? UINavigationController
    }

    static var topPresentedViewController: UIViewController? {


        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first


        return keyWindow?.rootViewController.flatMap { UIViewController.topPresentedViewController($0) }
    }
}

extension UIViewController {
    fileprivate static func topPresentedViewController(_ viewController: UIViewController) -> UIViewController {
        if let presentedViewController = viewController.presentedViewController {
            return UIViewController.topPresentedViewController(presentedViewController)
        }

        return viewController
    }
}



