//
//  EmptyView.swift
//  StudyPad
//
//  Created by Roman Levinzon on 04/02/2019.
//  Copyright © 2019 Roman Levinzon. All rights reserved.
//

import UIKit
import SnapKit
class EmptyView: UIView {

    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.isHidden = true
            imageView.tintColor = .blue
           
        }
    }
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var buttonView: UIButton! {
        didSet {
            buttonView.isHidden = true
        }
    }
    
    private var listener: () -> Void = { }
    
    @IBAction func onActionButtonPressed(_ sender: Any) {
        listener()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initilize()
    }
    
    private func initilize() {
        Bundle.main.loadNibNamed("EmptyView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    

    func configure(title: String, image: UIImage?, button: (String, () -> Void)? = nil) {
        labelView.text = title
        if let image = image {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.isHidden = false
        }
        
        if let action = button {
            buttonView.isHidden = false
            buttonView.setTitle(action.0, for: .normal)
            listener = action.1
        }
    }
    
}
