//
//  NotesPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class NotesPresenterImpl: NotesPresenter {

    typealias View = NotesView
    var view: NotesView?
    
    let repo: NotesRepository
    let notebook: Notebook
    let coordinator: NotesCoordinatorDelegate
    
    init(repo: NotesRepository, notebook: Notebook, _ delegate: NotesCoordinatorDelegate) {
        self.repo = repo
        self.notebook = notebook
        self.coordinator = delegate
    }
    
    func attachView(view: NotesView) {
        self.view = view
        loadNotesFromNotebook(notebook: notebook)
    }
    
    func loadNotesFromNotebook(notebook: Notebook) {
        print("load")
        repo.getNotesFromNotebook(notebookId: notebook.id) { result in
            switch result {
            case .success(let items):
                self.runAction { view in
                    if items.count > 0 {
                        view.showNotes(items)
                    } else {
                        view.showEmptyView()
                    }
                }
            case .failure(let error):
                self.runAction{  view in
                    view.showError(error: error)
                }
            }
        }
    }
    
    func refresh() {
        loadNotesFromNotebook(notebook: notebook)
    }
    
    func handleNoteClick(note: Note) {
        coordinator.showNotesDetail(note: note)
    }

    func handleNoteCreateion() {
        coordinator.showNoteCreation()
    }
    
    func dettachView() {
        self.view = nil
    }
    
}
