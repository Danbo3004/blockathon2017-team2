//
//  PaymentViewController.swift
//  pPointMarket
//
//  Created by Tuyen on 11/25/17.
//  Copyright © 2017 Tuyen. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var detailImg: UIImageView!
    var isLoyalty: Bool = true
    let serverUrl: String = "192.168.22.4:3000"
    let myAddress:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if isLoyalty {
            detailImg.image = UIImage(named: "loyalty_detail")
            //buyBtn.setTitle("Buy with Loyalty", for: .normal)
        } else {
            detailImg.image = UIImage(named: "cash_detail")
            //buyBtn.setTitle("Buy with Cash", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestScore(address: String) -> CGFloat {
        let request = URLRequest(url: NSURL(string: "\(serverUrl)/getScoreCustomerFromCustomer/\(myAddress)/\(address)")! as URL)
        do {
            let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            let data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
            
            let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            if let json = jsonSerialized {
                return 100
            }
            return 0
        } catch let error as NSError {
            print(error.localizedDescription)
            return 0
        }
    }
    
    func updateScore(address: String, score: CGFloat) {
        let totalScoreCusEnc: String = "Total score cus hash"
        let totalScoreRetEnc: String = "Total score ret hash"
        let changeScorecusEn: String = "Total score cus hans"
        let request = URLRequest(url: NSURL(string: "\(serverUrl)/updateScoreToCustomer/\(myAddress)/\(address)/\(totalScoreCusEnc)/\(totalScoreRetEnc)/\(changeScorecusEn)")! as URL)
        do {
            let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            let data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
            
            let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            if let json = jsonSerialized {
                print("success")
            }
        } catch let error as NSError {
            print(error.localizedDescription)

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buyProduct(_ sender: Any) {
        let reducePoint: CGFloat = 100
        let increasePoint: CGFloat = 15
        let address: String = ""
        if isLoyalty {
            let currentPoint: CGFloat = 10000//requestScore(address: address)
            if currentPoint >= reducePoint {
                //updateScore(address: address, score: currentPoint - reducePoint)
                performSegue(withIdentifier: "show_loyalty_payment", sender: self)
            } else {
                print("buy fail")
            }
        } else {
            //let currentPoint: CGFloat = requestScore(address: address)
            //updateScore(address: address, score: currentPoint + increasePoint)
            performSegue(withIdentifier: "show_cash_payment", sender: self)
        }
    }
}
