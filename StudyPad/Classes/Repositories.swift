//
//  Repositories.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import RxSwift

typealias Repository = NotebookRepository & NotesRepository & KeychainRepository & UserRepository

protocol NotebookRepository{
    
    func getNotebooks(onComplete: @escaping ([Notebook]) -> Void)
    func createNotebook(title: String, onComplete: @escaping (Notebook) -> Void)
    func deleteNotebook(id: Int, onComplete: @escaping () -> Void)
    func updateNotebook(id: Int, newName: String, onComplete: @escaping (Notebook) -> Void)
}


protocol NotesRepository {
    func getNotesFromNotebook(notebookId: Int, onComplete: @escaping ([Note]) -> Void)
    func createNote(request: Note.CreateRequest, onComplete: @escaping (Note) -> Void)
    func updateNote(request: Note.UpdateRequest, onComplete: @escaping () -> Void)
    func deleteNote(noteId: Int, onComplete: @escaping () -> Void)
}

protocol KeychainRepository {
    
    func login(request: User.LoginRequest, onComplete: @escaping (AppResult<User.Authorization>) -> Void)
    func createAccount(request: User.SignupRequest, onComplete: @escaping (AppResult<User.Authorization>) -> Void)
    func loginViaFacebook(token: String, onComplete: @escaping (AppResult<User.Authorization>) -> Void)
    
}

protocol UserRepository {
    func updateUserProfile(firstName: String, lastName: String, onComplete: @escaping (User) -> Void)
    
}
