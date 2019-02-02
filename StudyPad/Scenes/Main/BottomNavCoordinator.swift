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
    let appFlowDelegate : AppFlowDelegate

    init(window: UIWindow, deps: AllDependencies, appDelegeate: AppFlowDelegate) {
        self.window = window
        self.dependencies = deps
        self.appFlowDelegate = appDelegeate
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
            navController.tabBarItem = UITabBarItem(title: "My Library", image: #imageLiteral(resourceName: "library"), tag: 1)
            
        case.challenges:
            coordinator = ProfileCoordinator(nav: navController, appDelegate: appFlowDelegate)
            navController.tabBarItem = UITabBarItem(title: "Challenges", image: #imageLiteral(resourceName: "challenges"), tag: 2)
        case .settings:
            coordinator = ProfileCoordinator(nav: navController, appDelegate: appFlowDelegate)
            navController.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "profile"), tag: 3)
        }
        children.append(coordinator)
        coordinator.start()
        
    }
    
    
}
