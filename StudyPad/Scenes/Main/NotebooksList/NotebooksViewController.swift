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
    
    var viewModel: NotebooksViewModel!
    
    var notebooks : [Notebook] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        collectionView.delegate = self
        collectionView.dataSource = self

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
