//
//  AppEnviroment.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 09/11/2021.
//

import Combine
import UIKit

struct AppEnviroment {
    let container: DIContainer
}

extension AppEnviroment {

    static func bootstrap() -> AppEnviroment {

        let session = configuredURLSession()

        let api = configureWebRepository(session: session)
        let service = configureServices(webRepository: api)
        let localStorage = LocalStorage(session: session,
                                        base: "https://inhollandbackend.azurewebsites.net/api"
        )
        let diContainer = DIContainer(services: service, localStorage: localStorage)

        return AppEnviroment(container: diContainer)
    }

    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        // Volgens mij ging het hierdoor miss met inloggen..
        //configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }

    private static func configureWebRepository(session: URLSession) -> DIContainer.WebRepositories {
        let newsRepository = DefaultNewsRepository(
            session: session,
            baseURL: "https://inhollandbackend.azurewebsites.net/api")
        let userRepository = DefaultUserRepository(
            session: session,
            baseURL: "https://inhollandbackend.azurewebsites.net/api")

        return .init(newsRepository: newsRepository, userRepository: userRepository)
    }

    private static func configureServices(webRepository: DIContainer.WebRepositories) -> DIContainer.Services {

        let newsService = DefaultNewsService(
            newsRepository: webRepository.newsRepository
        )
        let userService = DefaultUserService(
            userRepository: webRepository.userRepository
        )
        return .init(newsService: newsService, userService: userService)
    }
}
