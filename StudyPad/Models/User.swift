//
//  User.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

struct User : Codable {
    
    var displayName: String
    var firstName: String?
    var lastName: String?
    var email: String
    
    
    struct SignupRequest {
        var email: String
        var password: String
        var firstName: String = ""
        var lastName: String = ""
        
    }
    
    struct LoginRequest {
        var email: String = ""
        var password: String = ""
    }
    
    struct FacebookLoginRequest {
        var token: String
    }
    
    struct Authorization : Codable {
        var access_token: String
        var user: User
    }
    
    enum LoginResponse {
        case success ( _ data: Authorization), failure(_ error: Error)
    }
    
}
