//
//  ProductReviewResponse.swift
//  AdidasTest
//
//  Created by Pera Detlic on 22/11/2020.
//

import Foundation

struct ProductReviewResponse: Decodable {
    let productId: String
    let locale: String
    let rating: Int
    let text: String
}
