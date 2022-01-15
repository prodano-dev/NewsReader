//
//  APIRoute.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import Foundation
import SwiftUI

public class APIRoute {

    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
        case post = "POST"
    }

    enum Body {
        case none
        case dictonary([String: Any])
    }

    let method: HTTPMethod
    let path: String
    let headers: [String: String]
    var body: Body = .none

    init(method: HTTPMethod, path: String, headers: [String: String]) {
        self.method = method
        self.path = path
        self.headers = headers
    }

    func urlRequest(baseURL: String) -> URLRequest {
        let url = URL(string: baseURL + path)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        for (key, value) in headers {
            request.setValue(key, forHTTPHeaderField: value)

        }

        if method == .post || method == .put {
            switch body {
            case .none: break
            case .dictonary(let bodyDictionary):
                request.httpBody = try? JSONSerialization.data(
                    withJSONObject: bodyDictionary, options: .prettyPrinted
                )
            }
        }
        return request
    }
}

extension APIRoute {

    enum Path {

        enum Articles {
            static var articles: String {
                return "/Articles"
            }

            static func articleWithId(articleId: Int) -> String {
                return "/Articles/\(articleId)"
            }

            static func likeArticle(articleId: Int) -> String {
                return "/Articles/\(articleId)/like"
            }

            static var liked: String {
                return "/Articles/liked"
            }
        }

        enum User {
            static var register: String {
                return "/Users/register"
            }

            static var login: String {
                return "/Users/login"
            }
        }
    }
}
