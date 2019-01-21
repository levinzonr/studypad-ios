//
//  NotesCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

class NotesCoordianator: Coordinator {
    var children: [Coordinator] = []
    
    var dependencies: AllDependencies
    let navigationController: UINavigationController
    init(navController: UINavigationController, deps: AllDependencies) {
        self.dependencies = deps
        self.navigationController = navController
    }
    
    
    func start() {
        let presenter = NotesPresenterImpl(repo: dependencies.repository)
        let vc = NotesViewController.instantiate(with: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
    

    
    
    
    
    
}

