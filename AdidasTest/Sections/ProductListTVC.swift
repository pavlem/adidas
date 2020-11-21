//
//  ProductListTVC.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import UIKit

class ProductListTVC: UITableViewController {

    let productList = ["1", "2", "3", "4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Table view data source
extension ProductListTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productListCell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell_ID", for: indexPath) as! ProductListCell
        productListCell.textLabel?.text = productList[indexPath.row]
        return productListCell
    }
}

// MARK: - Table view delegate
extension ProductListTVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        guard let img = (tableView.cellForRow(at: indexPath) as! GameListCell).gameImageView.image else { return }
//        guard let gameName = gamesVMs?[indexPath.row].gameName else { return }
//
//        let gameDetailsVC = GameDetailsVC()
//        gameDetailsVC.gameDetailsVM = GameDetailsVM(gameName: gameName, gameImage: img)
//        present(gameDetailsVC, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return estimatedRowHeight
//    }
}
