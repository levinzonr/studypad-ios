//
//  NotesViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 21/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class NotesViewController : UIViewController {
    
    var presenter: NotesPresenterImpl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes : [Note]  = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attachView(view: self)
        self.tableView.register(cellType: NoteViewCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(createButtonPressed))

    }
    
    static func instantiate(with presenter: NotesPresenterImpl) -> NotesViewController {
        let name = "\(NotesViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! NotesViewController
        vc.presenter = presenter
        return vc
    }
    
}

extension NotesViewController : NotesView {
    
    func showNotes(_ notes: [Note]) {
        self.notes = notes
    }
    
}


extension NotesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NoteViewCell =  tableView.dequeueReusableCell(for: indexPath)
        cell.tag = indexPath.row
        cell.configure(notes[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleNoteClick(note: notes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

extension NotesViewController {
    @objc func createButtonPressed() {
        presenter.handleNoteCreateion()
    }
}
