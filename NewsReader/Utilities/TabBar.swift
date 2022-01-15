//
//  TabBar.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 19/11/2021.
//

import SwiftUI

struct TabBar: View {

    let container: DIContainer

    var body: some View {

        TabView {
            NewsList(viewModel: .init(container: container))
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }
                .tag(0)

            FavoritesList(viewModel: .init(container: container))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
                .tag(1)
        }
    }
}
