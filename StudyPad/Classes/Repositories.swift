//
//  Repositories.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import RxSwift

typealias Repository = NotebookRepository & NotesRepository

protocol NotebookRepository{
    
    func getNotebooks(onComplete: @escaping ([Notebook]) -> Void)
    func createNotebook(title: String, onComplete: @escaping (Notebook) -> Void)
    func deleteNotebook(id: Int, onComplete: @escaping () -> Void)
    func updateNotebook(id: Int, newName: String, onComplete: @escaping (Notebook) -> Void)
}


protocol NotesRepository {
    func getNotesFromNotebook(notebookId: Int, onComplete: @escaping ([Note]) -> Void)
    func createNote(notebookId: Int, title: String, content: String, onComplete: @escaping (Note) -> Void)
    func deleteNote(noteId: Int, onComplete: @escaping () -> Void)
}

protocol UserRepository {
    
    func login(email : String, password: String) 
    
}
