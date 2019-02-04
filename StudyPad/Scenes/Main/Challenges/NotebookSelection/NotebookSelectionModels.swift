//
//  NotebookSelectionModels.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

enum NotebookSelection {
    enum Request {
       
        struct GetNotebooks {}
    
    }
    enum Response {
       
        struct GetNotebooks {
            let items: [Notebook]
        }
        
    }
    enum DisplayData {
        case empty, error, loading
    }

    enum Action {
        case notebookSelected(notebook: Notebook)
    }

    enum Route {

    }
}

extension NotebookSelection.Request {

}

extension NotebookSelection.Response {

}

extension NotebookSelection.DisplayData {
    
}
