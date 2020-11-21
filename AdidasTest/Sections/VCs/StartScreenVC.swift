//
//  StartScreenVC.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import UIKit

class StartScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func openProductList(_ sender: UIButton) {
        navigationController?.pushViewController(UIStoryboard.productListTVC, animated: true)
    }
}
