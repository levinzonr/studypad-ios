//
//  NotebooksCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

final class NotebooksCoordinator: Coordinator {
    
    var children: [Coordinator] = []
    var dependencies: AllDependencies

    let navigationController : UINavigationController
    init(navigationController: UINavigationController, deps: AllDependencies = DependencyManager.shared) {
        self.navigationController = navigationController
        self.dependencies = deps
    }
    
    func start() {
        let viewModel = NotebooksViewModel(repo: dependencies.repository)
        let vc = NotebooksViewController.instantiate(with: viewModel)
        navigationController.setViewControllers([vc], animated: false)
        print("Start")
        
    }
    
}
