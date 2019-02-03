//
//  ProfileCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit
final class ProfileCoordinator : Coordinator {
    var dependencies: AllDependencies
    
    var children: [Coordinator] = []
    let appDelegate: AppFlowDelegate
    let navigationController: UINavigationController
    init(deps: AllDependencies = DependencyManager.shared, nav: UINavigationController, appDelegate: AppFlowDelegate) {
        self.dependencies = deps
        self.navigationController = nav
        self.appDelegate = appDelegate
    }
    
    func start() {
        let presenter = ProfilePresenter(dependencies.userManager, coordinator: appDelegate)
        let vc = ProfileViewController.newInstance(with: presenter)
        navigationController.setViewControllers([vc], animated: false)
        vc.title = "Profile"
    
    }
    
}
