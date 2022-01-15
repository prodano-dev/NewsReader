//
//  DIContainer.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import Foundation
import SwiftUI

struct DIContainer: EnvironmentKey {

    let services: Services
    var localStorage: LocalStorage
    static var defaultValue: Self { self.defaultValue }

    init(services: DIContainer.Services, localStorage: LocalStorage) {
        self.services = services
        self.localStorage = localStorage
    }
}

extension DIContainer {
    struct WebRepositories {
        let newsRepository: NewsRepository
        let userRepository: UserRepository
    }
}
