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

final class NotebooksViewController : UIViewController {
    
    @IBOutlet weak var notebooksTableView: UITableView!
    var viewModel: NotebooksViewModel!
    
    var notebooks : [Notebook] = []
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        notebooksTableView.delegate = self
        notebooksTableView.dataSource = self
        
        let nib = UINib(nibName: "NotebookViewCell", bundle: nil)
        notebooksTableView.register(nib, forCellReuseIdentifier: "notebookViewCell")
    }
    
    
    private func setupBindings() {
        viewModel.notebooksObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: ({ (items) in
                print("scuses")
                self.showNotebooks(items: items)
            })) { (error) in
                
        }.disposed(by: disposeBag)
    }
    
    static func instantiate(with viewModel: NotebooksViewModel) -> NotebooksViewController {
        let name = "\(NotebooksViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! NotebooksViewController
        vc.viewModel = viewModel
        print("Initsnaa")
        return vc
    }
    
   
    
    func showNotebooks(items: [Notebook]) {
        self.notebooks = items
    }
}

extension NotebooksViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notebooks.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notebooksTableView.dequeueReusableCell(withIdentifier: "notebookViewCell", for:  indexPath) as! NotebookViewCell
        let notebook = notebooks[indexPath.row]
        cell.notebookNameLabel.text = notebook.name
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [notebook.gradientColor.firstColor, notebook.gradientColor.secondColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = cell.notebookColorView.bounds
        
        cell.notebookColorView.layer.insertSublayer(gradientLayer, at: 0)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    

    
}
