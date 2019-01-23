//
//  NoteDetailViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit

class NoteDetailViewController : UIViewController {
    
    var presenter: NoteDetailPresenter!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }
    
    @objc func editButtonPressed() {
        presenter.showEditNote()
    }
    
    static func newInstance(with presenter: NoteDetailPresenter) -> NoteDetailViewController {
        let name = "\(NoteDetailViewController.self)"
        let sb = UIStoryboard.init(name: name, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: name) as! NoteDetailViewController
        vc.presenter = presenter
        return vc
    }
    
}

extension NoteDetailViewController : NoteDetailView {
    func showNote(_ note: Note) {
        titleLabel.text = note.title
        contentLabel.text = note.content
    }
    
    
}
