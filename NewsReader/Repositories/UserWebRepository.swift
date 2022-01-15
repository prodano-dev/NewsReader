//
//  UserWebRepository.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 09/11/2021.
//

import Foundation

protocol UserRepository: API {
    func register(username: String, password: String)
    func login(username: String, password: String)
}

struct DefaultUserRepository: UserRepository {

    let session: URLSession
    let baseURL: String

    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }


    func register(username: String, password: String) {

        let route = APIRoute(
            method: .post,
            path: APIRoute.Path.User.register,
            headers: ["Content-Type": "application/json"])

        route.body = .dictonary([
            "UserName": username,
            "Password": password
        ])

        register(endpoint: route)
    }

    func login(username: String, password: String) {

        let route = APIRoute(
            method: .post,
            path: APIRoute.Path.User.login,
            headers: ["Content-Type": "application/json"])

        route.body = .dictonary([
            "UserName": username,
            "Password": password
        ])


   
    }
}
