//
//  AboutAuthorViewController.swift
//  BullsEye
//
//  Created by Alex Lundquist on 5/26/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class AboutAuthorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func close() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
