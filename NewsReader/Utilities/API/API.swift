//
//  API.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import Foundation
import Combine
import KeychainAccess

protocol API {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension API {


    func fetchData<Value: Decodable>(endpoint: APIRoute) -> AnyPublisher<Value, APIError> {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            
            return session
                .dataTaskPublisher(for: request)
                .tryMap { response in
                    
                    guard
                        let httpUrlResponse = response.response as? HTTPURLResponse,
                        httpUrlResponse.statusCode == 200
                    else {
                        throw APIError.genericError
                    }
                    return response.data
                }
                .mapError { APIError.map($0) }
                .decode(type: Value.self, decoder: JSONDecoder())
                .mapError { APIError.map($0) }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<Value, APIError>(error: APIError.other(error)).eraseToAnyPublisher()
        }
    }

    func likeNews(endpoint: APIRoute) {

        let request = endpoint.urlRequest(baseURL: baseURL)

        session
            .dataTask(with: request)
            .resume()
    }

    func downloadImage() {}

    func register(endpoint: APIRoute) {

        var request = endpoint.urlRequest(baseURL: baseURL)

        session
            .dataTask(with: request) { data, repsinse, err in
                if let httpResponse = repsinse as? HTTPURLResponse {
                        print(httpResponse.statusCode)
                    }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print(dataString)
                    }

            }
            .resume()
    }

    func login(endpoint: APIRoute) {

        let request = endpoint.urlRequest(baseURL: baseURL)
        var token: String = ""
        session.dataTask(with: request) { data, response, error in

            guard let data = data else { return }

            let result = try! JSONDecoder().decode(LoginResponse.self, from: data)
            if !result.authToken.isEmpty {
                DispatchQueue.main.async {

                }
            }
        }
        .resume()
    }
}

struct RegisterResponse: Codable, Equatable {

    let success: Bool
    let message: String

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case message = "Message"
    }
}

struct LoginResponse: Codable, Equatable {
    let authToken: String

    enum CodingKeys: String, CodingKey {
        case authToken = "AuthToken"
    }
}
