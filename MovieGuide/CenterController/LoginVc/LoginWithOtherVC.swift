//
//  LoginWithOtherVC.swift
//  MovieGuide
//
//  Created by CallmeOni on 5/8/2566 BE.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class LoginWithOtherVC: UIViewController {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUITextField()
        setUIBtn()
    }
    
    private func setUITextField(){
        tfEmail.placeholder = "Email"
        tfEmail.layer.borderWidth = 1
        tfEmail.layer.borderColor = UIColor.black.cgColor
        tfEmail.tag = 101
        tfEmail.autocorrectionType = .no
        tfEmail.keyboardType = .emailAddress
        tfEmail.autocapitalizationType = .none
        
        tfPassword.placeholder = "Password"
        tfPassword.layer.borderWidth = 1
        tfPassword.layer.borderColor = UIColor.black.cgColor
        tfPassword.tag = 102
        tfPassword.autocorrectionType = .no
        tfPassword.autocapitalizationType = .none
        tfPassword.isSecureTextEntry = true
        
        tfEmail.delegate = self
        tfPassword.delegate = self
        
        
        tfEmail.addMove()
        tfPassword.addMove()
        self.hideKeyboardWhenTappedAround()
        
        tfEmail.resignFirstResponder()
    }
    
    private func setUIBtn(){
        btnLogin.backgroundColor = .white
        btnLogin.setTitle("Login Now!", for: .normal)
        btnLogin.setTitleColor(.blue, for: .normal)
        btnLogin.titleLabel?.textAlignment = .center
        btnLogin.addTarget(self, action: #selector(loginNow), for: .touchUpInside)
    }
    
    @objc private func loginNow(){
        ProgressHUD.show("Wait...")
        //        print("Login Now!")
        guard let emailLogin = tfEmail.text else{
            showAlertMissingData(msg: "Please input Email", textFieldCall: tfEmail)
            return
        }
        
        guard let pwLogin = tfPassword.text else{
            showAlertMissingData(msg: "Please input Password", textFieldCall: tfPassword)
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: emailLogin, password: pwLogin) { dataReuslt, err in
            if let errorReturn = err{
                ProgressHUD.dismiss()
                let alert = UIAlertController(title: errorReturn.localizedDescription, message: "Please create Account", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { _ in
                    FirebaseAuth.Auth.auth().createUser(withEmail: emailLogin, password: pwLogin) { dataReuslt, err in
                        if let error = err {
                            ProgressHUD.showError(error.localizedDescription)
                            ProgressHUD.animate(withDuration: 3, delay: 1) {
                                ProgressHUD.dismiss()
                            }
                        } else {
                            ProgressHUD.show()
                            
                            print("User registered successfully")
                            print("CreateUser Success -> \(dataReuslt)")
                            //MARK: Save Account
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.present(alert, animated: true)
            }else{
                if let dataReturn = dataReuslt{
                    print("signIn Success")
                    print("dataReturn -> \(dataReturn.user)")
                    ProgressHUD.animate(withDuration: 3, delay: 1) {
                        let saveParameter:[String:Any] = ["uid":dataReturn.user.uid, "displayName":dataReturn.user.displayName, "photoURL":dataReturn.user.photoURL,"email": dataReturn.user.email, "phoneNumber":dataReturn.user.phoneNumber]
                        UserDefaults.standard.set(saveParameter, forKey: AccountUSDF.saveAccount)
                        ProgressHUD.dismiss()
                    }
                }else{
                    print("SignIn Fail")
                }
            }
        }
    }
    
    private func showAlertMissingData(msg:String, textFieldCall:UITextField?){
        if let tf = textFieldCall {
            let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default,handler: { _ in
                tf.becomeFirstResponder()
            }))
            self.present(alert, animated: true)
        }else{
            let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    
    private func LogoutOther(){
        do{
            try FirebaseAuth.Auth.auth().signOut()
        }catch{
            
        }
    }
}

extension LoginWithOtherVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 101{
            self.tfPassword.becomeFirstResponder()
        }else if textField.tag == 102{
            self.dismissKeyboard()
        }
        return false
    }
}

extension LoginWithOtherVC{
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
