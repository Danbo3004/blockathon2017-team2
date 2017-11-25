//
//  ViewController.swift
//  AppDemo
//
//  Created by Tran Tien Tin on 11/25/17.
//  Copyright © 2017 pega. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
}
