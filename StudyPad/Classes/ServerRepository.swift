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
    func login(request: User.LoginRequest, onComplete: @escaping (User.LoginResponse) -> Void) {
        let payload: [String: Any] = [
            "email": request.email,
            "password": request.password
        ]
        print("start")
        sessionManager
            .request(AUTH + "email", method: .post, parameters: payload, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let data = response.data {
                    print("respomse \(response)")
                    do {
                        let jsonDecoder = JSONDecoder()
                        let recipes = try jsonDecoder.decode(User.LoginResponse.self, from: data)
                        print(recipes)
                        onComplete(recipes)
        
                    } catch {
                        print("catch")
                    }
                }
            
        }
        
    }
    
    func createAccount(request: User.SignupRequest, onComplete: @escaping (User.LoginResponse) -> Void) {
        let payload: [String: Any] = [
            "email": request.email,
            "password": request.password,
            "firstName": request.firstName,
            "lastName": request.lastName
        ]
        sessionManager
            .request(API + "users", method: .post, parameters: payload, encoding: JSONEncoding.default)
            .responseJSON { respnse in
                print("respomse \(respnse)")
                if let data = respnse.data {
                    do {
                        let encoder = JSONDecoder()
                        let result = try encoder.decode(User.LoginResponse.self, from: data)
                        onComplete(result)
                    }  catch {}
                }
        }
    }
    
    func loginViaFacebook(token: String, onComplete: @escaping (User.LoginResponse) -> Void) {
        
        let payload: [String: Any] = [
            "token": token
        ]
        sessionManager
            .request(AUTH + "facebook", method: .post, parameters: payload, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let data = response.data {
                    print("respomse \(response)")
                    do {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(User.LoginResponse.self, from: data)
                        print(result)
                        onComplete(result)
                        
                    } catch {
                        print("catch facebook")
                    }
                }
    }


    
}
    
}

// Notebooks
extension ServerRepository  {
    func getNotebooks(onComplete: @escaping ([Notebook]) -> Void) {
        sessionManager
            .request(API + "notebooks" , method: .get, parameters: nil, encoding: JSONEncoding.default, headers: authHeaders)
            .debugLog()
            .responseJSON { response in
                print("respomse \(response)")
                if let data = response.data {
                    do {
                        let encoder = JSONDecoder()
                        let result = try encoder.decode([Notebook].self, from: data)
                        onComplete(result)
                    } catch {}
                }
        }
    }
    
    func createNotebook(title: String, onComplete: @escaping (Notebook) -> Void) {
        let payload : [String: Any] = [
            "name": title
        ]
        sessionManager
            .request(API + "notebooks", method: .post, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .debugLog()
            .responseJSON { response in
                print("respomse \(response)")
                if let data = response.data {
                    do {
                        let encoder = JSONDecoder()
                        let result = try encoder.decode(Notebook.self, from: data)
                        onComplete(result)
                    } catch {}
                }
        }
    }
    
    func deleteNotebook(id: Int, onComplete: @escaping () -> Void) {
        sessionManager
            .request(API + "notebooks/\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: authHeaders)
            .response { r in
                onComplete()
        }
    }
    
    func updateNotebook(id: Int, newName: String, onComplete: @escaping (Notebook) -> Void) {
        let payload : [String: Any] = [
            "name": newName
        ]
        sessionManager
            .request(API + "notebooks/\(id)", method: .patch, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .debugLog()
            .responseJSON { response in
                if let data = response.data {
                    do {
                        let econoder = JSONDecoder()
                        let result =  try econoder.decode(Notebook.self, from: data)
                        onComplete(result)
                    } catch {
                            
                    }
                }
            }
        }
}

// Notes
extension ServerRepository  {
    func getNotesFromNotebook(notebookId: Int, onComplete: @escaping ([Note]) -> Void) {
        sessionManager
            .request(API + "notebooks/\(notebookId)/notes", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: authHeaders)
            .responseJSON { response in
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([Note].self, from: data)
                        onComplete(result)
                    } catch {
                        print("catch notes")
                    }
                }
            }
    }
    
    func createNote(request: Note.CreateRequest, onComplete: @escaping (Note) -> Void) {
        let payload : [String: Any] = [
            "title": request.title,
            "content": request.content,
            "notebookId": request.notebookId
        ]
        sessionManager
            .request(API + "notes", method: .post, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .responseJSON { response in
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Note.self, from: data)
                        onComplete(result)
                    } catch {
                        print("Catch create note")
                    }
                }
        }
    }
    
    func updateNote(request: Note.UpdateRequest, onComplete: @escaping () -> Void) {
        let payload : [String: Any] = [
            "title": request.title,
            "content": request.content,
        ]
        sessionManager
            .request(API + "notes/\(request.id)", method: .patch, parameters: payload, encoding: JSONEncoding.default, headers: authHeaders)
            .responseJSON { response in
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Note.self, from: data)
                        onComplete()
                    } catch {
                        print("Catch update note")
                    }
                }
        }
    }
    
    func deleteNote(noteId: Int, onComplete: @escaping () -> Void) {
        sessionManager
            .request(API + "notes/\(noteId)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: authHeaders)
            .response { response in
                onComplete()
        }
    }
    
    
}


