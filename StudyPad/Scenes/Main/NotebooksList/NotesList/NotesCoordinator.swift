//
//  NotesCoordinator.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

protocol NotesCoordinatorDelegate {
    func showNotesDetail(note: Note)
    func showNoteCreation()
}

class NotesCoordianator: Coordinator {
    var children: [Coordinator] = []
    
    var dependencies: AllDependencies
    let navigationController: UINavigationController
    let notebook: Notebook
    init(navController: UINavigationController, deps: AllDependencies, notebook: Notebook ) {
        self.dependencies = deps
        self.notebook = notebook
        self.navigationController = navController
    }
    
    func start() {
        fatalError()
    }
    
    func start(notebook: Notebook) {
        let presenter = NotesPresenterImpl(repo: dependencies.repository, notebook: notebook, self)
        let vc = NotesViewController.instantiate(with: presenter)
        navigationController.pushViewController(vc, animated: true)
    }
    
}

extension NotesCoordianator : NotesCoordinatorDelegate {
    
    func showNotesDetail(note: Note) {
        let coordinator = NoteDetailCoordinator(deps: dependencies, navController: navigationController, note: note)
        children.append(coordinator)
        coordinator.start()
    }
    
    func showNoteCreation() {
        let presenter = NoteEditPresenter(note: nil, notebook.id, dependencies.repository)
        let vc = NoteEditViewController.newInstance(with:  presenter)
        navigationController.pushViewController(vc, animated: true)
    }
}

