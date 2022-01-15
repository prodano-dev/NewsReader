//
//  FavoritesViewModel.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 19/11/2021.
//

import Foundation

extension FavoritesList {

    class ViewModel: ObservableObject {

        @Published var news: [News]
        let cancelBag = Cancellable()

        let container: DIContainer

        init(container: DIContainer, news: [News] = []) {
            self.container = container
            _news = .init(initialValue: news)
        }

        func getFavorites() {

            if let token = container.localStorage.accessToken {

                container
                    .services
                    .newsService
                    .fatchFavs(token: token)
                    .sink { err in
                        print(err)
                    } receiveValue: { results in
                        self.news = results.news
                        
                    }
                    .store(in: cancelBag)

            }
        }
    }
}
