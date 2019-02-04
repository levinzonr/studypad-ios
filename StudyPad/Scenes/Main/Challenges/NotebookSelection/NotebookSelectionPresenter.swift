//
//  NotebookSelectionPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class NotebookSelectionPresenter {
    // MARK: - Properties
    let interactor: NotebookSelectionInteractorInput
    weak var output: NotebookSelectionPresenterOutput?
    
    // Your custom coordinator
     weak var coordinator: NotebookSelectionCoordinatorInput?

    // MARK: - Init
    init(interactor: NotebookSelectionInteractorInput,
         coordinator: NotebookSelectionCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension NotebookSelectionPresenter: NotebookSelectionPresenterInput {
    func viewCreated() {
        interactor.perform(NotebookSelection.Request.GetNotebooks())
    }

    func handle(_ action: NotebookSelection.Action) {
        print("handled")
        switch action {
        case .notebookSelected(let notebook):
            coordinator?.onNotebookSelected(notebook)
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension NotebookSelectionPresenter: NotebookSelectionInteractorOutput {
    
    func present(_ response: [Notebook]) {
        print("present")
        if (response.count > 0) {
            output?.display(response)
        } else {
            output?.display(.empty)
        }
    }
    

}
