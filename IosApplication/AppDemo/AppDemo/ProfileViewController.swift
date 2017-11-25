//
//  ProfileViewController.swift
//  AppDemo
//
//  Created by Tran Tien Tin on 11/25/17.
//  Copyright © 2017 pega. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProfileImageOnBarButton()
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
        dismiss(animated: true, completion: nil)
    }
}
