//
//  NotebooksViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class NotebooksViewController : UIViewController {
    
    var presenter: NotebooksPresenter!
    
    var notebooks : [Notebook] = []
    
    
    @IBOutlet weak var notebooksCollectionView: UICollectionView!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createButtonPressed))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notebooksCollectionView.delegate = self
        self.notebooksCollectionView.dataSource = self
        self.notebooksCollectionView.register(NotebookViewCell.nib, forCellWithReuseIdentifier: NotebookViewCell.reuseId)
        presenter.attachView(view: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadNotebooks()
    }

    
    private func showAlert(notebook: Notebook? = nil) {
        
        let alert = UIAlertController(title: "New notebook", message: "Choose how your notebook will be named", preferredStyle: .alert)
        if let toEdit = notebook {
            alert.title = "Edit \(toEdit.name)"
            alert.message = "Choose new name for this notebook"
        }
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = notebook?.name
            textField.placeholder = "Notebook name"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            if let name = textField.text {
                if let toEdit = notebook {
                    self.presenter.updateNotebook(notebook: toEdit, newName: name)
                } else {
                    self.presenter.createNotebook(name: name)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            alert.dismiss(animated: true)
        })
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    static func instantiate(with presenter: NotebooksPresenter) -> NotebooksViewController {
        let name = "\(NotebooksViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! NotebooksViewController
        vc.presenter = presenter
        print("Initsnaa")
        return vc
    }
    
    private func showOptionsMenu(notebook: Notebook) {
        let optionsMenu = UIAlertController(title: nil, message: "Choose Options", preferredStyle: .actionSheet)
        optionsMenu.addAction(UIAlertAction(title: "Edit", style: .default) { (UIAlertAction) in
            self.showAlert(notebook: notebook)
        })
        
    
        optionsMenu.addAction(UIAlertAction(title: "Delete", style: .default) { (UIAlertAction) in
           self.presenter.deleteNotebook(notebook: notebook)
        })
        
        
        optionsMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(optionsMenu, animated: true, completion: nil)
    }
}

extension NotebooksViewController : NotebooksView {
    
    func showNotebooks(notebooks: [Notebook]) {
        print("Reloaded: Count: \(notebooks.count)")
        self.notebooks = notebooks
        self.notebooksCollectionView.reloadData()
    }
    
}

extension NotebooksViewController : NotebookViewCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
    func collectionView(_ notebooksCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notebooks.count
    }
    
    func collectionView(_ notebooksCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = notebooksCollectionView.dequeueReusableCell(withReuseIdentifier: NotebookViewCell.reuseId, for: indexPath) as! NotebookViewCell
        cell.delegate = self
        cell.tag = indexPath.row
        cell.configure(using: notebooks[indexPath.row])
        return cell
    }
    
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func onNotebookSelected(at position: Int) {
        presenter.showNotes(notebook: notebooks[position])
    }
    
    func onMoreButtonClicked(_ position: Int) {
        self.showOptionsMenu(notebook: notebooks[position])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = self.view.frame.width
        let height = 120.0
        return CGSize(width: Double(widht), height: height)
    }

    
    
    
}



private extension NotebooksViewController {
    
    @objc func createButtonPressed() {
       showAlert()
    }
}
