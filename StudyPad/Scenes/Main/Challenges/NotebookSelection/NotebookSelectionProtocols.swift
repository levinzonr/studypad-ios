//
//  NotebookSelectionProtocols.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol NotebookSelectionInteractorInput {
     func perform(_ request: NotebookSelection.Request.GetNotebooks)
}

// INTERACTOR -> PRESENTER (indirect)
protocol NotebookSelectionInteractorOutput: class {
    func present(_ response: [Notebook])
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol NotebookSelectionPresenterInput {
    func viewCreated()
    func handle(_ action: NotebookSelection.Action)
}

// PRESENTER -> VIEW
protocol NotebookSelectionPresenterOutput: class {
     func display(_ displayModel: [Notebook])
}

// PRESENTER -> Coordinator
protocol NotebookSelectionCoordinatorInput : class {
    func onNotebookSelected(_ notebook: Notebook)
}
