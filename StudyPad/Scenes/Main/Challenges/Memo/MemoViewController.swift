//
//  MemoViewController.swift
//  StudyPad
//
//  Created by Roman Levinzon on 03/02/2019.
//  Copyright (c) 2019 Roman Levinzon. All rights reserved.
//

import UIKit
import MaterialComponents
import SnapKit

class MemoViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.progress = 0
        }
    }
    @IBOutlet weak var controlsViewStackView: UIStackView!
    @IBOutlet weak var knowButton: UIButton! {
        didSet {
            knowButton.setTitle("I know this!", for: .normal)
            knowButton.backgroundColor = UIColor(named: "darkGreen")
            knowButton.tintColor = .white
            knowButton.layer.cornerRadius = 8
            knowButton.clipsToBounds = true
            knowButton.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.width.equalTo(controlsViewStackView.frame.width / 2.0)
            }
        }
    }
    
    @IBOutlet weak var dontKnowButton: UIButton! {
        didSet {
            dontKnowButton.setTitle("Don't know", for: .normal)
            dontKnowButton.backgroundColor = UIColor(named: "darkRed")
            dontKnowButton.tintColor = .white
            dontKnowButton.layer.cornerRadius = 8
            dontKnowButton.clipsToBounds = true
            dontKnowButton.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.width.equalTo(controlsViewStackView.frame.width / 2.0)
            }
        }
    }
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var closeChallengeButton: UIButton!
    @IBOutlet weak var cardView: MDCCard! {
        didSet {
            cardView.setShadowElevation(ShadowElevation.init(CGFloat(12)), for: .normal)
            cardView.isUserInteractionEnabled = false
            cardView.cornerRadius = 16
        
        }
    }
    
    
    // MARK: - Properties
    private var presenter: MemoPresenterInput!

    // MARK: - Init
    class func instantiate(with presenter: MemoPresenterInput) -> MemoViewController {
        let name = "\(MemoViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        // swiftlint:disable:next force_cast
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! MemoViewController
        vc.presenter = presenter
        return vc
    }

    // MARK: - View Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewCreated()
    }

    // MARK: - Callbacks -
    @IBAction func onCloseButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Leaving challenge", message: "Are you sure you want to leave?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { actiom in
            self.presenter.handle(.leaveChallenge)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            alert.dismiss(animated: true)
        })
       present(alert, animated: true)
    }
    
    @IBAction func onDontKnowButtonPressed(_ sender: Any) {
        presenter.handle(.answerDontKnow)
    }
    @IBAction func onKnowButtonPressed(_ sender: Any) {
        presenter.handle(.answerKnow)
    }
}

// MARK: - Display Logic -

// PRESENTER -> VIEW
extension MemoViewController: MemoPresenterOutput {
    func display(_ data: Memo.DisplayData.Question) {
        dontKnowButton.isEnabled = true
        knowButton.isEnabled = true
        progressView.setProgress(data.progressPercentage, animated: true)
        print(data.progressPercentage)
        contentLabel.text = data.content
    }
    
    func display(_ state: Memo.DisplayData) {
        dontKnowButton.isEnabled = false
        knowButton.isEnabled = false
        switch state {
        case .complete:
            progressView.setProgress(1, animated: true)
            print("complete")
        case .empty:
            print("empty")
        }
    }
    
    func display(_ displayModel: [Note]) {
        
    }
    
    
    func display(_ answer: String) {
        dontKnowButton.isEnabled = false
        contentLabel.text = answer
        
    }

}
