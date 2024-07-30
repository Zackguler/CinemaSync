//
//  ServiceType.swift
//  CinemaSync
//
//  Created by Semih Güler on 30.07.2024.
//

import Combine

public protocol ServiceType: MoviesService { }

public protocol MoviesService {
    
    // MARK: - Movies
    
    func fetchPopularMovies() async throws -> Movies
    
    func fetchTopRatedMovies() async throws -> Movies
    
    func fetchUpcomingMovies() async throws -> UpcomingMovies
}
