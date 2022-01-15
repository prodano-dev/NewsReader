//
//  ServicesContainer.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import Foundation

extension DIContainer {

    struct Services {

        let newsService: NewsService
        let userService: UserService

        init(newsService: NewsService, userService: UserService) {
            self.newsService = newsService
            self.userService = userService
        }
    }
}
