//
//  HomeViewModel.swift
//  CinemaSync
//
//  Created by Semih Güler on 1.08.2024.
//

import Foundation

public enum MoviesSections: Int, CaseIterable {
    case popular
    case topRated
    case upcoming

    var title: String {
        switch self {
        case .popular:
            return "Popular Movies"
        case .topRated:
            return "Top Rated Movies"
        case .upcoming:
            return "Upcoming Movies"
        }
    }
}

class HomeViewModel {
    var topRatedMovies: [Movie]
    var popularMovies: [Movie]
    var upcomingMovies: [Movie]

    init(topRatedMovies: [Movie], popularMovies: [Movie], upcomingMovies: [Movie]) {
        self.topRatedMovies = topRatedMovies
        self.popularMovies = popularMovies
        self.upcomingMovies = upcomingMovies
    }

    func cellForRowAt(for section: MoviesSections) -> [Movie] {
        switch section {
        case .popular:
            return popularMovies
        case .topRated:
            return topRatedMovies
        case .upcoming:
            return upcomingMovies
        }
    }
}
