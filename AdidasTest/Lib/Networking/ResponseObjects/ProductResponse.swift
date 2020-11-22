//
//  ProductResponse.swift
//  AdidasTest
//
//  Created by Pera Detlic on 22/11/2020.
//

import Foundation

struct ProductResponse: Decodable {
    let name: String
    let currency: String
    let price: Int
    let id: String
    let description: String
    let imgUrl: String
    let reviews: [ProductReviewResponse]
}
