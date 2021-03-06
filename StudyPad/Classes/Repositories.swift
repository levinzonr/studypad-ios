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
    
    func getNotebooks(onComplete: @escaping (AppResult<[Notebook]>) -> Void)
    func createNotebook(title: String, onComplete: @escaping (AppResult<Notebook>) -> Void)
    func deleteNotebook(id: Int, onComplete: @escaping (AppResult<Bool>) -> Void)
    func updateNotebook(id: Int, newName: String, onComplete: @escaping (AppResult<Notebook>) -> Void)
}


protocol NotesRepository {
    func getNotesFromNotebook(notebookId: Int, onComplete: @escaping (AppResult<[Note]>) -> Void)
    func createNote(request: Note.CreateRequest, onComplete: @escaping (AppResult<Note>) -> Void)
    func updateNote(request: Note.UpdateRequest, onComplete: @escaping (AppResult<Note>) -> Void)
    func deleteNote(noteId: Int, onComplete: @escaping (AppResult<Bool>) -> Void)
}

protocol KeychainRepository {
    
    func login(request: User.LoginRequest, onComplete: @escaping (AppResult<User.Authorization>) -> Void)
    func createAccount(request: User.SignupRequest, onComplete: @escaping (AppResult<User.Authorization>) -> Void)
    func loginViaFacebook(token: String, onComplete: @escaping (AppResult<User.Authorization>) -> Void)
    
}

protocol UserRepository {
    func updateUserProfile(firstName: String, lastName: String, onComplete: @escaping (AppResult<User>) -> Void)
    
}
