//
//  MovieSearchViewController.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit
import SnapKit

class MovieSearchViewController: UIViewController {
    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        Task {
            do {
                let movies = try await Current.client.fetchUpcomingMovies()
                print(movies)
            } catch {
                print("Failed to fetch movies: \(error)")
            }
        }
    }
}
