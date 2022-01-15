//
//  UserService.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 09/11/2021.
//

import Foundation

protocol UserService {
    func register(username: String, password: String)
    func login(username: String, password: String)
}

struct DefaultUserService: UserService {
    let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    func register(username: String, password: String) {
        userRepository.register(username: "oldNamee.", password: "Justapassword")
    }

    func login(username: String, password: String) {
        userRepository.login(username: username, password: password)
    }
}
