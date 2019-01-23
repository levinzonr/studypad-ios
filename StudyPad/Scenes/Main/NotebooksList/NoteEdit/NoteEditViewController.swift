//
//  NoteEditViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 22/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit
import UITextView_Placeholder


class NoteEditViewController : UIViewController, UITextViewDelegate {
    
    var presenter: NoteEditPresenter!
    var saveNoteTabBarItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSaveButtonClicked))
   
    override func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = saveNoteTabBarItem

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }

    @IBOutlet weak var noteTitleInputField: UITextField! {
        didSet {
            noteTitleInputField.placeholder = "Title"
        }
    }
    
    @IBOutlet weak var noteContentInputField: UITextView! {
        didSet {
            noteContentInputField.placeholder = "Enter note here ..."
            noteContentInputField.delegate = self
        }
    }
    @IBAction func noteTitleDidChange(_ sender: Any) {
        presenter.newTitle = noteTitleInputField.text ?? ""

    }
    
    @IBAction func onNoteTitleChanged(_ sender: Any) {
    }
    
    @objc func onSaveButtonClicked() {
        presenter.saveNote()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        presenter.newContent = textView.text
    }
    
    
    
    
    static func newInstance(with presenter: NoteEditPresenter) -> NoteEditViewController {
        let name = "\(NoteEditViewController.self)"
        let sb = UIStoryboard(name: name, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier:   name) as! NoteEditViewController
        vc.presenter = presenter
        return vc
    }
    
}

extension NoteEditViewController : NoteEditView {
    func showSaveButtonEnabled(_ enabled: Bool) {
        saveNoteTabBarItem.isEnabled = enabled
    }
    
    func showEditMode(_ note: Note) {
        saveNoteTabBarItem.title = "Update"
        noteTitleInputField.text = note.title
        noteContentInputField.text = note.content
    }
    
    func showNoteUpdated() {
        print("Updated")
    }
    
    func showNoteCreated() {
        print("Saved")
    }
    
    
    
}


extension NoteEditViewController {
    
}
