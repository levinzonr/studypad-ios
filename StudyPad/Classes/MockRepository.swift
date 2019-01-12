//
//  MockRepository.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

final class MockNotebookRepo: NotebookRepository {
    
    func getNotebooks(onComplete: @escaping ([Notebook]) -> Void) {
        var items : Array<Notebook> = []
        for index in 1...20 {
            let color = GradientColor(firstColor: "#fffff", secondColor: "#00000")
            let notebook = Notebook(id: index, name: "Notebook \(index)", notesCount: index, gradientColor: color )
            items.append(notebook)
        }
        onComplete(items)
    }
    
    func deleteNotebook(id: Int, onComplete: @escaping () -> Void) {
        onComplete()
    }
    
    func createNotebook(title: String, onComplete: @escaping (Notebook) -> Void) {
        let color = GradientColor(firstColor: "#fffff", secondColor: "#00000")
        onComplete(Notebook(id: 231, name: title, notesCount: 0, gradientColor: color))
    }
}

final class MockNotesRepository: NotesRepository {
    
    func getNotesFromNotebook(notebookId: Int, onComplete: @escaping ([Note]) -> Void) {
        var items : Array<Note> = []
        for index in 1...30 {
            let note = Note(id: index, title: "Title of \(index) note", content: "Content of \(index)th note", notebookId: notebookId)
            items.append(note)
        }
        onComplete(items)
    }
    
    func deleteNote(noteId: Int, onComplete: @escaping () -> Void) {
        onComplete()
    }

    func createNote(notebookId: Int, title: String, content: String, onComplete: @escaping (Note) -> Void) {
        let note = Note(id: 111, title: title, content: content, notebookId: notebookId)
        onComplete(note)
    }
    
}
