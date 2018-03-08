//
//  PackageViewController.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import UIKit

class PackageViewController: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var viewPkgPrice: UIView!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblPackageName: UILabel!
    @IBOutlet var collectionViewDurtions: UICollectionView!
    @IBOutlet var tvDescription: UITextView!
    @IBOutlet var imgCodeVerification: UIImageView!
    @IBOutlet var tfPromoCode: UITextField!
    
    var package : PackageRootClass?
    var durations = [PackagesDuration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configuration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSubscribeClicked(_ sender: UIButton) {
        
    }
    
    func configuration(){
        
        self.title = package?.name
        viewPkgPrice.layer.borderWidth = 2
        viewPkgPrice.layer.borderColor = #colorLiteral(red: 1, green: 0.7244103551, blue: 0.2923497558, alpha: 1)
        fillData()
    }
    
    func fillData(){
        
        if let pkg = package{
            
            if pkg.unlocked.count == 0{
                self.tvDescription.text = ""
            }else{
                var descriptionTxt = "Unlocks "
                for item in pkg.unlocked{
                    
                    descriptionTxt += " \(item.categoryName ?? "-"),"
                }
                descriptionTxt.removeLast(1)
                self.tvDescription.text = descriptionTxt
            }
            
            for duration in pkg.packagesDurations{
                
                self.durations.append(duration)
            }
            self.collectionViewDurtions.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return durations.count
    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: "\(durations[indexPath.row].duration) Months".width(withConstraintedHeight: 0, font: getFont(17, MavenProMedium)), height: collectionViewLayout.collectionViewContentSize.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "durationCell", for: indexPath) as! DurationCollectionViewCell
        
        if durations[indexPath.row].duration < 2 {
            cell.lblTitle.text = "\(durations[indexPath.row].duration ?? 0) Month"
        }else{
            cell.lblTitle.text = "\(durations[indexPath.row].duration ?? 0) Months"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //handle selection
        lblPrice.text = "\(durations[indexPath.row].price - ((durations[indexPath.row].discount / 100) * durations[indexPath.row].price))"
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
