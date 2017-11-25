//
//  ViewController.swift
//  AppDemo
//
//  Created by Tran Tien Tin on 11/25/17.
//  Copyright © 2017 pega. All rights reserved.
//

import UIKit
import SwiftyRSA

class ViewController: UIViewController {
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedItem: Int = 0
    
    var myAddress = "0x2EA1C8AF1E7aa5c8Fc572eB4125d72Ab9486E586"
    
    var data = [0: 168, 1: 34, 2: 100]
    var addresses = ["0xFa2fe55F2dcE7eAA4F3bc77161142645CF3f9283": 0,
                   "0x1ABbFe3E2F17E9b8eF5B63383CdAef963b7c4dcF":1,
                   "0x880A93a5430aC7E646E9d6f615B985aEd531c57a":2]
    
    let publicKeyString = "MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAIwOxv5VGfaqhtiKIPwTDUR+n3UTk4sCT3KefGTAeoqjtDltzGZQagwplmBQ/fTSwoXZYnVfHoACGpel/HLpErsCAwEAAQ=="
    let privateKeyString = "MIIBUwIBADANBgkqhkiG9w0BAQEFAASCAT0wggE5AgEAAkEAjA7G/lUZ9qqG2Iog/BMNRH6fdROTiwJPcp58ZMB6iqO0OW3MZlBqDCmWYFD99NLChdlidV8egAIal6X8cukSuwIDAQABAkAJ4/FBfJj8xkYHfJmfs2i4cYipJ9y/cEZT/cUjCESfDZ1JO2r24DqrIUKwPD0vGSxbyA4c65wVHd+bDjdWh2xhAiEA4APprhSJEyxlD8uF3xZBj1ZXbcxVb1A/PKirw2Rl3d8CIQCgDhewcllJaZ4llfWGPEB4Kp3zgAJTw+YB8qNbFv0upQIgBZzTfAMTtCFGnvCwd/hsyBSXuC6IbXOLQg/PzeN0Ee0CIEWXOweWAGpiCMgQ1qsh4WoeJYUtIFXpdEVeiVZevYCdAiAohLyerCONZqhJMckn7G1ifHQ1W/p6gyfMIhZ8TGl31w=="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setProfileImageOnBarButton()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setProfileImageOnBarButton() {
        
        let profileImage = UIImage(named: "avatar")
        let button = UIButton()
        button.setImage(profileImage, for: .normal)
        button.addTarget(self, action: #selector(self.openUserProfile), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.green
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func openUserProfile() {
        performSegue(withIdentifier: "profile_segue", sender: self)
    }
    
    
    @IBAction func reload(_ sender: UIButton) {
        
//        let cipherText = encryptData(plainText: "Thằng c hó Trí ghẻ")
//        _ = decryptData(cypherText: cipherText)
        
        
        fetchData(address: "0x1ABbFe3E2F17E9b8eF5B63383CdAef963b7c4dcF")
        
    }
}

extension ViewController {
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
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card_cell", for: indexPath) as! CardCell
        
        switch indexPath.row {
        case 0:
            cell.cardImageView.image = UIImage(named: "VisaCard")
            cell.storeLabel.text = "TIKI"
            break
        case 1:
            cell.cardImageView.image = UIImage(named: "RedCard")
            cell.storeLabel.text = "LAZADA"
            break
        default:
            cell.cardImageView.image = UIImage(named: "MasterCard")
            cell.storeLabel.text = "NGUYENKIM"
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = indexPath.row
        
        switch indexPath.row {
        case 0:
            
            break
        case 1:
            
            break
        default:
            
            break
        }
        
        showPoint()
    }
    
    func showPoint() {
        pointLabel.text = "\(String(describing: data[selectedItem]!))"
    }
    
    func fetchData(address: String) {
        let urlString = "http://192.168.22.4:3000/getScoreCustomerFromCustomer/\(myAddress)/\(address)"
        
        let request = URLRequest(url: NSURL(string: urlString)! as URL)
        do {
            let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            var dataResponse = try NSURLConnection.sendSynchronousRequest(request, returning: response)
            let jsonSerialized = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String : String]
            if let json = jsonSerialized {
                print(json)
                let point = Int(decryptData(cypherText: json["0"]!)) ?? 0
                
                data[addresses[address]!] = point
                print("show point")
                showPoint()

            }
            
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
