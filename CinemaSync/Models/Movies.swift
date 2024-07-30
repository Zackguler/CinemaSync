//
//  Movies.swift
//  CinemaSync
//
//  Created by Semih Güler on 30.07.2024.
//

import Foundation

public struct Movies: Codable {
    public let page: Int
    public let results: [Movie]
    public let totalPages: Int
    public let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: Codable {
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let posterPath: String?
    public let backdropPath: String?
    public let genreIds: [Int]
    public let originalLanguage: String
    public let originalTitle: String
    public let popularity: Double
    public let voteAverage: Double
    public let voteCount: Int
    public let adult: Bool
    public let video: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case video
    }
}
