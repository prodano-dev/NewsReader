//
//  Cancellable.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import Combine

final class Cancellable {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()

    func cancel() {
        subscriptions.removeAll()
    }

    func collect(@Builder _ canncelables: () -> [AnyCancellable]) {
        subscriptions.formUnion(canncelables())
    }

    @resultBuilder
    struct Builder {
        static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
}

extension AnyCancellable {

    func store(in cancel: Cancellable) {
        cancel.subscriptions.insert(self)
    }
}

