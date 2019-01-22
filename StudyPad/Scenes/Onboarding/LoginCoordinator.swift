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
    var delegate: LoginFlowDelegate? = nil
    
    let navigationController: UINavigationController
    let window: UIWindow
    init(window: UIWindow, deps: AllDependencies) {
        self.window = window
        self.dependencies = deps
        navigationController = UINavigationController()
    }
    
    func start() {
        let presenter = LoginPresenter(deps: dependencies, coordinator: delegate!)
        let vc = LoginViewController.newInstance(with: presenter)
        self.window.rootViewController = navigationController
        navigationController.setViewControllers([vc], animated: true)

    }
    
}

protocol LoginFlowDelegate {
    
    func finish()
    
}
