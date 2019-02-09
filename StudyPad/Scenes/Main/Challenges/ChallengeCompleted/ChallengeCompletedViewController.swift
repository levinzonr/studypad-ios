//
//  ChallengeCompletedViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 09/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import UIKit

class ChallengeCompletedViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            let image = UIImage(named: "test_completed")?.withRenderingMode(.alwaysTemplate)
            imageView.image = image
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Challenge is completed!"
        }
    }
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.text = "///"
        }
    }
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            doneButton.tintColor = .white
            doneButton.setTitle("OK", for: .normal)
            doneButton.backgroundColor = .blue
            doneButton.layer.cornerRadius = 16
            
        }
    }
    @IBOutlet weak var retryButton: UIButton! {
        didSet {
            retryButton.setTitle("Retry", for: .normal)
        }
    }
    // MARK: - Properties
    private var coordinator: ChallengeCompletedCoordinatorInput!
    var result: Memo.Response.Result!

    // MARK: - Init
    class func instantiate(with coordinator: ChallengeCompletedCoordinatorInput, and result: Memo.Response.Result) -> ChallengeCompletedViewController {
        let name = "\(ChallengeCompletedViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! ChallengeCompletedViewController
        vc.coordinator = coordinator
        vc.result = result
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "\(result.correct)/\(result.total), well done!"
    }

    // MARK: - Callbacks -

    @IBAction func onButtonPressed(_ sender: UIButton) {
        if sender == doneButton {
            coordinator.finishChallenge()
        } else {
            coordinator.retryChallenge()
        }
    }
}

// MARK: - Display Logic -

// PRESE
