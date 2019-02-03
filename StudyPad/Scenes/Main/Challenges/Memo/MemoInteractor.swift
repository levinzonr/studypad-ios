//
//  MemoInteractor.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class MemoInteractor {
    // MARK: - Properties
    weak var output: MemoInteractorOutput?
    
    let repository: NotesRepository

    // MARK: - Init
    init(repository: NotesRepository) {
        self.repository = repository
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension MemoInteractor: MemoInteractorInput {
    func perform(_ request: Memo.Request.GetNotes) {
        repository.getNotesFromNotebook(notebookId: request.notebookId) { response in
            self.output?.present(response)
        }
    }
    
}
