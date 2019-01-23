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
        let presenter = NotebooksPresenter(repo: dependencies.repository, self)
        let vc = NotebooksViewController.instantiate(with: presenter)
        navigationController.setViewControllers([vc], animated: false)
        print("Start")

    }
    
}

extension NotebooksCoordinator : NotebooksCoordinatorDelegate {
    
    func showNotesView(notebook: Notebook) {
        let coordinator = NotesCoordianator(navController: navigationController, deps: dependencies, notebook: notebook)
        children.append(coordinator)
        coordinator.start(notebook: notebook)
        
    }
    

}
