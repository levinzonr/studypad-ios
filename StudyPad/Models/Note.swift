//
//  Note.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation

struct Note : Codable {
    var id: Int
    var title: String
    var content: String
    var notebookId: Int
    
    
    struct UpdateRequest {
        var id: Int
        var title: String
        var content: String
    }
    
    struct CreateRequest {
        var notebookId: Int
        var title: String
        var content: String
    }
    
}
