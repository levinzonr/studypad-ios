//
//  AppCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

protocol AppFlowDelegate : class {
    func showMain()
    func showLogin()
}

class AppCoordinator : Coordinator {
    
    var dependencies: AllDependencies
    let window: UIWindow
    var children: [Coordinator] = []
    
    init(window: UIWindow, deps: AllDependencies = DependencyManager.shared) {
        self.window = window
        self.dependencies = deps
    }
    
    func start() {
        defer {
            self.window.makeKeyAndVisible()
        }
        
        if (dependencies.userManager.isLoggedIn()) {
            showMain()
        } else {
            showLogin()
        }
    }
    
}

extension AppCoordinator : AppFlowDelegate {
    
    
    func showMain()  {
        let coordinator = BottomNavCoordinator(window: window, deps: dependencies, appDelegeate: self)
        coordinator.start()
        children = [coordinator]
        
    }
    
    func showLogin() {
        let coordinator = LoginCoordinator(window: window, deps: dependencies, self)
        coordinator.delegate = self
        coordinator.start()
        children = [coordinator]
    }
    
}
