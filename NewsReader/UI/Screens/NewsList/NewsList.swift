//
//  NewsList.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 09/11/2021.
//

import SwiftUI

struct NewsList: View {

    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {

        NavigationView {
            List(viewModel.news, id: \.id) { news in
                NavigationLink {
                    NewsDetail(viewModel: NewsDetail.ViewModel(
                        container: viewModel.container, news: news))
                } label: {
                    NewsListCell(news: news, container: viewModel.container)
                }
                .navigationTitle("News")
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.fetchNews()
                    }) {
                        Text("Refresh")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Login")
                    }

                }
            }

        }
        .onAppear {
            viewModel.fetchNews()
        }


    }
}
