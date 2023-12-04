//
//  SignUpViewController.swift
//  RealTimeChat
//
//  Created by VanTuan on 04/12/2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordConfirmTxt: UITextField!
    @IBOutlet weak var loginAction: UIButton!
    
    var account: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    
    @IBAction func registerAction(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { authResult, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Exception", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occurred.")
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                print(self.emailTxt.text!)
                authResult?.user.sendEmailVerification(completion: { error in
                    if error != nil {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Exception", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            NSLog("The \"OK\" alert occurred.")
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "", message: "Mở gmail và xác nhận link", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                            navigationController?.popViewController(animated: true)
                            let email = emailTxt.text!
                            let password = passwordTxt.text!
                            account?(email, password)
                            
//                            var user = User(name: <#T##String#>, email: <#T##String#>, password: <#T##String#>)(name: nameTxt.text!, image: Constant.Key.imageNil)
//
//                            if let currentUser = Auth.auth().currentUser?.uid {
//                                databaseRef.child(Constant.Key.account).child(currentUser).setValue(accountUser.dictionary)
//                            }
                        }))
                        
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
