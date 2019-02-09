//
//  SignupInteractor.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class SignupInteractor {
    // MARK: - Properties
    weak var output: SignupInteractorOutput?
    let repository: KeychainRepository
    let userManager: UserManager
    
    
    // MARK: - Init
    init(repository: KeychainRepository, _ userManager: UserManager) {
        self.repository = repository
        self.userManager = userManager
    }
}

// MARK: - Business Logic -

// PRESENTER -> INTERACTOR
extension SignupInteractor: SignupInteractorInput {
    
    func perform(_ request: Signup.Request.CreateAccount) {
        let crequest = User.SignupRequest(email: request.email, password: request.password, firstName: "", lastName: "")
        repository.createAccount(request: crequest) { result in
            switch result {
            case .success(let auth):
                self.userManager.token = auth.access_token
                self.userManager.userInfo = auth.user
                self.output?.present(.accountCreated)
            case .failure(let error):
                self.output?.present(.accountCreatedError(error))
            }
        }
    }
}
