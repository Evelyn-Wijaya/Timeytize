//
//  Streak.swift
//  MC1.2 - Eve printilan
//
//  Created by Evelyn Wijaya on 13/04/21.
//

import UIKit

class Streak: UIViewController{
    
    //My Best All Time
    @IBOutlet weak var containerAllTime: UIView!
    @IBOutlet weak var inputAllTime: UILabel!
        @IBOutlet weak var daysTextAllTime: UILabel!
    
    
    //My Best This Month
    @IBOutlet weak var containerThisMonth: UIView!
    @IBOutlet weak var inputThisMonth: UILabel!
        @IBOutlet weak var daysTextThisMonth: UILabel!
    //Input Day in a month calendar
    @IBOutlet weak var inputDaysInAMonth: UILabel!
        
    
    //Flame
    @IBOutlet weak var containerFlame: UIView!
    @IBOutlet weak var containerOuterFlame: UIView!
    @IBOutlet weak var sfFlame: UIImageView!
    
    
            //dummy button gatau gunanya apa
            @IBOutlet weak var dumInputAllTime: UIButton!
            @IBOutlet weak var dumInputThisMonth: UIButton!
            @IBOutlet weak var dumInputDaysInAMonth: UIButton!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //MARK: -C. All Time
        containerAllTime.layer.cornerRadius = 8
        containerAllTime.layer.shadowColor = #colorLiteral(red: 0.9921568627, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
        containerAllTime.layer.shadowOpacity = 0.3
        containerAllTime.layer.shadowRadius = 7
        containerAllTime.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        //MARK: -C. This Month
        containerThisMonth.layer.cornerRadius = 8
        containerThisMonth.layer.shadowColor = #colorLiteral(red: 0.9921568627, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
        containerThisMonth.layer.shadowOpacity = 0.3
        containerThisMonth.layer.shadowRadius = 7
        containerThisMonth.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        //MARK: -C. Flame
        containerOuterFlame.layer.cornerRadius = 130
        containerOuterFlame.layer.shadowColor = #colorLiteral(red: 0.9890349507, green: 0.906324327, blue: 0.7287408113, alpha: 1)
        //containerOuterFlame.layer.shadowColor = #colorLiteral(red: 0.9960784314, green: 0.8274509804, blue: 0.8666666667, alpha: 1)
        containerOuterFlame.layer.shadowOpacity = 0.7
        containerOuterFlame.layer.shadowRadius = 8
        
        containerFlame.layer.cornerRadius = 100
        containerFlame.layer.shadowColor = #colorLiteral(red: 0.9890349507, green: 0.906324327, blue: 0.7287408113, alpha: 1)
        //containerFlame.layer.shadowColor = #colorLiteral(red: 0.9960784314, green: 0.8274509804, blue: 0.8666666667, alpha: 1)
        containerFlame.layer.shadowOpacity = 0.7
        containerFlame.layer.shadowRadius = 10
        
        
        //sfFlame.layer.shadowColor = #colorLiteral(red: 0.9921568627, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
        sfFlame.layer.shadowColor = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.2941176471, alpha: 1)
        sfFlame.layer.shadowOpacity = 0.6
        sfFlame.layer.shadowRadius = 15
        
        
    }
    // MARK: -___ACTION___
    // MARK: -Action: All Time, ubah total STREAK ALL TIME
    @IBAction func actionInputAllTime(_ sender: Any) {
        inputAllTime.text = "30"
    }
    
    
    //MARK: -Action: This Month, ubah total STREAK THIS MONTH
    @IBAction func actionInputThisMonth(_ sender: Any) {
        inputThisMonth.text = "30"
    }
    
    @IBAction func actionInputDaysInAMonth(_ sender: Any) {
        inputDaysInAMonth.text = "31"
    }
    
    
}

