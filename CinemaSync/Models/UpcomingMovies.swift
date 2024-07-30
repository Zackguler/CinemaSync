//
//  UpcomingMovies.swift
//  CinemaSync
//
//  Created by Semih Güler on 30.07.2024.
//

import Foundation

public struct UpcomingMovies: Codable {
    public let dates: DateRange
    public let page: Int
    public let results: [Movie]
    public let totalPages: Int
    public let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct DateRange: Codable {
    public let maximum: String
    public let minimum: String
}
