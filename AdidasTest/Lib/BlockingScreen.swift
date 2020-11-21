//
//  UINavigationController+Extension.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 22/11/2020.
//

import UIKit

class BlockingScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BlockingScreen {
    static func start() {
        let blockingScr = BlockingScreen(frame: UIScreen.main.bounds)
        setActivityIndicator(onView: blockingScr)
        UIApplication.keyWindow!.addSubview(blockingScr)
    }
    
    static func setActivityIndicator(onView view: UIView) {
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.color = .white
        activityView.center = view.center
        view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    static func stop() {
        if let keyWindow = UIApplication.keyWindow {
            for view in keyWindow.subviews where view is BlockingScreen {
                view.removeFromSuperview()
            }
        }
    }
}

extension UIApplication {
    static var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
    }
}

