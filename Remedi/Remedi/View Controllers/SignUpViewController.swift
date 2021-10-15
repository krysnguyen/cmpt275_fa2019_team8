//
//  SignUpViewController.swift
//  Remedi
//
//  Created by Ngan Nguyen on 2019-10-28.
//  Copyright © 2019 Krystal Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements(){
        //Hide the error label
        errorLabel.alpha = 0;
        //Style all the elements
        //All the styling are in the Utilities folder that can be used to achieve this
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    //Create the fields and validate that the data is correct. If everything is correct, this method return nil. Otherwise, it returns the error message as the string
    func validateFields() -> String? {
        //Check if all the fields are filled in
        //Take away all the white space and new lines and check if its empty
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
        //Check if the password is secure or if its valid by using the function in Utilities and it will use the pattern called regular expression and check if it meets the requirement
        //Return true if it passes and false if it doesnt
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false{
            return "Please make sure your password has at least 8 characters and contain a special character and a number"
        }
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        //Validate the fields
        let error = validateFields()
        if error != nil{
            //There is something wrong with the fields, show error message
            showError(error!)
        }
        else{
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            checkUsername(field: firstName){ (success) in
                if (success == true) {
                    Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                        if err != nil {
                            self.showError("Error creating user")
                        } else {
                            let db = Firestore.firestore()
                            db.collection("users").whereField("firstname", isEqualTo: firstName).getDocuments { (querySnapshot, err) in
                                if err != nil {
                                    self.showError("Error creating user")
                                } else{
                                    let document = querySnapshot!.documents.first
                                    document?.reference.updateData(["uid": result!.user.uid])
                                    self.transitionToHome()
                                }
                            }
                        }
                    }
                } else {
                    self.showError("Please book an appoinment with doctor to get prescribed")
                }
            }
        }
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    func checkUsername(field: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("users")
        collectionRef.whereField("firstname", isEqualTo: field).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else if (snapshot?.isEmpty)! {
                completion(false)
            } else {
                for document in (snapshot?.documents)! {
                    if document.data()["firstname"] != nil {
                        completion(true)
                    }
                }
            }
        }
    }
}
