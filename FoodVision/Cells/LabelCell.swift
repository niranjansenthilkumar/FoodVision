//
//  LabelCell.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/7/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .red
        label.font = UIFont(name: "Avenir-Heavy", size: 24)
        return label
    }()
    
    func displayContent(text: String){
        label.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //backgroundColor = .black
        
        setupChannelCell()
        
        addSubview(label)
        label.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 14, paddingBottom: 0, paddingRight: 0, width: 240, height: 33)
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
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
