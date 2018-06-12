//
//  SingleCell.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/7/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit

class SingleCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .blue
        label.font = UIFont(name: "Avenir-Light", size: 20)
        return label
    }()
    
    var numericLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .green
        label.font = UIFont(name: "Avenir-Light", size: 20)
        label.textAlignment = .right
        return label
    }()
    
    func displayContent(text: String, amount: String){
        label.text = text
        numericLabel.text = amount
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupChannelCell()
        
        addSubview(label)
        label.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 170, height: 27)
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(numericLabel)
        numericLabel.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 15, width: 60, height: 27)
        numericLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    func setupChannelCell(){
        
        backgroundColor = .white
        //layer.masksToBounds = true
        layer.cornerRadius = 6
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
