//
//  MockData.swift
//  NewsReader_Stundent500803288
//
//  Created by Danny Prodanovic on 12/11/2021.
//

import Foundation

struct MockData {

    static let MockedNewsData = News(
        id: 134069,
        title: "Van der Breggen en Blaak kondigen afscheid aan als wielrenster",
        summary: "Anna van der Breggen en Chantal Blaak hebben zondag hun afscheid aangekondigd als wielrenster. De wereldtoppers stoppen over respectievelijk anderhalf en twee jaar en gaan daarna verder als ploegleidster.",
        publishDate: "2020-05-10T15:14:07",
        imageUrl: "https://media.nu.nl/m/k3zx972ap9ap_sqr256.jpg/van-der-breggen-en-blaak-kondigen-afscheid-aan-als-wielrenster.jpg",
        url: "https://www.nu.nl/voetbal/6050332/brighton-predikt-voorzichtigheid-met-valse-start-maken-we-levens-kapot.html",
        categories: [
            Categories(id: 4270, name: "Sport"),
            Categories(id: 4271, name: "Wielrennen"),
            Categories(id: 4271, name: "Binnenland"),
            Categories(id: 4271, name: "Coranovirus"),
        ]
    )
}
