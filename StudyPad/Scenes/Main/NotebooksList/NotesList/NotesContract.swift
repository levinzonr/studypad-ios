//
//  NotesListContract.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

protocol NotesView : BaseView {
    func showNotes(_ notes: [Note])
}

protocol NotesPresenter: BasePresenter {
    func loadNotesFromNotebook(notebook: Notebook)
    func refresh()

}

protocol NotesCoordinator {
    
}
