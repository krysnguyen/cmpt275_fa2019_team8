//
//  LogInViewController.swift
//  Remedi
//
//Team 8
//Programmers: Huy Thong, Krystal Nguyen
//UI designers: Payam Partow, David Song


import UIKit
import FirebaseAuth
//This class using to control the login page
class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //All the set up classes will be here
        setUpElements()
    }
    //For stying all the text fields
    func setUpElements(){
        //Hide the error Label
        errorLabel.alpha = 0
        //Style all the textbox fields
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //check if the account is valid or not before processing to the next page by checking if there is authentication users on Firestore
    @IBAction func loginTapped(_ sender: Any) {
        //Validate Text Fields check if there is any errors if there are gotta show the message and not run the code below
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if error != nil{
                //Couldnt sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else{
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
}
