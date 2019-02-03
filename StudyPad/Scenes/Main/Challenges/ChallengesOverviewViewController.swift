//
//  ChallengesOverviewViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import UIKit
import SnapKit

class ChallengesOverviewViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var basicTestButton: UIButton! {
        didSet {
            basicTestButton.setTitle("Basic Self check", for: .normal)
            basicTestButton.layer.cornerRadius = 8
            basicTestButton.titleEdgeInsets.left = 24
            basicTestButton.imageEdgeInsets.left = 16
            basicTestButton.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
    @IBOutlet weak var writtenTestButton: UIButton! {
        didSet {
            writtenTestButton.isEnabled = false
            writtenTestButton.setTitle("Written test", for: .normal)
            writtenTestButton.layer.cornerRadius = 8
            writtenTestButton.titleEdgeInsets.left = 24
            writtenTestButton.imageEdgeInsets.left = 16
            writtenTestButton.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
    }
    @IBOutlet weak var overviewTitleLabel: UILabel! {
        didSet {
            overviewTitleLabel.text = "Choose your challenge to continue"
        }
    }
    
    // MARK: - Properties
    private var presenter: ChallengesOverviewPresenterInput!

    // MARK: - Init
    class func instantiate(with presenter: ChallengesOverviewPresenterInput) -> ChallengesOverviewViewController {
        let name = "\(ChallengesOverviewViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! ChallengesOverviewViewController
        vc.presenter = presenter
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
    }

    // MARK: - Callbacks -
    @IBAction func onChallengeSelected(_ sender: Any) {
        presenter.handle(.typeSelected(type: .memorize))
    }
    
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension ChallengesOverviewViewController: ChallengesOverviewPresenterOutput {

}
