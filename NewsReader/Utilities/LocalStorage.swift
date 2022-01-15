//
//  LocalStorage.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 19/11/2021.
//

import KeychainAccess
import Foundation

final class LocalStorage: ObservableObject {
    private let keychain: Keychain = .init()
    private var accessTokenKey: String = "accessToken"
    let session: URLSession
    let base: String

    init(session: URLSession, base: String) {
        self.session = session
        self.base = base
    }

    var accessToken: String? {
        get {
            try? keychain.get(accessTokenKey)
        }
        set(newValue) {
            guard let accessToken = newValue else {
                try? keychain.remove(accessTokenKey)

                return
            }
            try? keychain.set(accessToken, key: accessTokenKey)

        }
    }

    func login(endpoint: APIRoute) {

        let request = endpoint.urlRequest(baseURL: base)
        session.dataTask(with: request) { data, response, error in

            guard let data = data else { return }

            let result = try! JSONDecoder().decode(LoginResponse.self, from: data)
            if !result.authToken.isEmpty {
                DispatchQueue.main.async {
                    self.accessToken = result.authToken
                    print(self.accessToken)
                }
            }
        }
        .resume()
    }
}
