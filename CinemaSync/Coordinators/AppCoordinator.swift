//
//  AppCoordinator.swift
//  CinemaSync
//
//  Created by Semih Güler on 27.07.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    
    private lazy var _rootViewController: UIViewController = {
        let viewController = RootViewController()
        viewController.view.backgroundColor = .white
        return viewController
    }()
    
    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override var rootViewController: UIViewController {
        return _rootViewController
    }
    
    override func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        launchMainUI()
    }
    
    private func launchMainUI() {
        let tabBarCoordinator = TabBarCoordinator()
        self.start(child: tabBarCoordinator)
        window.rootViewController = tabBarCoordinator.rootViewController
    }
}
