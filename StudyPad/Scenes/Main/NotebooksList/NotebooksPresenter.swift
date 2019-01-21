//
//  NotebooksPresenter.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import RxSwift

final class NotebooksPresenter : BasePresenter {
    var view: NotebooksView?
    
    func attachView(view: NotebooksView) {
        self.view = view
        loadNotebooks()

    }
    
    func dettachView() {
        self.view = nil
    }
    
    typealias View = NotebooksView
    
    var repo: Repository
    
    
    init(repo: Repository) {
        self.repo = repo
    }
    
    func loadNotebooks() {
        repo.getNotebooks { (items: [Notebook]) in
            self.runAction(block: { (view: NotebooksView) in
                view.showNotebooks(notebooks: items)
            })
        }
    }

    func createNotebook(name: String)  {
        repo.createNotebook(title: name) { (items: Notebook) in
            self.loadNotebooks()
        }
    }
    
    func deleteNotebook(notebook: Notebook) {
        repo.deleteNotebook(id: notebook.id) {
            self.loadNotebooks()
        }
    }
    
    func updateNotebook(notebook: Notebook, newName: String) {
        repo.updateNotebook(id: notebook.id, newName: newName) { (Notebook) in
            self.loadNotebooks()
        }
    }
}
