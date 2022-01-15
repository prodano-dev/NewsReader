//
//  NewsListCell.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 12/11/2021.
//

import SwiftUI

struct NewsListCell: View {

    let news: News
    let container: DIContainer
    let cancelBag = Cancellable()
    @State var imageNews = UIImage()
    @State private var isLoading = true

    var body: some View {
        HStack {

            if isLoading {
                ProgressView()
            } else {
                Image(uiImage: imageNews)
                    .resizable()
                    .frame(width: 75, height: 75)
                    .cornerRadius(25)
            }
            Text(news.title)
                .font(.subheadline)
        }
        .onAppear {
            fetchImage(url: news.urlImage)
        }
    }

    func fetchImage(url: URL) {
        container
            .services
            .newsService
            .fetchImageUrl(url: url)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { image in
                self.imageNews = image
                self.isLoading = false
            }
            .store(in: cancelBag)

    }
}

//struct NewsListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsListCell(news: MockData.MockedNewsData)
//    }
//}
