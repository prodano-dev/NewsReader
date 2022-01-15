//
//  FavoritesList.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 19/11/2021.
//

import SwiftUI

struct FavoritesList: View {

    @ObservedObject var viewModel: ViewModel
    
    var body: some View {

        NavigationView {
            if viewModel.news.isEmpty {
                VStack {
                    HStack {
                        Text("No favorites found, please add some.")
                            .font(.headline)
                        Image(systemName: "heart")
                    }
                    Spacer()
                }
            } else {
                List(viewModel.news, id: \.id) { news in
                    NavigationLink(destination: NewsDetail(
                        viewModel: .init(
                            container: viewModel.container,
                            news: news))) {

                                NewsListCell(news: news, container: viewModel.container)

                    }
                }
                .navigationTitle("Favorites")

            }
        }
        .navigationTitle("Favorites")
        .onAppear(perform: viewModel.getFavorites)

    }
}
