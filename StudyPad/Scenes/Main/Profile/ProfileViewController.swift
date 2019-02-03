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
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileLogoutButton: UIButton! {
        didSet {
            profileLogoutButton.layer.cornerRadius = 8
            profileLogoutButton.clipsToBounds = true
        }
    }
 

    @IBOutlet weak var userNameLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        
        tableView.register(ProfileViewCell.nib, forCellReuseIdentifier: ProfileViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.isScrollEnabled = false

    
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

extension ProfileViewController : ProfileView {
    func showProfileInfo(_ user: User) {
        userNameLabel.text = user.displayName
    }
    
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewCell.reuseId) as! ProfileViewCell
        switch indexPath.row{
        case 0:
            cell.configure(with: "Edit Profile")
        case 1:
            cell.configure(with: "Privacy Policy")
        case 2:
            cell.configure(with: "Terms And Conditions")
        default:
            cell.configure(with: "About", and: "Version " + ( Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}
