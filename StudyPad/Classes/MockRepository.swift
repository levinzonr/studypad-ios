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
    
    var notebooks : Array<Notebook> = []
    var notes : Array<Note> = []
    
    let delay = RxTimeInterval(2000)

    init() {
        for index in 1...20 {
            let color = GradientColor(firstColor: "#fffff", secondColor: "#00000")
            let notebook = Notebook(id: index, name: "Notebook \(index)", notesCount: index, gradientColor: color )
            notebooks.append(notebook)
        }
        
        for index in 1...30 {
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
        let color = GradientColor(firstColor: "#fffff", secondColor: "#00000")
        let notebook = Notebook(id: 231, name: title, notesCount: 0, gradientColor: color)
        notebooks.append(notebook)
        onComplete(notebook)
    }
    
    
    func updateNotebook(id: Int, newName: String, onComplete: @escaping (Notebook) -> Void)  {
        if let index = notebooks.firstIndex(where: { $0.id == id }) {
            let notebook = self.notebooks[index]
            let updatedNotebook = Notebook(id: notebook.id, name: newName, notesCount: notebook.notesCount, gradientColor: notebook.gradientColor)
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
    
    func createNote(notebookId: Int, title: String, content: String, onComplete: @escaping (Note) -> Void) {
        let note = Note(id: 111, title: title, content: content, notebookId: notebookId)
        notes.append(note)
        onComplete(note)
    }
    
}


extension MockRepository {
    
    func login(request: User.LoginRequest, onComplete: @escaping (User.LoginResponse) -> Void) {
        onComplete(User.LoginResponse(token : "token"))
    }
    
    func createAccount(request: User.SignupRequest, onComplete: @escaping (User.LoginResponse) -> Void) {
        onComplete(User.LoginResponse(token : "token"))
    }
    
}
