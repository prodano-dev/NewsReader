//
//  ContentView.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import SwiftUI

struct ContentView: View {

    let container: DIContainer

    var body: some View {
        TabBar(container: container)
            .onAppear {
                resetAut()
            }
    }

    private func resetAut() {
    }
}
