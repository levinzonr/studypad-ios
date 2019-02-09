//
//  NoteEditPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class NoteEditPresenter: BasePresenter {
    var view: NoteEditView?
    typealias View = NoteEditView
    
    var note: Note?
    
    var newTitle: String {
        didSet { checkIfCanBeSaved() }
    }
    var newContent: String {
        didSet { checkIfCanBeSaved() }
    }
    
    let repository: NotesRepository
    let notebookId: Int?
    
    init(note: Note? = nil, _ notebookId: Int?, _ repository: NotesRepository) {
        self.note = note
        self.notebookId = notebookId
        self.newTitle = note?.title ?? ""
        self.newContent = note?.content ?? ""
        self.repository = repository
    }
    
    func attachView(view: NoteEditView) {
        self.view = view
        view.showSaveButtonEnabled(false)
        if let note = self.note {
            view.showEditMode(note)
        }
    }
    
    private func createNote(_ notebookId: Int) {
        let request = Note.CreateRequest(notebookId: notebookId, title: newTitle, content: newContent)
        repository.createNote(request: request) { result in
            self.runAction({ (view : NoteEditView) in
            
                switch result {
                case .success(let created):
                    self.note = created
                    view.showNoteCreated()
                    view.showEditMode(created)
                    view.showSaveButtonEnabled(false)
                    
                    
                case .failure(let error):
                    self.runAction{ view in
                        view.showError(error)
                    }
                }
            })
        }
    }
    
    private func updateNote(_ note: Note) {
        let request = Note.UpdateRequest(id: note.id, title: newTitle, content: newContent)
        repository.updateNote(request: request) { result in
            switch result {
            case .success:
                self.runAction({ (view: NoteEditView) in
                    view.showNoteUpdated()
                    view.showSaveButtonEnabled(false)
                })
                
            case .failure(let error):
                self.runAction{ view in
                    view.showError(error)
                }
            }
        }
            
    }
    
    func saveNote() {
        if let note = self.note {
            updateNote(note)
        } else  if let notebookId = self.notebookId {
           createNote(notebookId)
        } else {
            fatalError("Nor id or note passed")
        }
    }
    
    func dettachView() {
        self.view = nil
    }

        
    
    private func checkIfCanBeSaved() {
        let isNotEmpty = !newContent.isEmpty || !newTitle.isEmpty
        var changed = true
        if let note = self.note {
            changed = note.content != newContent || note.title != newTitle
        }
        self.runAction { (view: NoteEditView) in
            view.showSaveButtonEnabled(isNotEmpty && changed)
        }
    }

    
}
