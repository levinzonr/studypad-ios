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
    

    
    private func showAlert() {
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Some default text"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            if let name = textField.text {
                self.presenter.createNotebook(name: name)
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

}

extension NotebooksViewController : NotebooksView {
    
    func showNotebooks(notebooks: [Notebook]) {
        print("Reloaded: Count: \(notebooks.count)")
        self.notebooks = notebooks
        self.collectionView.reloadData()
    }
    
}

extension NotebooksViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notebooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NotebookViewCell
       cell.notebookNameLabel.text = notebooks[indexPath.row].name
        cell.setupCardView()
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let gradient = CAGradientLayer()
        let colors = notebooks[indexPath.row].gradientColor
        gradient.frame = cell.notebookGradientColorView.bounds
        gradient.colors = colors.toColorArray()
        cell.notebookGradientColorView.layer.addSublayer(gradient)
        
        return cell
    }
}

private extension NotebooksViewController {
    
    @objc func createButtonPressed() {
       showAlert()
    }
}
