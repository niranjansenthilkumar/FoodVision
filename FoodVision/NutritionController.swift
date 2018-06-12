//
//  NutritionController.swift
//  FoodVision
//
//  Created by Niranjan Senthilkumar on 6/7/18.
//  Copyright © 2018 NJ. All rights reserved.
//

import UIKit

class NutritionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let caloriesId = "caloriesId"
    let breakdownId = "breakdownId"
    let threeCellId = "threeCellId"
    let singleCellId = "singleCellId"
    let vitaminId = "vitaminId"
    let carbId = "carbId"
    
    var scannedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(12323)
        collectionView?.backgroundColor = UIColor.rgb(red: 234, green: 82, blue: 111)
        
        setupNavBar()

        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(LabelCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(CaloriesCell.self, forCellWithReuseIdentifier: caloriesId)

        collectionView?.register(PieCell.self, forCellWithReuseIdentifier: breakdownId)
        collectionView?.register(FatCell.self, forCellWithReuseIdentifier: threeCellId)
        
        collectionView?.register(SingleCell.self, forCellWithReuseIdentifier: singleCellId)
        collectionView?.register(VitaminCell.self, forCellWithReuseIdentifier: vitaminId)
        collectionView?.register(CarbCell.self, forCellWithReuseIdentifier: carbId)

        nutritionInfo.getFoodName {
            self.collectionView?.reloadSections(IndexSet(integer: 0))
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutritionInfo.name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 0, bottom: 20, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let text: String = store.cells[indexPath.row]
        //let labelText: String = store.cellLabels[indexPath.row]
        
        let info: String = nutritionInfo.name[indexPath.row]
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LabelCell
            
            
            cell.displayContent(text: scannedText.capitalized)
            return cell
            //Ice Cream 🍦
        }
        
        else if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: threeCellId, for: indexPath) as! FatCell
            
            return cell
        }
        
        else if indexPath.row == 6 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carbId, for: indexPath) as! CarbCell
            
            return cell
        }
        
        else if indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 8 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: singleCellId, for: indexPath) as! SingleCell
            
            if indexPath.row == 4 {
                cell.displayContent(text: "Cholesterol (mg)", amount: info)
            }
            else if indexPath.row == 5 {
                cell.displayContent(text: "Sodium (mg)", amount: info)
            }
            else{
                cell.displayContent(text: "Protein (g)", amount: info)
            }
            
            return cell
        }
        
        else if indexPath.row == 7 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: vitaminId, for: indexPath) as! VitaminCell
            
            return cell
        }
            
        else if indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: breakdownId, for: indexPath) as! PieCell
            
            return cell
        }
        
        //calories chart
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: caloriesId, for: indexPath) as! CaloriesCell
            return cell
        }
        
    }
    
    //deallocate all memory when user clicks away
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.tintColor = .blue
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        nutritionInfo.foods.removeAll()
        nutritionInfo.name.removeAll()
        nutritionInfo.calorieInfo.removeAll()
        nutritionInfo.fatInfo.removeAll()
        nutritionInfo.carbInfo.removeAll()
        nutritionInfo.vitaminInfo.removeAll()
        nutritionInfo.pieTableInfo.removeAll()
        nutritionInfo.percentF = 0
        nutritionInfo.percentP = 0
        nutritionInfo.percentC = 0
        nutritionInfo.percentT = 0        
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //label
        if indexPath.row == 0{
            return CGSize(width: view.frame.width - 12, height: 51)
        }
        
        //threecell
        else if indexPath.row == 3 {
            return CGSize(width: view.frame.width - 12, height: 135)
        }
        
        //singlecell
        else if indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 8{
            return CGSize(width: view.frame.width - 12, height: 46)
        }
            
        //vitamin
        else if indexPath.row == 7{
            return CGSize(width: view.frame.width - 12, height: 182)
        }
        
        //carbcell
        else if indexPath.row == 6 {
            return CGSize(width: view.frame.width - 12, height: 135)
        }
        
        //breakdown
        if indexPath.row == 2 {
            return CGSize(width: view.frame.width - 12, height: 204)
        }
        
        //calories chart
        else{
            return CGSize(width: view.frame.width - 12, height: 91)
        }
        
    }

    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 234, green: 82, blue: 111)
        //navigationController.nav
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = " "
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    
    }

    
    @objc func backButtonPressed(){
        
        nutritionInfo.foods.removeAll()
        nutritionInfo.calorieInfo.removeAll()
        nutritionInfo.name.removeAll()
        nutritionInfo.fatInfo.removeAll()
        nutritionInfo.carbInfo.removeAll()
        nutritionInfo.vitaminInfo.removeAll()
        
        print(nutritionInfo.carbInfo)
        print("success")
        
        self.navigationController?.popViewController(animated: true)
    }
}
