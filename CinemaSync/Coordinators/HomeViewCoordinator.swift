//
//  MovieSearchCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

final class HomeViewCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController
    
    var _rootViewController: HomeViewController?
    
    var loadingIndicator: UIActivityIndicatorView?
    
    override var rootViewController: UIViewController {
        if let vc = _rootViewController {
            return vc
        } else {
            return UIViewController()
        }
    }
    
    override func deInitialize() {
        super.deInitialize()
        _rootViewController = nil
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.setRootViewController()
    }
    
    func setRootViewController() {
        showLoadingIndicator()
        Task {
            do {
                let topRatedMovies = try await Current.client.fetchTopRatedMovies()
                let popularMovies = try await Current.client.fetchPopularMovies()
                let upcomingMovies = try await Current.client.fetchUpcomingMovies()
                let viewModel = HomeViewModel(topRatedMovies: topRatedMovies.results,
                                              popularMovies: popularMovies.results,
                                              upcomingMovies: upcomingMovies.results)
                await MainActor.run {
                    let homeVC = HomeViewController(viewModel: viewModel)
                    homeVC.coordinator = self
                    self._rootViewController = homeVC
                    self.navigationController.viewControllers = [homeVC]
                }
            } catch {
                print("Failed to fetch movies: \(error)")
            }
            hideLoadingIndicator()
        }
    }
    
    func showLoadingIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = navigationController.view.center
        indicator.startAnimating()
        self.loadingIndicator = indicator
        DispatchQueue.main.async {
            self.navigationController.view.addSubview(indicator)
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator?.stopAnimating()
            self.loadingIndicator?.removeFromSuperview()
            self.loadingIndicator = nil
        }
    }
}

extension HomeViewCoordinator: HomeViewControllerDelegate {
    func didTapSeeAll(_ cell: MoviesSectionsCell, for section: MoviesSections) {
        let coord = SeeAllMoviesCoordinator(navigationController: navigationController, sectionType: section)
        start(child: coord)
    }
}
