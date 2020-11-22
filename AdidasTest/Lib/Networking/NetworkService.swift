//
//  NetworkService.swift
//  AdidasTest
//
//  Created by Pera Detlic on 22/11/2020.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
    case jsonDecodeErr(description: String)
    case pageNotFound
    case clientRelated
    case serverRelated
}

public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

class NetworkService: NSObject {
    func getResponseError(httpResponse: HTTPURLResponse) -> NetworkError {
        // This is just to ilustrate handling of httpResponse non 200 codes, in this example for 404 I made .pageNotFound, then for 400 to 500 .clientRelated and for 500..<600 .serverRelated
        if httpResponse.statusCode == 404 {
            return .pageNotFound
        } else if (400..<500) ~= httpResponse.statusCode {
            return .clientRelated
        } else if (500..<600) ~= httpResponse.statusCode {
            return .serverRelated
        } else {
            return .unknown
        }
    }
}

// This is just a helper functin I made to log response
extension NetworkService {
    func logResponse(data: Data?, httpResponse: URLResponse?, error: Error?) {
        print("⏪⏪⏪⏪⏪⏪⏪")
        print("data: \n\(String(describing: data))\n")
        print("response: \n\(String(describing: httpResponse))\n")
        print("error: \n\(String(describing: error))\n")

        guard let data = data else {
            print("⏪⏪⏪⏪⏪⏪⏪")
            return
        }

        print(data.prettyPrintedJSONString ?? "")
        print("⏪⏪⏪⏪⏪⏪⏪")
    }
}

// This is just helper functin I made to log request
extension URLRequest {
    func log() {
        print("⏩⏩⏩⏩⏩⏩⏩")
        print("METHOD: \(httpMethod ?? "")")
        print("URL: \(self)")
        if let body = httpBody {
            print("BODY: \n \(body.toString() ?? "")")
        } else {
            print("BODY: None")
        }
        print("HEADERS: \n \(allHTTPHeaderFields ?? ["":""])")
        print("⏩⏩⏩⏩⏩⏩⏩")
    }
}

// Some other helper extensions meant for NETWORKING layer
extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

extension URLRequest {
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON?, headers: HTTPHeaders? = nil) {
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue

        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")

        if headers != nil {
            for (key, value) in headers! {
                setValue(value, forHTTPHeaderField: key)
            }
        }

        switch method {
        case .post, .put, .patch:
            guard let params = params else { break }
            let dataForBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            //let payloadString = dataForBody.base64EncodedString(options: []); //aprint("payloadString for body: \(payloadString)")
            httpBody = dataForBody
        default:
            break
        }
    }
}

extension URL {
    init(baseUrl: String, path: String, params: JSON?, method: RequestMethod) {
        var components = URLComponents(string: baseUrl)!
        components.path += path

        switch method {
        case .get, .delete:
            guard let params = params else { break }
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }

        self = components.url!
    }
}
