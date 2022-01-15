//
//  NewsDetail.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 12/11/2021.
//

import SwiftUI

struct NewsDetail: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {

        VStack {

            ZStack(alignment: .bottom) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Image(uiImage: viewModel.photoImage)
                        .resizable()
                        .frame(height: 280)
                        .frame(maxWidth: .infinity)
                    ZStack {
                        Color.black
                            .background(
                                    LinearGradient(
                                        gradient:
                                            Gradient(colors: [.white, .black]),
                                        startPoint: .top, endPoint: .bottom
                                    )
                                )
                            .opacity(0.4)
                        Group {
                            Text(viewModel.news.title)
                                    .font(.headline)
                                .foregroundColor(.white)
                        }
                        .frame(maxHeight: .infinity)
                        .frame(alignment: .bottom)

                    }.frame(alignment: .bottom)
                }
            }

            HStack {
                ForEach(0..<viewModel.news.categories.count) { index in
                    Text(viewModel.news.categories[index].name)
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .padding(.leading, 5)
                }
                Spacer()
            }
            ScrollView(.vertical) {
                HStack {
                    Spacer()
                    Text(viewModel.news.publishDate)
                        .font(.footnote)
                        .padding(5)
                }
                Text(viewModel.news.summary)
                    .font(.subheadline)
                    .padding(.horizontal)

            }
            Group {
                Button {
                    actionSheet()

                } label: {
                    HStack {
                        Text("Share article ")
                            .font(.callout)
                            .foregroundColor(.white)
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                    }

                }
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(12)
                .padding()
                
            }
            .frame(alignment: .bottom)
        }
        .onAppear(perform: {
            viewModel.fetchImage()
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    //UIApplication.shared.open(viewModel.news.newsURL, options: [:]) { Bool in
                        viewModel.login()
                    //}
                }, label: {
                            Image(systemName: "safari")
                        })

                  }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    didTappedFavoriteButton()
                }, label: {
                            Image(systemName: "star")
                        })

                  }

        }

    }
    private func didTappedFavoriteButton() {

        viewModel.likeNewsItem()
        
    }

    func actionSheet() {

        let activityVC = UIActivityViewController(
            activityItems: [viewModel.news.title, viewModel.news.newsURL],
            applicationActivities: nil
        )


           UIApplication
            .shared
            .windows
            .first?
            .rootViewController?
            .present(activityVC, animated: true, completion: nil)
       }
}
