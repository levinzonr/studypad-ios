//
//  SignupPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class SignupPresenter {
    // MARK: - Properties
    let interactor: SignupInteractorInput
    weak var output: SignupPresenterOutput?
    
    var userInfo = Signup.DisplayData.UserInfo()
    weak var coordinator: SignupCoordinatorInput?
    
    // MARK: - Init
    init(interactor: SignupInteractorInput, coordinator: SignupCoordinatorInput) {
        self.interactor = interactor
        self.coordinator = coordinator
    }
}

// MARK: - User Events -

extension SignupPresenter: SignupPresenterInput {
    func viewCreated() {
        output?.showCreateButtonEnabled(false)
        output?.showLoading(false)
    }

    func handle(_ action: Signup.Action) {
        switch action {
        case .emailInput(let email):
            userInfo.email = email
            updateButtonsState()
            
        case .passwordInput(let password):
            userInfo.password = password
            updateButtonsState()
            
        case .passwordRepeat(let repassword):
            userInfo.passwordRepeat = repassword
            updateButtonsState()

        case .create:
            output?.showLoading(true)
            interactor.perform(Signup.Request.CreateAccount(email: userInfo.email, password: userInfo.password))
        }
       
    }
    
    private func updateButtonsState() {
        let validEmail = !userInfo.email.isEmpty
        let validPassword = !userInfo.password.isEmpty && (userInfo.password == userInfo.passwordRepeat)
        print("Valid: \(validEmail) \(validPassword)")
        output?.showCreateButtonEnabled(validEmail && validPassword)
        
    }
    
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension SignupPresenter: SignupInteractorOutput {
    func present(_ response: Signup.Response) {
        switch response {
        case .accountCreated:
            coordinator?.showMain()
        case .accountCreatedError(let error):
            output?.showError(error)
            output?.showLoading(false)
        }
    }
    

    
}
