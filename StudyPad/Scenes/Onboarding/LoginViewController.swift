//
//  LoginViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {
    
    var presenter: LoginPresenter!
    
    @IBAction func onLoginButtonClicked(_ sender: Any) {
        presenter.login()
    }
    
    static func newInstance(with presenter: LoginPresenter) -> LoginViewController {
        let name = "\(LoginViewController.self)"
        let sb = UIStoryboard.init(name: name, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: name) as! LoginViewController
        vc.presenter = presenter
        return vc
    }
    
}
