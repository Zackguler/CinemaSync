//
//  NetworkService.swift
//  CinemaSync
//
//  Created by Semih Güler on 30.07.2024.
//

import Foundation

private enum Endpoint {
    private static let baseURL = "https://api.themoviedb.org/3/movie/"
    case popular
    case topRated
    case upcoming
    var url: String {
        switch self {
        case .popular:
            return "\(Endpoint.baseURL)popular"
        case .topRated:
            return "\(Endpoint.baseURL)top_rated"
        case .upcoming:
            return "\(Endpoint.baseURL)upcoming"
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case missingToken
}

public class NetworkService: ServiceType {
    func fetch<T: Decodable>(endpoint: String, type: T.Type) async throws -> T {
        guard let apiToken = ProcessInfo.processInfo.environment["API_TOKEN"] else {
            throw NetworkError.missingToken
        }
        guard var components = URLComponents(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language",
                         value: "en-US"),
            URLQueryItem(name: "page",
                         value: "1")
        ]
        components.queryItems = queryItems
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiToken)"
        ]
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError.invalidResponse
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}

extension NetworkService: MoviesService {
    public func fetchPopularMovies() async throws -> Movies {
        let movies: Movies = try await fetch(
            endpoint: Endpoint.popular.url,
            type: Movies.self
        )
        return movies
    }
    
    public func fetchTopRatedMovies() async throws -> Movies {
        let movies: Movies = try await fetch(
            endpoint: Endpoint.topRated.url,
            type: Movies.self
        )
        return movies
    }
    
    public func fetchUpcomingMovies() async throws -> UpcomingMovies {
        let movies: UpcomingMovies = try await fetch(
            endpoint: Endpoint.upcoming.url,
            type: UpcomingMovies.self
        )
        return movies
    }
}
