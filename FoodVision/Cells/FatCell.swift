//
//  ThreeCell.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/7/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit

class FatCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
   
    let fatLabel = ["Total Fat (g)", "Saturated Fat (g)", "Trans Fat (g)"]
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = false
        tableView.bounces = false
        tableView.backgroundColor = .white
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    let cellIdentifier: String = "tableCell"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CustomTableCell.self, forCellReuseIdentifier: cellIdentifier)
        
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 16, 0, 16))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutritionInfo.fatInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let text: String = fatLabel[indexPath.row]
        let info: String = nutritionInfo.fatInfo[indexPath.row]
        
        var text = ""
        
        if indexPath.row == 0 {
            text = "Total Fat (g)"
        }
        else if indexPath.row == 1 {
            text = "Saturated Fat (g)"
        }
        else {
            text = "Trans Fat (g)"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableCell
        
        cell.displayContent(text: text, amount: info)
        
        
        
        cell.selectionStyle = .none
        cell.textLabel?.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutMargins = UIEdgeInsets.zero
        cell.backgroundColor = UIColor.clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChannelCell()
        
        addSubview(tableView)
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 1, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 333, height: 71)
        tableView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        nutritionInfo.getFatInfo {
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            }
        }
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
