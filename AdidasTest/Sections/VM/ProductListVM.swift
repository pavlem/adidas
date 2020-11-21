//
//  ProductListVM.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import Foundation

struct ProductListVM {
    let name: String
    let currency: String
    let price: String
    let id: String
    let description: String
    let imgUrl: String
    let reviews: String
}

extension ProductListVM {
    init(productResp: ProductResponse) {
        self.name = "Product name: \(productResp.name)"
        self.currency = "Currency: \(productResp.currency)"
        
        if productResp.price > 100 { // this is to ilustrate different conditions for view model. For example lets say we want a different string for the prices above and below 100
            self.price = "Call us...."
        } else {
            self.price = "Product price: \(productResp.price)"
        }
        
        self.id = productResp.id
        self.description = "Product description: \(productResp.description)"
        self.imgUrl = productResp.imgUrl
        self.reviews = ProductListVM.getReviews(fromArrayOfReviews: productResp.reviews).reviews
    }
    
    static func getReviews(fromArrayOfReviews reviews: [ProductReviewResponse]) -> (reviews: String, reviewCount: Int) {
        
        var allReviews = ""
        for (index, review) in reviews.enumerated() {
            
            let txt = "Review \(index + 1):"
            allReviews.append(txt)
            allReviews.append("\n")
            allReviews.append("Rating: \(review.rating)\n")
            allReviews.append("\(review.text)\n")
            allReviews.append("\n\n")
        }
        
        return (allReviews, reviews.count)
    }

    static func addReview(rating: ProductReviewResponse, existingReviews: String, numberOfReviews: Int) -> String {

        var allReviews = existingReviews

        let txt = "Review \(numberOfReviews):\n"
        allReviews.append(txt)
        allReviews.append("Rating: \(rating.rating)\n")
        allReviews.append("\(rating.text)\n")
        allReviews.append("\n\n")
        return allReviews
    }
}
