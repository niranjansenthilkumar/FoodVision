//
//  CustomTableCell.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/7/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit

class CustomTableCell: UITableViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 20)
        //label.backgroundColor = .green
        return label
    }()
    
    
    var numericLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .red
        label.font = UIFont(name: "Avenir-Light", size: 20)
        label.textAlignment = .right
        return label
    }()
    
    
    func displayContent(text: String, amount: String){
        label.text = text
        numericLabel.text = amount
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        separatorInset = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsets.zero
        
        addSubview(label)
        label.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 27)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(numericLabel)
        numericLabel.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 27)
        numericLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
