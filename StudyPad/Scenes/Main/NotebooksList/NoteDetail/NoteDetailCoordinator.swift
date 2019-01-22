//
//  NoteDetailCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

class NoteDetailCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var dependencies: AllDependencies
    var navigationController: UINavigationController
    
    init(deps: AllDependencies, navController: UINavigationController) {
        self.dependencies = deps
        self.navigationController = navController
    }
    
    func start() {
    
    }
    
    func start(note: Note) {
        let presenter = NoteDetailPresenter(note: note)
        let vc = NoteDetailViewController.newInstance(with: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
}


