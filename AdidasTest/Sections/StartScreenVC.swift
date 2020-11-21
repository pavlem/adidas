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

        self.view.backgroundColor = .lightGray
    }
    
    @IBAction func openProductList(_ sender: UIButton) {
        print("openProductList....")

        let prodListVC = UIStoryboard.productListTVC!
        navigationController?.pushViewController(prodListVC, animated: true)
    }
}
