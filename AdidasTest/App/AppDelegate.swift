//
//  AppDelegate.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setRootVC()
        return true
    }

    private func setRootVC() {
        window = UIWindow()
        window?.makeKeyAndVisible()

        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "StartVC_ID")
        window?.rootViewController = vc
    }
}

