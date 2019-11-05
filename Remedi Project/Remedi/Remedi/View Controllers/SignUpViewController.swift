//
//  SignUpViewController.swift
//  Remedi
//
//Team 8
//Programmers: Huy Thong, Krystal Nguyen
//UI designers: Payam Partow, David Song
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
class SignUpViewController: UIViewController {

//    @IBOutlet weak var firstNameTextField: UITextField!
//    @IBOutlet weak var lastNameTextField: UITextField!
    //Connect text fields with main storyboard
    @IBOutlet weak var healthCareTextField: UITextField!
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
        Utilities.styleTextField(healthCareTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    //Create the fields and validate that the data is correct. If everything is correct, this method return nil. Otherwise, it returns the error message as the string
    func validateFields() -> String? {
        //Check if all the fields are filled in
        //Take away all the white space and new lines and check if its empty
        if healthCareTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
    //Signup button, check if there is a profile existing in the Firebase by being added by the physicians
    //If there is patients' profile exists, allows patients to create account
    //If not ask the patient to get prescribed by the physican before creating account
    @IBAction func signUpTapped(_ sender: Any) {
        //Validate the fields
        let error = validateFields()
        if error != nil{
            //There is something wrong with the fields, show error message
            self.showError(error!)
        }
        else{
            let healthCareID = healthCareTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            checkUsername(field: healthCareID){ (success) in
//                print(success)
//                if (success == true) {
//                    Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
//                        if err != nil {
//                            self.showError("Error creating user")
//                        } else {
//                            let db = Firestore.firestore()
//                            db.collection("users").whereField("healthNumber", isEqualTo: healthCareID).getDocuments { (querySnapshot, err) in
//                                if err != nil {
//                                    self.showError("Error creating user")
//                                } else{
//                                    let document = querySnapshot!.documents.first
//                                    document?.reference.updateData(["uid": result!.user.uid])
//                                    print("hi")
//                                    print(result!.user.uid)
//                                    self.transitionToHome()
//                                }
//                            }
//                        }
//                    }
//                } else {
//                    self.showError("Please book an appoinment with doctor to get prescribed")
//                    print("error")
//                }
//            }
            
            let db = Firestore.firestore()
            let docRef = db.collection("users").document(email)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                        if err != nil {
                            self.showError("Error creating user")
                        } else {
                            db.collection("users").document(email).setData(["uid": result!.user.uid], merge: true)
                            self.transitionToHome()
                        }
                    }
                }
                else {
                    self.showError("Please book an appointment with doctor to get prescribed")
                    print("Document does not exist")
                }
            }
        }
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    //Check if there is healthNumber exist, we leave it here for now and instead use the email of the patients.
    //Will consider in future which one is more secured
    func checkUsername(field: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("users")
        print("1")
        collectionRef.whereField("healthNumber", isEqualTo: field).getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else if (snapshot?.isEmpty)! {
                completion(false)
                print("2")
            } else {
                for document in (snapshot?.documents)! {
                    if document.data()["healthNumber"] != nil {
                        completion(true)
                        print("3")
                    }
                }
            }
        }
        
    }
}
