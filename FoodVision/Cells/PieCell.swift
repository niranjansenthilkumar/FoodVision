//
//  PieCell.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/7/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit
import Charts

class PieCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let cells = ["Carbs", "Fat", "Protein"]
    
    var pieChart: PieChartView = {
        let pie = PieChartView()
        pie.legend.enabled = false
        pie.chartDescription?.text = ""
        pie.animate(yAxisDuration: 1.25)
        pie.transparentCircleRadiusPercent = 0.0
        pie.holeRadiusPercent = 0.68478260869
        return pie
    }()
    
    var protein = PieChartDataEntry(value: 0.0)
    var fat = PieChartDataEntry(value: 0.0)
    var carbs = PieChartDataEntry(value: 0.0)
    
    var breakDownData = [PieChartDataEntry]()
    
    let breakdownView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
    
    let pieLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutritionInfo.pieTableInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var text = ""
        
        let info: String = nutritionInfo.pieTableInfo[indexPath.row] + "%"
        
        if indexPath.row == 0 {
            text = "Carbs"
        }
        else if indexPath.row == 1 {
            text = "Fat"
        }
        else{
            text = "Protein"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BreakdownCell
        
        cell.displayContent(text: text, amount: info)
        
        if text == "Carbs" {
            cell.label.textColor = UIColor.rgb(red: 74, green: 144, blue: 226)
        }
        if text == "Fat" {
            cell.label.textColor = UIColor.rgb(red: 67, green: 117, blue: 5)
        }
        if text == "Protein" {
            cell.label.textColor = UIColor.rgb(red: 126, green: 211, blue: 33)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: breakdownView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupChannelCell()
        
        addSubview(pieLabel)
        pieLabel.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 13, paddingBottom: 0, paddingRight: 0, width: 185, height: 185)
        pieLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(breakdownView)
        
        breakdownView.dataSource = self
        breakdownView.delegate = self
        
        breakdownView.register(BreakdownCell.self, forCellWithReuseIdentifier: cellId)
        
        breakdownView.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 14, width: 128, height: 114)
        breakdownView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        pieLabel.addSubview(pieChart)
        pieChart.anchor(top: pieLabel.topAnchor, left: pieLabel.leftAnchor, bottom: pieLabel.bottomAnchor, right: pieLabel.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        nutritionInfo.getPieInfo {
            self.breakdownView.reloadSections(IndexSet(integer: 0))
            self.protein.value = nutritionInfo.percentP
            self.fat.value = nutritionInfo.percentF
            self.carbs.value = nutritionInfo.percentC
            
            //self.breakDownData = [self.protein,self.fat,self.carbs]
            self.breakDownData = [self.carbs,self.fat,self.protein]
            let chartDataSet = PieChartDataSet(values: self.breakDownData, label: nil)
            
            chartDataSet.selectionShift = 0
            chartDataSet.drawValuesEnabled = false
            
            let chartData = PieChartData(dataSet: chartDataSet)
            
            let colors = [UIColor.rgb(red: 74, green: 144, blue: 226), UIColor.rgb(red: 208, green: 2, blue: 27), UIColor.rgb(red: 126, green: 211, blue: 33)]
            
            //let colors = [UIColor.rgb(red: 126, green: 211, blue: 33), UIColor.rgb(red: 208, green: 2, blue: 27), UIColor.rgb(red: 74, green: 144, blue: 226)]
            chartDataSet.colors = colors
            
            self.pieChart.data = chartData
            
            print(self.protein.value)
            print(self.carbs.value)
            print(self.fat.value)
            print(nutritionInfo.percentT)
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
