//
//  EditProfileViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var lastNameInputField: UITextField!
    @IBOutlet weak var firstNameInputField: UITextField!
    // MARK: - Properties
    private var presenter: EditProfilePresenterInput!

    // MARK: - Init
    class func instantiate(with presenter: EditProfilePresenterInput) -> EditProfileViewController {
        let name = "\(EditProfileViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! EditProfileViewController
        vc.presenter = presenter
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
    }
    // MARK: - Callbacks -

    @IBAction func onLastNameChanged(_ sender: Any) {
        presenter.handle(.lastNameInput(value: lastNameInputField.text ?? ""))

    }
    
    @IBAction func onFirstNameChanged(_ sender: Any) {
        presenter.handle(.firstNameInput(value: firstNameInputField.text ?? ""))
    }

    @IBAction func onUpdateButtonPressed(_ sender: Any) {
        presenter.handle(.updatePressed)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension EditProfileViewController: EditProfilePresenterOutput {
    func displayUpdateButtonEnabled(_ enabled: Bool) {
        updateButton.isEnabled = enabled
        print("enabled \(enabled)")
    }
    
    func display(_ displayModel: User) {
        firstNameInputField.text = displayModel.firstName
        lastNameInputField.text = displayModel.lastName
    }
    
    func displayError(_ error: Error) {
        showErrorAlert(of: error)
    }
    
}
