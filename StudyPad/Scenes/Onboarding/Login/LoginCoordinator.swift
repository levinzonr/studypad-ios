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
    var delegate: AppFlowDelegate? = nil
    
    let navigationController: UINavigationController
    let window: UIWindow
    init(window: UIWindow, deps: AllDependencies, _ app: AppFlowDelegate) {
        self.window = window
        self.delegate = app
        self.dependencies = deps
        navigationController = UINavigationController()
    }
    
    func start() {
        let presenter = LoginPresenter(deps: dependencies, coordinator: self)
        let vc = LoginViewController.newInstance(with: presenter)
        self.window.rootViewController = navigationController
        navigationController.setViewControllers([vc], animated: true)

    }
    
}

protocol LoginFlowDelegate : class {
    
    func finish()
    
    func showSignup()
    
}

extension LoginCoordinator : LoginFlowDelegate {
    func finish() {
        delegate?.showMain()
    }
    
    func showSignup() {
        let coordinator = SignupCoordinator(nav: navigationController)
        children.append(coordinator)
        coordinator.delegate = self
        coordinator.start()
    }
    
    
    
    
    
}
