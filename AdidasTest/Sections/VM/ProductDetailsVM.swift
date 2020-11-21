//
//  ProductDetailsVM.swift
//  AdidasTest
//
//  Created by Pera Detlic on 22/11/2020.
//

import Foundation

struct ProductDetailsVM {
    let name: String
    let currency: String
    let price: String
    let id: String
    let description: String
    let imgUrl: String
    let reviews: String
}

extension ProductDetailsVM {
    init(productListVM: ProductListVM) {
        self.name = productListVM.name.replacingOccurrences(of: "Product name: ", with: "")
        self.currency = productListVM.currency
        self.price = productListVM.price.replacingOccurrences(of: "Product price: ", with: "Price: ")
        self.id = productListVM.id
        self.description = productListVM.description.replacingOccurrences(of: "Product description: ", with: "")
        self.imgUrl = productListVM.imgUrl
        self.reviews = productListVM.reviews
    }
}
