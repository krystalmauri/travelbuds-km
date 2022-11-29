//
//  TravelAdvisoryViewController.swift
//  TravelBuds
//
//  Created by Krys Welch on 10/21/22.
//

import UIKit
import WebKit

@available(iOS 16.0, *)
class TravelAdvisoryViewController: UIViewController {

    var travelAdvisoryInfo = [TravelAdvisoryModel]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var noQuickFacts: UILabel!
    @IBOutlet weak var htmlCollectionView: UICollectionView!
    @IBOutlet weak var travelAdvisoryLvl: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var vitalInfoDivider: UIView!
    @IBOutlet weak var quickFactsDivider: UIView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    
    @IBOutlet weak var passportDesc: UILabel!
    @IBOutlet weak var officialcountryLbl: UILabel!
    @IBOutlet weak var passportlbl: UILabel!
    
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var currencyEntryLbl: UILabel!
    @IBOutlet weak var blankPassport: UILabel!
    
    @IBOutlet weak var currencyExitDesc: UILabel!
    @IBOutlet weak var currencyExitLbl: UILabel!
    @IBOutlet weak var currencyEntryDesc: UILabel!
    @IBOutlet weak var vaccinationsDesc: UILabel!
    @IBOutlet weak var vaccinationsLbl: UILabel!
    @IBOutlet weak var touristVisaDesc: UILabel!
    @IBOutlet weak var touristVisa: UILabel!
    @IBOutlet weak var blankPassportDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callAPI()
        noQuickFacts.isHidden = true

    }
    
    func callAPI(){
        API.shared.callLawAPI(onCompletion: { (fetchedLaws: TravelAdvisoryModel) in
            DispatchQueue.main.async {
                self.travelAdvisoryInfo = [fetchedLaws]
                self.config()
                print("traveladvisoryinfo1 \(self.travelAdvisoryInfo)")
                self.htmlCollectionView.reloadData()
                
            }
        })
    }
    
    func config(){
        
        countryLabel.text = travelAdvisoryInfo.first?.countryname
        officialcountryLbl.text = travelAdvisoryInfo.first?.officialcountryname
        travelAdvisoryLvl.text = travelAdvisoryInfo.first?.traveladvisorylevel
        
        if ((travelAdvisoryInfo.first?.traveladvisorylevel?.contains("Level 2")) != false){
            travelAdvisoryLvl.backgroundColor = .yellow
            travelAdvisoryLvl.textColor = .black
        } else if ((travelAdvisoryInfo.first?.traveladvisorylevel?.contains("Level 3")) != false){
            travelAdvisoryLvl.backgroundColor = .orange
        } else if ((travelAdvisoryInfo.first?.traveladvisorylevel?.contains("Level 4")) != false){
            travelAdvisoryLvl.backgroundColor = .red
        }
        
        if travelAdvisoryInfo[0].quickfacts != nil{
            
            if(travelAdvisoryInfo[0].quickfacts!.count > 0){
                
                configQuickFacts()
                
                
            } else{
                scrollView.isHidden = true
                noQuickFacts.isHidden = false
                self.htmlCollectionView.transform = CGAffineTransformMakeTranslation( 0, -65.0 )
                self.infoLabel.transform = CGAffineTransformMakeTranslation( 0, -65.0 )
                self.vitalInfoDivider.transform = CGAffineTransformMakeTranslation( 0, -65.0 )
            }
        }
        else{
            noQuickFacts.isHidden = false
            noQuickFacts.text = "Sorry, this country was not found."
            leftStackView.isHidden = true
            rightStackView.isHidden = true
            quickFactsDivider.isHidden = true
        }
        

    }
    
    func configQuickFacts(){
        
        passportlbl.text = travelAdvisoryInfo.first?.accordion?[0].sectionheader?.uppercased() ?? ""
        blankPassport.text = travelAdvisoryInfo.first?.quickfacts?[1].sectionheader?.uppercased() ?? ""
        touristVisa.text = travelAdvisoryInfo.first?.quickfacts?[2].sectionheader?.uppercased() ?? ""
        vaccinationsLbl.text = travelAdvisoryInfo.first?.quickfacts?[3].sectionheader?.uppercased() ?? ""
        currencyEntryLbl.text = "Currency Restrictions (Entry):".uppercased()
        currencyExitLbl.text = "Currency Restrictions (Exit):".uppercased()
        passportDesc.text = travelAdvisoryInfo.first?.quickfacts?[0].sectioncontent ?? ""
        blankPassportDesc.text = travelAdvisoryInfo.first?.quickfacts?[1].sectioncontent ?? ""
        touristVisaDesc.text = travelAdvisoryInfo.first?.quickfacts?[2].sectioncontent ?? ""
        vaccinationsDesc.text = travelAdvisoryInfo.first?.quickfacts?[3].sectioncontent ?? ""
        currencyEntryDesc.text = travelAdvisoryInfo.first?.quickfacts?[4].sectioncontent ?? ""
        currencyExitDesc.text = travelAdvisoryInfo.first?.quickfacts?[5].sectioncontent ?? ""
        
    }


    
}

@available(iOS 16.0, *)
extension TravelAdvisoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return travelAdvisoryInfo.first?.accordion?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell =  htmlCollectionView.dequeueReusableCell(withReuseIdentifier: "htmlcell", for: indexPath) as! HTMLCollectionViewCell
        
        let content = travelAdvisoryInfo.first?.accordion?[indexPath.row]
        
        htmlCollectionView.layer.opacity = 0.8
        cell.cellLabel?.text = content?.sectionheader

        cell.htmlContent.loadHTMLString("<!DOCTYPE html><html><head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head><body bgcolor=\"#071E26\" text=\"#FFFFFF\" link=\"#FFFFFF\"size=\"18\">\(content?.sectioncontent?.trimmingCharacters(in: .whitespaces) ?? "<p>No content available</p>")</body></html>", baseURL: nil)
        return cell
    }

}

