//
//  LoginViewController.swift
//  RealTimeChat
//
//  Created by VanTuan on 04/12/2023.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var emailLb: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var checkValidateEmail: UILabel!
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordLb: UILabel!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var checkValidatePassword: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    var account: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI(){
        emailView.backgroundColor = .darkGray
        emailTxt.borderStyle = .none
        checkValidateEmail.isHidden = true
        
        
        passwordView.backgroundColor = .darkGray
        passwordTxt.borderStyle = .none
        passwordTxt.isSecureTextEntry = true
        checkValidatePassword.isHidden = true
        
        loginBtn.backgroundColor = UIColor(red: 0.14, green: 0.47, blue: 0.43, alpha: 1.00)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
        loginBtn.tintColor = .white
    }

    @IBAction func loginAcion(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTxt.text!) { [self] authResult, error in
            if error != nil {
                //self.showAlert(title: "Error", message: error?.localizedDescription ?? "Exception")
                print(error)
            } else {
                authResult?.user.reload(completion: { error in
                    if authResult?.user.isEmailVerified == true {
                        let homeVC = HomeViewController(nibName: HomeViewController.id, bundle: nil)
                        let nav = UINavigationController(rootViewController: homeVC)
                        nav.setNavigationBarHidden(true, animated: false)
                        nav.modalPresentationStyle = .fullScreen
                        self.present(nav, animated: true)
                        
                    } else {
                       print(error)
                    }
                })
            }
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let registerVC = SignUpViewController(nibName: SignUpViewController.id, bundle: nil)
        
        registerVC.account = { email, password in
            self.emailTxt.text = email
            self.passwordTxt.text = password
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
}
