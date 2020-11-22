//
//  ProductListTVC.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import UIKit

class ProductListTVC: UITableViewController {

    // MARK: - Properties
    // MARK: Var
    private var productList = [ProductListVM]()
    private var filteredProductList = [ProductListVM]()
    private var dataTask: URLSessionDataTask?
    // MARK: Constants
    private let searchPlaceholder = "Search Product..."
    // MARK: Calculated
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchProducts()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataTask?.cancel()
    }

    // MARK: - Helper
    private func setUI() {
        navigationItem.title = "Products..."
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.tableFooterView!.isHidden = true
    }

    private func fetchProducts() {

        guard ReachabilityHelper.isThereInternetConnection else {
            AlertHelper.simpleAlert(message: ReachabilityHelper.noInternetMessage)
            return
        }
        
        self.dataTask = ProductService().fetchProducts { [weak self] (result) in
            guard let `self` = self else { return }

            switch result {
            case .success(let products):
                let productsVM = products.map { ProductListVM(productResp: $0)}
                self.productList = productsVM
                self.tableView.reloadData()
            case .failure(let netErr):
                AlertHelper.simpleAlert(message: String(describing: netErr))
            }
        }
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = searchPlaceholder
        
        definesPresentationContext = true
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func filter(searchText: String) {
        filteredProductList =  productList.filter { (productListVM: ProductListVM) -> Bool in
            return productListVM.name.lowercased().contains(searchText.lowercased()) || productListVM.description.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating
extension ProductListTVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filter(searchText: searchController.searchBar.text!)
    }
}

// MARK: - Table view data source
extension ProductListTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredProductList.count
        } else {
            return productList.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productListCell = tableView.dequeueReusableCell(withIdentifier: ProductListCell.cellIdentifier, for: indexPath) as! ProductListCell
        
        var vm: ProductListVM
        
        if isFiltering {
            vm = filteredProductList[indexPath.row]
        } else {
            vm = productList[indexPath.row]
        }

        productListCell.productListVM = vm
        return productListCell
    }
}

// MARK: - Table view delegate
extension ProductListTVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var vm: ProductListVM
        
        if isFiltering {
            vm = filteredProductList[indexPath.row]
        } else {
            vm = productList[indexPath.row]
        }
        
        let prodDetailsVC = UIStoryboard.productDetailsVC
        prodDetailsVC.productDetailsVM = ProductDetailsVM(productListVM: vm)

        navigationController?.customPush(prodDetailsVC)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

