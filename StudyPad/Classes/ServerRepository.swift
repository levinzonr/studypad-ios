//
//  ServerRepository.swift
//  StudyPad
//
//  Created by Roman Levinzon on 27/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import Alamofire

final class ServerRepository : Repository {
    
    private let userManager: UserManager
    private let sessionManager: SessionManager
    
    private let API = Constants.API.baseApi
    private let AUTH = Constants.API.baseAuth
    
    private let staticHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    private var authHeaders: [String: String]? {
        var headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        if let token = userManager.token {
            headers["Authorization"] = "Bearer " + token
        }
        return headers
    }
    
    init(userManager: UserManager) {
        self.userManager = userManager
        let configuarion = SessionManager.default.session.configuration
        configuarion.httpAdditionalHeaders = staticHeaders
        self.sessionManager = SessionManager(configuration: configuarion)
    }
}


// KeyChain
extension ServerRepository {
    func login(request: User.LoginRequest, onComplete: @escaping (AppResult<User.Authorization>) -> Void) {
        let payload: [String: Any] = [
            "email": request.email,
            "password": request.password
        ]
        print("start")
        sessionManager
            .request(AUTH + "email", method: .post, parameters: payload, encoding: JSONEncoding.default)
            .resutltResponse(result: onComplete)
            
        }
    
    
    func createAccount(request: User.SignupRequest, onComplete: @escaping (AppResult<User.Authorization>) -> Void) {
        let payload: [String: Any] = [
            "email": request.email,
            "password": request.password,
            "firstName": request.firstName,
            "lastName": request.lastName
        ]
        sessionManager
            .request(API + "users", method: .post, parameters: payload, encoding: JSONEncoding.default)
            .resutltResponse(result: onComplete)
    }

    
    func loginViaFacebook(token: String, onComplete: @escaping (AppResult<User.Authorization>) -> Void) {
        
        let payload: [String: Any] = [
            "token": token
        ]
        sessionManager
            .request(AUTH + "facebook", method: .post, parameters: payload, encoding: JSONEncoding.default)
            .resutltResponse(result: onComplete)
    }
}

// Notebooks
extension ServerRepository  {
    func getNotebooks(onComplete: @escaping (AppResult<[Notebook]>) -> Void) {
        sessionManager
            .request(API + "notebooks" , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)
    }
    
    func createNotebook(title: String, onComplete: @escaping (AppResult<Notebook>) -> Void) {
        let payload : [String: Any] = [
            "name": title
        ]
        sessionManager
            .request(API + "notebooks", method: .post, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)
    }

    
    func deleteNotebook(id: Int, onComplete: @escaping (AppResult<Bool>) -> Void) {
        sessionManager
            .request(API + "notebooks/\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)
    }

    
    func updateNotebook(id: Int, newName: String, onComplete: @escaping (AppResult<Notebook>) -> Void) {
        let payload : [String: Any] = [
            "name": newName
        ]
        sessionManager
            .request(API + "notebooks/\(id)", method: .patch, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)
    }
}

// Notes
extension ServerRepository  {
    func getNotesFromNotebook(notebookId: Int, onComplete: @escaping (AppResult<[Note]>) -> Void) {
        sessionManager
            .request(API + "notebooks/\(notebookId)/notes", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)
    }
    
    func createNote(request: Note.CreateRequest, onComplete: @escaping (AppResult<Note>) -> Void) {
        let payload : [String: Any] = [
            "title": request.title,
            "content": request.content,
            "notebookId": request.notebookId
        ]
        sessionManager
            .request(API + "notes", method: .post, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)
    }
    
    func updateNote(request: Note.UpdateRequest, onComplete: @escaping (AppResult<Note>) -> Void) {
        let payload : [String: Any] = [
            "title": request.title,
            "content": request.content,
        ]
        sessionManager
            .request(API + "notes/\(request.id)", method: .patch, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)
    }
    
    func deleteNote(noteId: Int, onComplete: @escaping (AppResult<Bool>) -> Void) {
        sessionManager
            .request(API + "notes/\(noteId)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)
        
    }
    
    
}

extension ServerRepository {
    
    func updateUserProfile(firstName: String, lastName: String, onComplete: @escaping (AppResult<User>) -> Void) {
        let payload : [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
        ]
        sessionManager
            .request(API + "users/me", method: .post, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .resutltResponse(result: onComplete)

    }
}


