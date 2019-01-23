//
//  NoteDetailCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

protocol NoteDetailDelegate {
    func showEditNote()
}

class NoteDetailCoordinator: Coordinator {

    
    var children: [Coordinator] = []
    
    var dependencies: AllDependencies
    var navigationController: UINavigationController
    let note: Note
    
    init(deps: AllDependencies, navController: UINavigationController, note: Note) {
        self.dependencies = deps
        self.navigationController = navController
        self.note = note
    }
    
    func start() {
        let presenter = NoteDetailPresenter(note: note, delegate: self)
        let vc = NoteDetailViewController.newInstance(with: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
   
    
}

extension NoteDetailCoordinator : NoteDetailDelegate {
    func showEditNote()  {
        let presenter = NoteEditPresenter(note: note, note.notebookId, dependencies.repository)
        let vc = NoteEditViewController.newInstance(with:  presenter)
        navigationController.pushViewController(vc, animated: true)
    }
}



