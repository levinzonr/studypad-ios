//
//  BottomNavCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

class BottomNavCoordinator: Coordinator {
    

    var dependencies: AllDependencies
    var children: [Coordinator] = []
    
    private let window: UIWindow
    private let bottomNavController = UITabBarController()
    

    init(window: UIWindow, deps: AllDependencies) {
        self.window = window
        self.dependencies = deps
    }
    
    func start() {
        print("Start boottom nav")
        self.window.rootViewController = bottomNavController
        addCoordinator(.notebooks)
        addCoordinator(.challenges)
        addCoordinator(.settings)
    }
}

private extension BottomNavCoordinator {
    
    enum TabType {
        case notebooks
        case challenges
        case settings
    }
    
    func addCoordinator(_ type: TabType) {
        
        let navController = UINavigationController()
        
        var viewControllers = bottomNavController.viewControllers ?? []
        viewControllers += [navController]
        bottomNavController.setViewControllers(viewControllers, animated: false)
        
        let coordinator: Coordinator
        switch type {
        case .notebooks:
            coordinator = NotebooksCoordinator(navigationController: navController)
            navController.tabBarItem = UITabBarItem(title: "My LIbrary", image: nil, tag: 1)
            
        case.challenges:
            coordinator = NotebooksCoordinator(navigationController: navController)
            navController.tabBarItem = UITabBarItem(title: "Challenges", image: nil, tag: 2)
        case .settings:
            coordinator = NotebooksCoordinator(navigationController: navController)
            navController.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 3)
        }
        children.append(coordinator)
        coordinator.start()
        
    }
}
