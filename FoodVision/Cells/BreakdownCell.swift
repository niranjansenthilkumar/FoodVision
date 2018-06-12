//
//  BreakdownCell.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/7/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit

class BreakdownCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 22)
        //label.backgroundColor = .yellow
        return label
    }()
    
    var percent: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 18)
        label.textAlignment = .right
        //bllabel.backgroundColor = .green
        return label
    }()
    
    func displayContent(text: String, amount: String){
        label.text = text
        percent.text = amount
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(label)
        label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 1, paddingRight: 0, width: 80, height: 0)
        
        addSubview(percent)
        percent.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 0, paddingBottom: 2, paddingRight: 0, width: 45, height: 0)
        percent.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
