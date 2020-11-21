//
//  UIStoryboard+Extension.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import UIKit

extension UIStoryboard {

    static var main: UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }

    static var productListTVC: ProductListTVC? { return UIStoryboard.main.instantiateViewController(withIdentifier: "ProductListTVC_ID") as? ProductListTVC }

    static var startScreenVC: StartScreenVC? { return UIStoryboard.main.instantiateViewController(withIdentifier: "StartScreenVC_ID") as? StartScreenVC }
}


