//
//  NewsRepository.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import Foundation
import Combine
import UIKit

protocol NewsRepository: API {
    func fetchNews() -> AnyPublisher<Results, APIError>
    func fetchPhotoImage(url: URL) -> AnyPublisher<UIImage, APIError>
    func likeNews(id: Int, token: String)
    func fetchFavNews(autToken: String) -> AnyPublisher<Results, APIError>
}


struct DefaultNewsRepository: NewsRepository {

    let session: URLSession
    let baseURL: String

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func fetchNews() -> AnyPublisher<Results, APIError> {

        let route = APIRoute(
            method: .get,
            path: APIRoute.Path.Articles.articles,
            headers: ["Accept": "application/json"])
    
        return fetchData(endpoint: route)
    }

    func fetchPhotoImage(url: URL) -> AnyPublisher<UIImage, APIError> {

        let request = URLRequest(url: url)

        return session.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let image = UIImage(data: data)
                else { preconditionFailure() }
                return image
            }
            .receive(on: DispatchQueue.main)
            .mapError { APIError.map($0)}
            .eraseToAnyPublisher()
    }

    func fetchFavNews(autToken: String) -> AnyPublisher<Results, APIError> {

        var route = APIRoute(
            method: .get,
            path: APIRoute.Path.Articles.liked,
            headers: [autToken : "x-authtoken"])
        
        return fetchData(endpoint: route)

    }

    func likeNews(id: Int, token: String) {

        let route = APIRoute(
            method: .put,
            path: APIRoute.Path.Articles.likeArticle(articleId: id),
            headers: [token : "x-authtoken"])

        return likeNews(endpoint: route)
    }

}
