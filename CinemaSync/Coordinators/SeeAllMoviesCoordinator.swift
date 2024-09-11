//
//  SeeAllMoviesCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 9.08.2024.
//

import UIKit

final class SeeAllMoviesCoordinator: BaseCoordinator {
    
    let navigationController: UINavigationController
    
    let sectionType: MoviesSections
    
    private lazy var _rootViewController: SeeAllMoviesViewController = {
        let viewModel = SeeAllMoviesViewModel(sectionType: sectionType)
        let viewController = SeeAllMoviesViewController(viewModel: viewModel)
        viewController.delegate = self
        viewController.hidesBottomBarWhenPushed = true
        return viewController
    }()
    
    // MARK: - Coordinator Overrides
    
    override var rootViewController: UIViewController {
        return _rootViewController
    }
    
    override func start() {
        super.start()
        navigationController.interactivePopGestureRecognizer?.delegate = self
        navigationController.pushViewController(rootViewController, animated: true)
    }
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, sectionType: MoviesSections) {
        self.navigationController = navigationController
        self.sectionType = sectionType
    }
}

extension SeeAllMoviesCoordinator: UIGestureRecognizerDelegate { }

extension SeeAllMoviesCoordinator: SeeAllMoviesDelegate {
    func didTapClose(_ viewController: SeeAllMoviesViewController) {
        navigationController.popToRootViewController(animated: true)
    }
}
