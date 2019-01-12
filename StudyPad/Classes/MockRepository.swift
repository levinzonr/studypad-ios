//
//  MockRepository.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

final class MockNotebookRepo: NotebookRepository {
    var items : Array<Notebook> = []
    
    init() {
        for index in 1...20 {
            let color = GradientColor(firstColor: "#fffff", secondColor: "#00000")
            let notebook = Notebook(id: index, name: "Notebook \(index)", notesCount: index, gradientColor: color )
            items.append(notebook)
        }
        
    }
    
    func getNotebooks(onComplete: @escaping ([Notebook]) -> Void) {
        onComplete(items)
    }
    
    func deleteNotebook(id: Int, onComplete: @escaping () -> Void) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items.remove(at: index)
        }
        onComplete()
    }
    
    func createNotebook(title: String, onComplete: @escaping (Notebook) -> Void) {
        let color = GradientColor(firstColor: "#fffff", secondColor: "#00000")
        let notebook = Notebook(id: 231, name: title, notesCount: 0, gradientColor: color)
        items.append(notebook)
        onComplete(notebook)
    }
}

final class MockNotesRepository: NotesRepository {
    var items : Array<Note> = []

    init() {
        for index in 1...30 {
            let note = Note(id: index, title: "Title of \(index) note", content: "Content of \(index)th note", notebookId: 1)
            items.append(note)
        }
        
    }
    
    func getNotesFromNotebook(notebookId: Int, onComplete: @escaping ([Note]) -> Void) {
        onComplete(items)
    }
    
    func deleteNote(noteId: Int, onComplete: @escaping () -> Void) {
        if let index = items.firstIndex(where:  { $0.id == noteId}) {
            items.remove(at: index)
        }
        onComplete()
    }

    func createNote(notebookId: Int, title: String, content: String, onComplete: @escaping (Note) -> Void) {
        let note = Note(id: 111, title: title, content: content, notebookId: notebookId)
        items.append(note)
        onComplete(note)
    }
    
}
