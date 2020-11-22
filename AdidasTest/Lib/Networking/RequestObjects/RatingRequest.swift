//
//  RatingRequest.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 22/11/2020.
//

import Foundation

struct RatingRequest: Encodable {
    let productId: String
    let locale: String
    let rating: Int
    let text: String
}

extension RatingRequest {

    static func bodyParametersFor(ratingRequest: RatingRequest) -> JSON {
        let params: [String: Any] = [
            "productId": ratingRequest.productId,
            "locale": ratingRequest.locale,
            "rating": ratingRequest.rating,
            "text": ratingRequest.text
        ]
        return params
    }
}
