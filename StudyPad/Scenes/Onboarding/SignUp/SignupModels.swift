//
//  SignupModels.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

enum Signup {
    enum Request { }
    enum Response { }
    enum DisplayData { }

    enum Action {
        case emailInput(email: String), passwordInput(password: String), passwordRepeat(password: String)
        case create
    }   

    enum Route {

    }
}

extension Signup.Request {
    struct CreateAccount {
        var email: String = ""
        var password: String = ""
    }
}

extension Signup.Response {
    struct AccountCreated {
        var token: String = ""
    }
}

extension Signup.DisplayData {
    
    struct UserInfo {
        var email: String = ""
        var password: String = ""
        var passwordRepeat: String = ""
    }
    


    
}
