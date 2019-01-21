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
    
    
    init(repo: NotesRepository, notebook: Notebook) {
        self.repo = repo
        self.notebook = notebook
    }
    
    func attachView(view: NotesView) {
        self.view = view
        loadNotesFromNotebook(notebook: notebook)
    }
    
    func loadNotesFromNotebook(notebook: Notebook) {
        repo.getNotesFromNotebook(notebookId: notebook.id) { ( items: [Note]) in
            self.runAction({ (view: NotesPresenterImpl.View) in
                view.showNotes(items)
            })
        }
    }

    
    func dettachView() {
        self.view = nil
    }
    
}
