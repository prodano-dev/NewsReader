//
//  News.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 08/11/2021.
//

import Foundation

struct News: Codable, Equatable {

    let id: Int
    let title: String
    let summary: String
    let publishDate: String
    let imageUrl: String
    let url: String
    let categories: [Categories]

    var newsURL: URL {
        return URL(string: url)!
    }
    var urlImage: URL {
        return URL(string: imageUrl)!
    }

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case summary = "Summary"
        case publishDate = "PublishDate"
        case imageUrl = "Image"
        case url = "Url"
        case categories = "Categories"
    }

}

struct Categories: Codable, Equatable {

    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}

struct Results: Codable, Equatable {
    let news: [News]

    enum CodingKeys: String, CodingKey {
        case news = "Results"
    }
}
