//
//  ViewController.swift
//  Remedi
//
//  Created by Ngan Nguyen on 2019-10-28.
//  Copyright © 2019 Krystal Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }

    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }

}

