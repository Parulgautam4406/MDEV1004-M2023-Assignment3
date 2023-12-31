//
//  Movie.swift
//  MDEV1004-M2023-Assignment3
//
//  Created by Parul Gautam on 23/07/23.
//

import Foundation
struct Movie: Codable {
    let _id: String
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let Poster: String
    let Ratings: [Rating]
    let Metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let DVD: String
    let BoxOffice: String
    let Production: String
    let Website: String
    let Response: String
}

struct Rating: Codable {
    let _id: String
    let Source: String
    let Value: String
}

