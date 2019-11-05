//
//  ViewController.swift
//  Remedi
//
//Team 8
//Programmers: Huy Thong, Krystal Nguyen
//UI designers: Payam Partow, David Song

import UIKit

class ViewController: UIViewController {
    //Connect all the buttons with main story board
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

