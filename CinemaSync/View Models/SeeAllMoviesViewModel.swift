//
//  SeeAllMoviesViewModel.swift
//  CinemaSync
//
//  Created by Semih Güler on 9.08.2024.
//

import Foundation

class SeeAllMoviesViewModel {
    
    let sectionType: MoviesSections
    var movies: Movies?
    var upcomingMovies: UpcomingMovies?
    
    var onLoadingStateChange: ((Bool) -> Void)?
    var onMoviesLoaded: (() -> Void)?
    
    init(sectionType: MoviesSections) {
        self.sectionType = sectionType
        loadMovies()
    }
    
    var movieCount: Int {
        switch sectionType {
        case .popular:
            return movies?.results.count ?? 0
        case .topRated:
            return movies?.results.count ?? 0
        case .upcoming:
            return upcomingMovies?.results.count ?? 0
        }
    }
    
    private func loadMovies() {
        onLoadingStateChange?(true)
        Task {
            do {
                switch sectionType {
                case .popular:
                    movies = try await Current.client.fetchPopularMovies()
                case .topRated:
                    movies = try await Current.client.fetchTopRatedMovies()
                case .upcoming:
                    upcomingMovies = try await Current.client.fetchUpcomingMovies()
                }
                await MainActor.run { [weak self] in
                    self?.onLoadingStateChange?(false)
                    self?.onMoviesLoaded?()
                }
            } catch {
                print("Failed to fetch movies: \(error)")
                await MainActor.run { [weak self] in
                    self?.onLoadingStateChange?(false)
                }
            }
        }
    }
    func movieForIndexPath(_ indexPath: IndexPath) -> Movie? {
        switch sectionType {
        case .popular:
            return movies?.results[indexPath.row]
        case .upcoming:
            return upcomingMovies?.results[indexPath.row]
        default:
            return nil
        }
    }
}
