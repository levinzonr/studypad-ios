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
    
    func getNotebooks() -> Single<[Notebook]> {
        return Single.just(self.notebooks)
    }
    
    func deleteNotebook(id: Int, onComplete: @escaping () -> Void) {
        if let index = notebooks.firstIndex(where: { $0.id == id }) {
            notebooks.remove(at: index)
        }
        onComplete()
    }
    
    func createNotebook(title: String, onComplete: @escaping (Notebook) -> Void) {
        let color = GradientColor(firstColor: "#fffff", secondColor: "#00000")
        let notebook = Notebook(id: 231, name: title, notesCount: 0, gradientColor: color)
        notebooks.append(notebook)
        onComplete(notebook)
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
