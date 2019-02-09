//
//  MemoPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class MemoPresenter {
    // MARK: - Properties
    let interactor: MemoInteractorInput
    weak var output: MemoPresenterOutput?
    let notebook: Notebook
    var notes: [Note] = []
    var currentQuestionIndex = 0
    var correct: Int = 0
    // Your custom coordinator
     weak var coordinator: MemoCoordinatorInput?

    // MARK: - Init
    init(interactor: MemoInteractorInput, coordinator: MemoCoordinatorInput, notebook: Notebook) {
        self.interactor = interactor
        self.notebook = notebook
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension MemoPresenter: MemoPresenterInput {
    func viewCreated() {
        interactor.perform(Memo.Request.GetNotes(notebookId: notebook.id))
    }

    func handle(_ action: Memo.Action) {
        print("jande")
        switch action {
        case .leaveChallenge:
            coordinator?.onChallengeExit()
        
        case .answerDontKnow:
            correct = correct - 1
            output?.display(notes[currentQuestionIndex].content)
        case .answerKnow:
            correct = correct + 1
            if let next = getQuestion(at: currentQuestionIndex + 1) {
                output?.display(next)
            } else {
                coordinator?.onChallengeCompleted(result: Memo.Response.Result(total: notes.count, correct: correct))
            }
        case .completed:
           print("sa")
        }

    }
    
    private func getQuestion(at index: Int) -> Memo.DisplayData.Question? {
        print("index  \(index) > \(notes.count)")
        currentQuestionIndex = index
        if currentQuestionIndex  > notes.count - 1 {
            return nil
        } else {
            let percentage = Float(currentQuestionIndex) / Float(notes.count)
            return Memo.DisplayData.Question(content: notes[currentQuestionIndex].title, progressPercentage: percentage)
        }
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension MemoPresenter: MemoInteractorOutput {
    func present(_ response: [Note]) {
        self.notes = response
        print(notes.count)
        if (notes.count > 0) {
            output?.display(getQuestion(at: 0)!)
        } else {
            output?.display(.empty)
        }
    }
    

}
