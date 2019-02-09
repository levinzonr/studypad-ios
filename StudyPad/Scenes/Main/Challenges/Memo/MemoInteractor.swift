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
        repository.getNotesFromNotebook(notebookId: request.notebookId) { result in
            switch result {
            case .success(let items):
                self.output?.present(items)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
