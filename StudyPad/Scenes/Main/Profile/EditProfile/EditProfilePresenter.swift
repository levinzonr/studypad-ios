//
//  EditProfilePresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import Foundation

class EditProfilePresenter {
    // MARK: - Properties
    let interactor: EditProfileInteractorInput
    weak var output: EditProfilePresenterOutput?
    
    var updateRequest: EditProfile.Request.UpdateProfile!
    let user: User
    let userManager: UserManager
    
    // Your custom coordinator
    // weak var coordinator: EditProfileCoordinatorInput?

    // MARK: - Init
    init(interactor: EditProfileInteractorInput, _ userManager: UserManager) {
        self.userManager = userManager
        self.interactor = interactor
        if let user = userManager.userInfo {
            updateRequest = EditProfile.Request.UpdateProfile(
                firstName: user.firstName ?? "",
                lastName: user.lastName ?? "")
            self.user = user
        } else {
            fatalError()
        }
    }
}

// MARK: - User Events -

extension EditProfilePresenter: EditProfilePresenterInput {
    func viewCreated() {
       output?.display(user)
        output?.displayUpdateButtonEnabled(false)
    }

    func handle(_ action: EditProfile.Action) {
        switch action {
        case .firstNameInput(let value):
            updateRequest.firstName = value
            updateButtonState()
        case .lastNameInput(let value):
            updateRequest.lastName = value
            updateButtonState()
        case .updatePressed:
            interactor.perform(updateRequest)
        }
    }
    
    private func updateButtonState() {
        let nameChange = user.firstName != updateRequest.firstName
        let lastnameChange = user.lastName != updateRequest.lastName
        print("\(nameChange) \(lastnameChange)")
        output?.displayUpdateButtonEnabled(nameChange || lastnameChange)
    }
}

// MARK: - Presentation Logic -

// INTERACTOR -> PRESENTER (indirect)
extension EditProfilePresenter: EditProfileInteractorOutput {
    func present(_ error: Error) {
        output?.displayError(error)
    }
    

    func present(_ response: User) {
        userManager.userInfo = response
    }

    
    
}
