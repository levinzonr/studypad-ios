//
//  MemoProtocols.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

// ======== Interactor ======== //

// PRESENTER -> INTERACTOR
protocol MemoInteractorInput {
     func perform(_ request: Memo.Request.GetNotes)
}

// INTERACTOR -> PRESENTER (indirect)
protocol MemoInteractorOutput: class {
     func present(_ response: [Note])
}

// ======== Presenter ======== //

// VIEW -> PRESENTER
protocol MemoPresenterInput {
    func viewCreated()
    func handle(_ action: Memo.Action)
}

// PRESENTER -> VIEW
protocol MemoPresenterOutput: class {
    func display(_ data: Memo.DisplayData.Question)
    func display(_ state: Memo.DisplayData)
    func display(_ answer: String)

}

protocol MemoCoordinatorInput: class {
    func onChallengeCompleted(result: Memo.Response.Result)
    func onChallengeExit()
}
