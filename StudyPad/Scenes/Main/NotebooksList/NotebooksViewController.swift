//
//  NotebooksViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 12/01/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class NotebooksViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: NotebooksPresenter!
    
    var notebooks : [Notebook] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(createButtonPressed))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        presenter.attachView(view: self)
    }
    

    
    private func showAlert(notebook: Notebook? = nil) {
        
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = notebook?.name
            textField.placeholder = "Notebook name"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            if let name = textField.text {
                if let toEdit = notebook {
                    self.presenter.updateNotebook(notebook: toEdit, newName: name)
                } else {
                    self.presenter.createNotebook(name: name)
                }
            }
        }))
        
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
        self.collectionView.reloadData()
    }
    
}

extension NotebooksViewController : NotebookViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notebooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NotebookViewCell
       cell.notebookNameLabel.text = notebooks[indexPath.row].name
        cell.setupCardView()
        cell.delegate = self
        cell.tag = indexPath.row
        let gradient = CAGradientLayer()
        let colors = notebooks[indexPath.row].color
        gradient.frame = cell.notebookGradientColorView.bounds
        gradient.colors = colors.toColorArray()
        cell.notebookGradientColorView.layer.addSublayer(gradient)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showNotes(notebook: notebooks[indexPath.row])
    }
    
    func onMoreButtonClicked(index: Int) {
        print("notebooks as \(index)")
        showOptionsMenu(notebook: notebooks[index])
    }
}



private extension NotebooksViewController {
    
    @objc func createButtonPressed() {
       showAlert()
    }
}
