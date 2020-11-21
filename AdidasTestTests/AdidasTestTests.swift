//
//  AdidasTestTests.swift
//  AdidasTestTests
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import XCTest
@testable import AdidasTest

class AdidasTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductDetailsVM() {
        let productListVM = ProductListVM(name: "Product name: Fancy shoes", currency: "Eur", price: "Product price: 400", id: "12345", description: "Product description: This is a very nice nice nice product", imgUrl: "123", reviews: "123")
        let productDetailsVM = ProductDetailsVM(productListVM: productListVM)

        XCTAssert(productDetailsVM.name == "Fancy shoes", "error....")
        XCTAssert(productDetailsVM.price == "Price: 400", "error....")
        XCTAssert(productDetailsVM.description == "This is a very nice nice nice product", "error....")
    }

    func testProductListVM() {
        let reviews = getReviews()

        let productResponse1 = ProductResponse(name: "Dark Shoes", currency: "EUR", price: 99, id: "123", description: "Nice dark shoes", imgUrl: "qwe", reviews: reviews)


        var productListVM = ProductListVM(productResp: productResponse1)

        XCTAssert(productListVM.name == "Product name: Dark Shoes", "error....")
        XCTAssert(productListVM.price == "Product price: 99", "error....")
        XCTAssert(productListVM.description == "Product description: Nice dark shoes", "error....")

        let productResponse2 = ProductResponse(name: "Dark Shoes", currency: "EUR", price: 160, id: "123", description: "Nice dark shoes", imgUrl: "qwe", reviews: reviews)

        productListVM = ProductListVM(productResp: productResponse2)
        XCTAssert(productListVM.price == "Call us....", "error....")
    }

    func testGetReviewsTuple() {
        let reviewsTuple = ProductListVM.getReviews(fromArrayOfReviews: getReviews())
        XCTAssert(reviewsTuple.reviewCount == 4, "error....")
        XCTAssert(reviewsTuple.reviews == "Review 1:\nRating: 1\nRating is 1\n\n\nReview 2:\nRating: 2\nRating is 2\n\n\nReview 3:\nRating: 3\nRating is 3\n\n\nReview 4:\nRating: 4\nRating is 4\n\n\n", "error....")
    }

    func testAddReview() {
        let existingReviews = ProductListVM.getReviews(fromArrayOfReviews: getReviews())
        let prodReview = ProductReviewResponse(productId: "1234", locale: "en", rating: 4, text: "Nice Shoes...")
        let newReviewString = ProductListVM.addReview(rating: prodReview, existingReviews: existingReviews.reviews, numberOfReviews: existingReviews.reviewCount)
        XCTAssert(newReviewString == "Review 1:\nRating: 1\nRating is 1\n\n\nReview 2:\nRating: 2\nRating is 2\n\n\nReview 3:\nRating: 3\nRating is 3\n\n\nReview 4:\nRating: 4\nRating is 4\n\n\nReview 4:\nRating: 4\nNice Shoes...\n\n\n")
    }

    func testGetProductsFromJSONResponse() {
        let asyncExpectation = expectation(description: "Async block executed")

        AdidasTestTests.fetchMOCProducts { (products) in
            XCTAssert(products.count == 38)
            let firstProduct = products.first!
            XCTAssert(firstProduct.name == "product 1")
            XCTAssert(firstProduct.reviews.count == 28)

            asyncExpectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    // MARK: - Helper
    func getReviews() -> [ProductReviewResponse] {
        let productReviewResponse1 = ProductReviewResponse(productId: "1111", locale: "en", rating: 1, text: "Rating is 1")
        let productReviewResponse2 = ProductReviewResponse(productId: "1111", locale: "en", rating: 2, text: "Rating is 2")
        let productReviewResponse3 = ProductReviewResponse(productId: "1111", locale: "en", rating: 3, text: "Rating is 3")
        let productReviewResponse4 = ProductReviewResponse(productId: "1111", locale: "en", rating: 4, text: "Rating is 4")

        let reviews = [productReviewResponse1, productReviewResponse2, productReviewResponse3, productReviewResponse4]
        return reviews
    }

    static func fetchMOCProducts(delay: Int = 0, completion: @escaping ([ProductResponse]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            let filePath = "productsMOC"
            AdidasTestTests.loadJsonDataFromFile(filePath, completion: { data in
                if let json = data {
                    do {
                        let products = try JSONDecoder().decode([ProductResponse].self, from: json)
                        completion(products)
                    } catch _ as NSError {
                        fatalError("Couldn't load data from \(filePath)")
                    }
                }
            })
        }
    }

    static func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch let error {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
