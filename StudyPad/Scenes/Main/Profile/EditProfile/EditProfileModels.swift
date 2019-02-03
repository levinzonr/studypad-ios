//
//  EditProfileModels.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

enum EditProfile {
    enum Request { }
    enum Response { }
    enum DisplayData { }

    enum Action {
        case firstNameInput(value: String)
        case lastNameInput(value: String)
        case updatePressed
        
    }

    enum Route {

    }
}

extension EditProfile.Request {
    struct UpdateProfile {
        var firstName: String
        var lastName: String
    }
}

extension EditProfile.Response {

}

extension EditProfile.DisplayData {
    
}
