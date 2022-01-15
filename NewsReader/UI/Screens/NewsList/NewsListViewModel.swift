//
//  NewsListViewModel.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 09/11/2021.
//

import Combine
import SwiftUI

extension NewsList {

    class ViewModel: ObservableObject {

        @Published var news: [News]
        let cancelBag = Cancellable()

        let container: DIContainer
        private var cancellable = Cancellable()

        init(container: DIContainer, news: [News] = []) {
            self.container = container
            _news = .init(initialValue: news)
        }

        public func fetchNews() {

            container
                .services
                .newsService
                .fetchNews()
                .sink(receiveCompletion: { err in
                    print(err)
                }, receiveValue: {
                    result in
                    self.news = result.news.sorted { news1, news2 in
                        news1.publishDate > news2.publishDate
                    }
                })
                .store(in: cancelBag)
        }

        public func login() {
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
    }
}
