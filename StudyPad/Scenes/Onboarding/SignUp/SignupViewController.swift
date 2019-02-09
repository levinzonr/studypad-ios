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
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
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
        emailInputField.delegate = self
        passwordInputField.delegate = self
        repeatPasswordInputField.delegate = self
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
    func showError(_ error: Error) {
        showErrorAlert(of: error)
    }
    
    func showCreateButtonEnabled(_ enabled: Bool) {
        print("enabled: \(enabled)")
        createAccountBtn.isEnabled = enabled
    }
    
    func showLoading(_ show: Bool) {
        progressIndicator.visible = show
    }
    
}

extension SignupViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nextField: UITextField? = nil
        if (emailInputField == textField) {
            nextField = passwordInputField
        } else if (textField == passwordInputField) {
            nextField = repeatPasswordInputField
        } else {
            nextField = nil
        }
        
        if let nextInput = nextField {
            return nextInput.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }

    }
}
