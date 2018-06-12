//
//  InfoController.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/11/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit

class InfoController: UIViewController {
    
    let textView: UILabel = {
        let tv = UILabel()
        tv.text = "FoodVision identifies food\nitems on your plate, and\nprovide a detailed\nnutrition report in\n just seconds.\n😋"
                tv.numberOfLines = 0
        tv.textColor = .white
        tv.textAlignment = .center
        tv.adjustsFontSizeToFitWidth = true
        //tv.text = tv.text?.components(separatedBy: .newLines)
        tv.font = UIFont(name: "Avenir-Medium", size: 30)
        return tv
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "dismiss", attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir-Book", size: 18), NSAttributedStringKey.foregroundColor: UIColor.white])
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 245, green: 241, blue: 237)
        
        view.addSubview(textView)
        textView.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 64, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 333, height: 260)
        
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.backgroundColor = UIColor.rgb(red: 234, green: 82, blue: 111)
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: textView.bottomAnchor, left: textView.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 128, paddingBottom: 252, paddingRight: 150, width: 77, height: 33)
    }
}


