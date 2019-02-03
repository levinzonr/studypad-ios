//
//  LoginViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController : UIViewController {
    
    var presenter: LoginPresenter!
    
    @IBOutlet weak var facebooLoginButton: UIButton! {
        didSet {
            facebooLoginButton.tintColor = .white
            facebooLoginButton.titleEdgeInsets.left = 24
            facebooLoginButton.imageEdgeInsets.top = 8
            facebooLoginButton.imageEdgeInsets.bottom = 8
            let origImage = UIImage(named: "facebook");
            let tintedImage = origImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            facebooLoginButton.setImage(tintedImage, for: .normal)
            facebooLoginButton.tintColor = .white
            
        }
    }
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordInputField: UITextField! {
        didSet {
            passwordInputField.backgroundColor = .white
            passwordInputField.snp.makeConstraints { make in
                make.height.equalTo(55)
            }
        }
    }
    @IBOutlet weak var emailInputField: UITextField! {
        didSet {
            emailInputField.snp.makeConstraints { make in
                make.height.equalTo(55)
            }
        }
    }
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        
        emailInputField.delegate = self
        passwordInputField.delegate = self
    }
    
    @IBAction func onLoginButtonClicked(_ sender: Any) {
        presenter.login()
    }
   
    @IBAction func onCreateAccountPressed(_ sender: Any) {
        presenter.showCreateAccount()
    }
    @IBAction func onEmailInputPassword(_ sender: Any) {
        presenter.email = emailInputField.text ?? ""
    }
    @IBAction func onFacebookButtonPressed(_ sender: Any) {
        print("Facebook")
        presenter.loginViaFacebook()
    }
    @IBAction func onPasswordInputChanged(_ sender: Any) {
        presenter.password = passwordInputField.text ?? ""
    }
    static func newInstance(with presenter: LoginPresenter) -> LoginViewController {
        let name = "\(LoginViewController.self)"
        let sb = UIStoryboard.init(name: name, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: name) as! LoginViewController
        vc.presenter = presenter
        return vc
    }
    
}

extension LoginViewController : LoginView {
    
    func showLoginButtonEnabled(_ enabled: Bool) {
        loginButton.isEnabled = enabled
    }
    
    func showLoading(_ show: Bool) {
        progressIndicator.visible = show
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == emailInputField) {
            return passwordInputField.becomeFirstResponder()
        } else {
            return textField.resignFirstResponder()
        }
    }
    
}
