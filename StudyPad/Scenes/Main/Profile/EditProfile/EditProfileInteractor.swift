//
//  EditProfileInteractor.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class EditProfileInteractor {
    // MARK: - Properties
    weak var output: EditProfileInteractorOutput?
    let repositroy: UserRepository
    
    // MARK: - Init
    init(_ repository: UserRepository) {
        self.repositroy = repository
        
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension EditProfileInteractor: EditProfileInteractorInput {
    
    func perform(_ request: EditProfile.Request.UpdateProfile) {
        repositroy.updateUserProfile(firstName: request.firstName, lastName: request.lastName) { result in
            switch result {
            case .success(let updated):
                self.output?.present(updated)
            case .failure(let error):
                self.output?.present(error)
            }
        }
    }
    
    
}
