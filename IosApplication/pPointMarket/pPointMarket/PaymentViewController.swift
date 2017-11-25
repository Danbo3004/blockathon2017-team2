//
//  PaymentViewController.swift
//  pPointMarket
//
//  Created by Tuyen on 11/25/17.
//  Copyright © 2017 Tuyen. All rights reserved.
//

import UIKit
import SwiftyRSA

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var detailImg: UIImageView!
    var isLoyalty: Bool = true
    let serverUrl: String = "192.168.22.4:3000"
    let myAddress: String = "0x1ABbFe3E2F17E9b8eF5B63383CdAef963b7c4dcF"
    
    let customerAddress: String = "0x2EA1C8AF1E7aa5c8Fc572eB4125d72Ab9486E586"
    
    let publicKeyString = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAJNBr6x8U7Z/75jQ+l5vQ4J8h1I2nLbdrvTKqoVy+WmXvDdaCUh/ZkXRQOCTI+zlAbx4eCtS12eL6V+moYIOHxECAwEAAQ=="
    let privateKeyString = "MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEAk0GvrHxTtn/vmND6Xm9DgnyHUjactt2u9MqqhXL5aZe8N1oJSH9mRdFA4JMj7OUBvHh4K1LXZ4vpX6ahgg4fEQIDAQABAkA7V+5e+Z+W3YoGMLmlUvuG236BUEbpnv8B4abEruf6eC704ihORRvEZFwcJfwwY9VT+AAL3t+n+2vI4rU1MIZNAiEA7k8cgwxon+FSrjU4uwI/JArGY3ElaqjhfHVj0UTIvgcCIQCeMDCaEm82gX6T57XKoJzzg8viJpp0mPMk4knjbDJ0JwIhAMh+4rwW2od46TkMKficgUbvkc3kSdic0WkG0r4kIshNAiAqghKdZHTENdoYzrw4Ph7PBUylcfAxguRbtf9bALkyIwIgHPdkalh1hm9uFfozRoknFDOsV9qX+010Y5ujjQVnTNc="
    
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
    
    func decryptData(cypherText: String) -> String {
        
        do {
            let privateKey = try PrivateKey(base64Encoded: privateKeyString)
            let encrypted = try EncryptedMessage(base64Encoded: cypherText)
            let clear = try encrypted.decrypted(with: privateKey, padding: .PKCS1)
            
            // Then you can use:
            let data = clear.data
            let base64String = clear.base64String
            let string = try! clear.string(encoding: .utf8)
            
            print(data)
            print(base64String)
            print(string)
            return string
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return ""
    }
    
    func encryptData(plainText: String) -> String {
        
        let publicKey = try! PublicKey(base64Encoded: publicKeyString)
        let clear = try! ClearMessage(string: plainText, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)
        
        // Then you can use:
        let data = encrypted.data
        let base64String = encrypted.base64String
        
        print(data)
        print(base64String)
        return base64String
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
