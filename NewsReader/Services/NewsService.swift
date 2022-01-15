//
//  NewsService.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import Foundation
import Combine
import UIKit


protocol NewsService {
    func fetchFeed()
    func fetchNews() -> AnyPublisher<Results, APIError>
    func fetchImageUrl(url: URL) -> AnyPublisher<UIImage, APIError>
    func likeNews(id: Int, token: String)
    func fatchFavs(token: String) -> AnyPublisher<Results, APIError>
}

struct DefaultNewsService: NewsService {

    let newsRepository: NewsRepository

    init(newsRepository: NewsRepository) {
        self.newsRepository = newsRepository
    }

    func fetchFeed() {}

    func fetchNews() -> AnyPublisher<Results, APIError> {
        return newsRepository.fetchNews()
    }

    func fatchFavs(token: String) -> AnyPublisher<Results, APIError> {
        return newsRepository.fetchFavNews(autToken: token)
    }

    func fetchImageUrl(url: URL) -> AnyPublisher<UIImage, APIError> {
        return newsRepository.fetchPhotoImage(url: url)
    }

    func likeNews(id: Int, token: String) {
        return newsRepository.likeNews(id: id, token: token)
    }


}
