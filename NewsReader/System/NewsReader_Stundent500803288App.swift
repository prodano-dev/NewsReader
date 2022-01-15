//
//  NewsReader_Stundent500803288App.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import SwiftUI

@main
struct NewsReader_Stundent500803288App: App {
    let environment = AppEnviroment.bootstrap()

    var body: some Scene {
        WindowGroup {
            ContentView(container: environment.container)
        }
    }
}
