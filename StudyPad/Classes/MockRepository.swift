//
//  MockRepository.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import RxSwift

final class MockRepository: Repository {
    func updateUserProfile(firstName: String, lastName: String, onComplete: @escaping (User) -> Void) {

    }
    
    
    var notebooks : Array<Notebook> = []
    var notes : Array<Note> = []
    
    let delay = RxTimeInterval(2000)

    init() {
        for index in 1...2 {
            let color = GradientColor(startColor: "#fffff", endColor: "#00000")
            let notebook = Notebook(id: index, name: "Notebook \(index)", notesCount: index, color: color )
            notebooks.append(notebook)
        }
        
        for index in 1...5 {
            let note = Note(id: index, title: "Title of \(index) note", content: "Content of \(index)th note", notebookId: 1)
            notes.append(note)
        }
        
    }
    
}
    
extension MockRepository {
    
    func getNotebooks(onComplete: @escaping ([Notebook]) -> Void) {
        onComplete(notebooks)
    }
    
    func deleteNotebook(id: Int, onComplete: @escaping () -> Void) {
        if let index = notebooks.firstIndex(where: { $0.id == id }) {
            notebooks.remove(at: index)
            print("removed: \(notebooks.count)")
        }
        onComplete()
    }
    
    func createNotebook(title: String, onComplete: @escaping (Notebook) -> Void) {
        let color = GradientColor(startColor: "#fffff", endColor: "#00000")
        let notebook = Notebook(id: 231, name: title, notesCount: 0, color: color)
        notebooks.append(notebook)
        onComplete(notebook)
    }
    
    
    func updateNotebook(id: Int, newName: String, onComplete: @escaping (Notebook) -> Void)  {
        if let index = notebooks.firstIndex(where: { $0.id == id }) {
            let notebook = self.notebooks[index]
            let updatedNotebook = Notebook(id: notebook.id, name: newName, notesCount: notebook.notesCount, color: notebook.color)
            self.notebooks[index] = updatedNotebook
            onComplete(updatedNotebook)
        }
    }
    
    

}


extension MockRepository {
    
    
    
    func getNotesFromNotebook(notebookId: Int, onComplete: @escaping ([Note]) -> Void) {
        onComplete(notes)
    }
    
    func deleteNote(noteId: Int, onComplete: @escaping () -> Void) {
        if let index = notes.firstIndex(where:  { $0.id == noteId}) {
            notes.remove(at: index)
        }
        onComplete()
    }
    
    func createNote(request: Note.CreateRequest, onComplete: @escaping (Note) -> Void) {
        let note = Note(id: notes.count + 12, title: request.title, content: request.content, notebookId: request.notebookId)
        notes.append(note)
        onComplete(note)
    }
    
    func updateNote(request: Note.UpdateRequest, onComplete: @escaping () -> Void) {
        if let index = notes.firstIndex(where: {$0.id == request.id }) {
            let note = notes[index]
            let newNote = Note(id: note.id, title: request.title, content: request.content, notebookId: note.notebookId)
            notes[index] = newNote
            onComplete()
        }
    }
    
}


extension MockRepository {
    
    func login(request: User.LoginRequest, onComplete: @escaping (User.LoginResponse) -> Void) {
       
    }
    
    func createAccount(request: User.SignupRequest, onComplete: @escaping (User.LoginResponse) -> Void) {
    }
    
    func loginViaFacebook(token: String, onComplete: @escaping (User.LoginResponse) -> Void) {
        
    }

    
}
