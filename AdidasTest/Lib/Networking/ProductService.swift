//
//  ProductService.swift
//  AdidasTest
//
//  Created by Pavle Mijatovic on 21/11/2020.
//

import Foundation

class ProductService: NetworkService {
    
    func fetchProducts(completion: @escaping (Result<[ProductResponse], NetworkError>) -> ()) -> URLSessionDataTask? {

        let request = URLRequest(baseUrl: "http://localhost:3001", path: "/product", method: RequestMethod.get, params: nil, headers: nil)
        request.log()

        let task = URLSession.shared.dataTask(with: request) { (data, resp, err) in
            self.logResponse(data: data, httpResponse: resp, error: err)

            DispatchQueue.main.async {
                guard let httpResponse = resp as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode else {
                    let responseErr = self.getResponseError(httpResponse: resp as! HTTPURLResponse)
                    completion(.failure(responseErr))
                    return
                }

                if let data = data {
                    do {
                        let products = try JSONDecoder().decode([ProductResponse].self, from: data)
                        completion(.success(products))
                    } catch let jsonErr {
                        completion(.failure(.jsonDecodeErr(description: String(describing: jsonErr))))
                    }
                } else if err != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }

        task.resume()
        return task
    }

    func getRatings(forRatingId ratingId: String, completion: @escaping (Result<([ProductReviewResponse]), NetworkError>) -> ()) -> URLSessionDataTask? {

        let request = URLRequest(baseUrl: "http://localhost:3002", path: "/reviews/\(ratingId)", method: RequestMethod.get, params: nil, headers: nil)
        request.log()

        let task = URLSession.shared.dataTask(with: request) { (data, resp, err) in
            self.logResponse(data: data, httpResponse: resp, error: err)

            DispatchQueue.main.async {

                guard let httpResponse = resp as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode else {
                    let responseErr = self.getResponseError(httpResponse: resp as! HTTPURLResponse)
                    completion(.failure(responseErr))
                    return
                }

                if let data = data {
                    do {
                        let ratings = try JSONDecoder().decode([ProductReviewResponse].self, from: data)
                        completion(.success(ratings))
                    } catch let jsonErr {
                        completion(.failure(.jsonDecodeErr(description: String(describing: jsonErr))))
                    }
                } else if err != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }

        task.resume()
        return task
    }
    
    func postRating(ratingRequest: RatingRequest, completion: @escaping (Result<ProductReviewResponse, NetworkError>) -> ()) -> URLSessionDataTask? {

        let param = RatingRequest.bodyParametersFor(ratingRequest: ratingRequest)
        let request = URLRequest(baseUrl: "http://localhost:3002", path: "/reviews/\(ratingRequest.productId)", method: RequestMethod.post, params: param, headers: nil)
        request.log()

        let task = URLSession.shared.dataTask(with: request) { (data, resp, err) in
            self.logResponse(data: data, httpResponse: resp, error: err)

            sleep(1) // Just to simulate slower network for ilustrative purposes of blocking screen component

            DispatchQueue.main.async {
                guard let httpResponse = resp as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode else {
                    let responseErr = self.getResponseError(httpResponse: resp as! HTTPURLResponse)
                    completion(.failure(responseErr))
                    return
                }

                if let data = data {
                    do {
                        let ratingResponse = try JSONDecoder().decode(ProductReviewResponse.self, from: data)
                        completion(.success(ratingResponse))
                    } catch let jsonErr {
                        completion(.failure(.jsonDecodeErr(description: String(describing: jsonErr))))
                    }
                } else if err != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }

        task.resume()
        return task
    }
}
