//
//  LoginCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

class LoginCoordinator : Coordinator {
    var children: [Coordinator] = []
    
    var dependencies: AllDependencies
    
    let navigationController: UINavigationController
    let window: UIWindow
    init(window: UIWindow, deps: AllDependencies) {
        self.window = window
        self.dependencies = deps
        navigationController = UINavigationController()
    }
    
    func start() {
        
        let vc = LoginViewController.newInstance()
        self.window.rootViewController = navigationController
        navigationController.setViewControllers([vc], animated: true)

    }

}
