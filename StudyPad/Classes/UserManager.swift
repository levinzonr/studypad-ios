//
//  UserManager.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation


final class UserManager {
    
    var email: String = ""
    
    func isLoggedIn() -> Bool {
        return !email.isEmpty
    }
    
    func loginViaEmail(email: String, password: String,  onComplete: @escaping (Bool) -> Void) {
        self.email = email
        onComplete(true)
    }
    
}
