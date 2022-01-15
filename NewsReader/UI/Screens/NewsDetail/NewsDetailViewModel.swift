//
//  NewsDetailViewModel.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 19/11/2021.
//

import Foundation
import SwiftUI

extension NewsDetail {

    class ViewModel: ObservableObject {

        let news: News
        let cancelBag = Cancellable()
        var photoImage = UIImage()
        @Published var isLoading = true

        var container: DIContainer
        private var cancellable = Cancellable()

        init(container: DIContainer, news: News) {
            self.container = container
            self.news = news
        }

        func login() {
            let route = APIRoute(
                method: .post,
                path: APIRoute.Path.User.login,
                headers: ["Content-Type": "application/json"])

            route.body = .dictonary([
                "UserName": "sdf",
                "Password": "Justapassword"
            ])
            container.localStorage.login(endpoint: route)
        }

        public func fetchImage() {
            container
                .services
                .newsService
                .fetchImageUrl(url: news.urlImage)
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .finished:
                        break
                    }
                } receiveValue: { image in
                    self.photoImage = image
                    self.isLoading = false
                }
                .store(in: cancelBag)

        }

        public func likeNewsItem() {
            if let token = container.localStorage.accessToken {
                container
                    .services
                    .newsService
                    .likeNews(id: news.id, token: token)
            }

        }
    }
}
