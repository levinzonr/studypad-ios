//
//  NotebookSelectionViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import UIKit

class NotebookSelectionViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var selectionTitleLabel: UILabel! {
        didSet {
            selectionTitleLabel.text = "Select the notebook you wish to study"
        }
    }
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    private var presenter: NotebookSelectionPresenterInput!
    private var notebooks: [Notebook] = []

    // MARK: - Init
    class func instantiate(with presenter: NotebookSelectionPresenterInput) -> NotebookSelectionViewController {
        let name = "\(NotebookSelectionViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! NotebookSelectionViewController
        vc.presenter = presenter
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(ProfileViewCell.nib, forCellReuseIdentifier: ProfileViewCell.reuseId)

    }

    // MARK: - Callbacks -

}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension NotebookSelectionViewController: NotebookSelectionPresenterOutput {
    func display(_ displayModel: [Notebook]) {
        notebooks = displayModel
        print("display")
        tableView.reloadData()
    }
    
}

extension NotebookSelectionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("configure")
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileViewCell.reuseId, for: indexPath) as! ProfileViewCell
        cell.configure(with: notebooks[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handle(.notebookSelected(notebook: notebooks[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
