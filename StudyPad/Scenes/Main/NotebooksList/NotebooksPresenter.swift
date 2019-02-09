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
    typealias View = NotebooksView
    
    
    func attachView(view: NotebooksView) {
        self.view = view
        loadNotebooks()

    }
    
    func dettachView() {
        self.view = nil
    }
    
    
    var repo: Repository
    private weak var coordinatorDelegate: NotebooksCoordinatorDelegate?
    
    init(repo: Repository, _ coordinatorDelegate: NotebooksCoordinatorDelegate) {
        self.repo = repo
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    func loadNotebooks() {
        repo.getNotebooks { (result: AppResult<[Notebook]>) in
            self.runAction{ view in
                switch result {
                case .success(let items):
                    if items.count > 0 {
                        view.showNotebooks(notebooks: items)
                    } else {
                        view.showEmptyView()
                    }
                case .failure(let error):
                    view.showLoadingError()
                }
            }
        }
    }

    func createNotebook(name: String)  {
        repo.createNotebook(title: name) { result in
            switch result {
            case .failure(let error):
                self.runAction {$0.showError(error)}
            case .success(let data):
                self.loadNotebooks()
            }
        }
    }
    
    func deleteNotebook(notebook: Notebook) {
        repo.deleteNotebook(id: notebook.id) { result in
            switch result {
            case .failure(let error):
                self.runAction { $0.showError(error)}
            case .success:
                self.loadNotebooks()
            }
        }
    }
    
    func updateNotebook(notebook: Notebook, newName: String) {
        repo.updateNotebook(id: notebook.id, newName: newName) { result in
            switch result {
            case .failure(let error):
                self.runAction { $0.showError(error)}
            case .success:
                self.loadNotebooks()
            }
        }
    }
    
    func showNotes(notebook: Notebook)  {
        coordinatorDelegate?.showNotesView(notebook: notebook)
    }
    
    
}
