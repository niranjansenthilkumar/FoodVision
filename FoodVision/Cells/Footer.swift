//
//  Footer.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/13/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Footer: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let activityIndicator = NVActivityIndicatorView(frame: self.frame, type: NVActivityIndicatorType.circleStrokeSpin, color: .white, padding: nil)


        activityIndicator.color = .white
        activityIndicator.startAnimating()
        
        addSubview(activityIndicator)
        activityIndicator.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
