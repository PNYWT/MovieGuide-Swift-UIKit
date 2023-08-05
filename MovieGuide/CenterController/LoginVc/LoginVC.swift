//
//  LoginVC.swift
//  MovieGuide
//
//  Created by Dev on 8/4/2566 BE.
//

import UIKit
import AuthenticationServices

class LoginVC: UIViewController {
    
    private let signInBtnApple = ASAuthorizationAppleIDButton()
    private var signInBtnEmail:UIButton!
    private let lbTermsAndConditions = UILabel.init()
    private let lbNotNow = UILabel.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnSignInApple()
        setBtnSignInWithEmail()
//        setNotNow()
//        setTermsandConditions()
    }
    
    private func setBtnSignInWithEmail(){
        signInBtnEmail = UIButton(type: .custom)
        view.addSubview(signInBtnEmail)
        signInBtnEmail.backgroundColor = .white
        signInBtnEmail.addTarget(self, action: #selector(didSignInEmail), for: .touchUpInside)
    }
    
    private func setBtnSignInApple(){
        view.addSubview(signInBtnApple)
        signInBtnApple.addTarget(self, action: #selector(didSignInApple), for: .touchUpInside)
    }
    
    private func setTermsandConditions(){
        var textArray = [String]()
        var fontArray = [UIFont]()
        var colorArray = [UIColor]()
        textArray.append("This is Term")
        textArray.append("This is Conditions")
        fontArray.append(UIFont.systemFont(ofSize: 14, weight: .light))
        fontArray.append(UIFont.systemFont(ofSize: 18, weight: .bold))
        colorArray.append(UIColor.init(white: 1, alpha: 0.8))
        colorArray.append(UIColor.blue)
        self.lbTermsAndConditions.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        self.lbTermsAndConditions.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tapTerm))
        self.lbTermsAndConditions.addGestureRecognizer(tapgesture)
        lbTermsAndConditions.numberOfLines = 0
        lbTermsAndConditions.textAlignment = .center
        view.addSubview(lbTermsAndConditions)
    }
    
    private func setNotNow(){
        lbNotNow.text = "Not Now"
        lbNotNow.textColor = .white
        lbNotNow.font = UIFont.systemFont(ofSize: 18)
        lbNotNow.textAlignment = .center
        self.lbNotNow.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(notNowGoMain))
        self.lbNotNow.addGestureRecognizer(gesture)
        view.addSubview(lbNotNow)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//    x: (ความกว้างจอ - ความกว้างของ View ที่ต้องการให้อยู่ตรงกลาง)/2
        signInBtnApple.frame = CGRect(x: (self.view.frame.width - 140)/2, y: self.view.frame.height/2, width: 140, height: 50)
        signInBtnApple.layer.cornerRadius = signInBtnApple.frame.height/2
        signInBtnApple.layer.masksToBounds = true
        
        signInBtnEmail.frame = CGRect(x: (self.view.frame.width - 140)/2, y: signInBtnApple.frame.origin.y + signInBtnApple.frame.height + spaceDefualt*2 , width: 140, height: 50)
        signInBtnEmail.layer.cornerRadius = signInBtnEmail.frame.height/2
        signInBtnEmail.layer.masksToBounds = true
        signInBtnEmail.setTitle("Email", for: .normal)
        signInBtnEmail.setTitleColor(.black, for: .normal)
        signInBtnEmail.titleLabel?.textAlignment = .center
        
        
//        lbNotNow.frame = CGRect(x: 0, y: signInBtnApple.frame.origin.y + signInBtnApple.frame.height + spaceDefualt*2, width: self.view.frame.width, height: calTextHeight(label: lbNotNow))
//
//        lbTermsAndConditions.frame = CGRect(x: 0, y: lbNotNow.frame.origin.y + lbNotNow.frame.height + spaceDefualt*2, width: self.view.frame.width, height: calTextHeight(label: lbTermsAndConditions))
    }
    
    func calTextHeight(label:UILabel)->CGFloat{
        let size = CGSize(width: self.view.frame.width, height: .greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: label.font]
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let height = NSString(string: label.text ?? "Term").boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil).height
        return height
    }
    
    @objc func didSignInEmail(){
//        let vc = LoginWithOtherVC()
        self.navigationController?.pushViewController(LoginWithOtherVC(), animated: true)
    }
    
    @objc func didSignInApple(){
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @objc func notNowGoMain(){
        UserDefaults.standard.set(true, forKey: KeysUSDF.saveLogin)
        AppDelegate.shareAppDelegate().goMain()
    }
    
    @objc func tapTerm(){
        let policyCondition = PolicyVc.init(nibName: "PolicyVc", bundle: nil)
        self.navigationController?.pushViewController(policyCondition, animated: true)
    }
}

extension LoginVC: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("fail")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential{
        case let credentials as ASAuthorizationAppleIDCredential:
            let fristName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
            //user this post service to regis in backend.
            break
        default:
            break
        }
        
        print("complete")
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
