//
//  MemoModels.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

enum Memo {
    enum Request {
        struct GetNotes {
            var notebookId: Int
        }
    }
    enum Response {
        struct Result {
            var total: Int
            var correct: Int
        }
    }
    enum DisplayData {
        case complete, empty

    }

    enum Action {
        case leaveChallenge
        case answerKnow, answerDontKnow
        case completed
    }

    enum Route {

    }
}

extension Memo.Request {

}

extension Memo.Response {

}

extension Memo.DisplayData {
    
    struct Question {
        var content: String
        var progressPercentage: Float
    }
    
}
