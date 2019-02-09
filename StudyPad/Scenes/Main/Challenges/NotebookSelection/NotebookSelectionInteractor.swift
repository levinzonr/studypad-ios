//
//  NotebookSelectionInteractor.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class NotebookSelectionInteractor {
    // MARK: - Properties
    weak var output: NotebookSelectionInteractorOutput?

    let repository: NotebookRepository
    
    // MARK: - Init
    init(repository: NotebookRepository) {
        self.repository = repository
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension NotebookSelectionInteractor: NotebookSelectionInteractorInput {
    
    func perform(_ request: NotebookSelection.Request.GetNotebooks) {
        repository.getNotebooks { response in
            switch response {
            case .success(let data):
             self.output?.present(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
