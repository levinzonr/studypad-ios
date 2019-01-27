//
//  SignupViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 24/01/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var emailInputField: UITextField!

    @IBOutlet weak var passwordInputField: UITextField!
    
    @IBOutlet weak var repeatPasswordInputField: UITextField!
    
    @IBOutlet weak var createAccountBtn: UIButton!
    
    // MARK: - Properties
    private var presenter: SignupPresenterInput!

    // MARK: - Init
    class func instantiate(with presenter: SignupPresenterInput) -> SignupViewController {
        let name = "\(SignupViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! SignupViewController
        vc.presenter = presenter
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
    }

    // MARK: - Callbacks -
    
    @IBAction func onPasswordValueChanged(_ sender: Any) {
        presenter.handle(Signup.Action.passwordInput(password:  passwordInputField.text ?? ""))
    }
    
    @IBAction func onEmailValueChanged(_ sender: Any) {
        presenter.handle(Signup.Action.emailInput(email: emailInputField.text ?? ""))
    }
    
    @IBAction func onRepeatPasswordValueChanged(_ sender: Any) {
        presenter.handle(Signup.Action.passwordRepeat(password: repeatPasswordInputField.text ?? "" ))
    }
    @IBAction func onCreateButtonPressed(_ sender: Any) {
        presenter.handle(Signup.Action.create)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension SignupViewController: SignupPresenterOutput {
    func showCreateButtonEnabled(enabled: Bool) {
        print("enabled: \(enabled)")
        createAccountBtn.isEnabled = enabled
    }
    
    
}
