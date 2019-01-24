//
//  ProfileViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 23/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

final class ProfileViewController : UIViewController {
    
    var presenter: ProfilePresenter!
    
    @IBOutlet weak var profileLogoutButton: UIButton! {
        didSet {
            
        }
    }
    static func newInstance(with presenter: ProfilePresenter) -> ProfileViewController {
       let vc = "\(ProfileViewController.self)".instantiateViewController() as! ProfileViewController
        vc.presenter = presenter
        return vc
    }
    
    @IBAction func onLogoutButtonPressed(_ sender: Any) {
        presenter.logout()
    }
}
