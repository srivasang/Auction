//
//  ViewController.swift
//  Auction
//
//  Created by PACE on 11/13/17.
//  Copyright © 2017 PACE. All rights reserved.
//


import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Control Action Methods
    @IBAction func SignIn(_ sender: UIButton) {
        invokeLogin()
        
    }
    
    // MARK: - Login
    func invokeLogin() {
        showSpinner()
        //Call oAuthService
        oauthService()
    }
    
    func handleSuccessResponse(response: Any?) {
        print(response ?? "")
        hideSpinner()
        
        
        guard let responseJSON = response as? [String : Any], let userId = responseJSON[kUserId] as? String else {
            handleFailureResponse()
            return
        }
        Utilities.sharedInstance.userId = userId
        
        showAuctionDetailsView()
    }
    
    func handleFailureResponse() {
        hideSpinner()
        showAlert()
    }
    
    // MARK: - Activity Indicator
    func showSpinner() {
        self.activityIndicator?.startAnimating()
    }
    
    func hideSpinner() {
        self.activityIndicator?.stopAnimating()
    }
    
    // MARK: - Auction Detail View
    func showAuctionDetailsView() {

        self.performSegue(withIdentifier:"ProductListViewController", sender: self)
       
        
    }
    
    // MARK: - Alert
    func showAlert() {
        let alert = UIAlertController(title: "Login Error", message: "Invalid Usernmae or Password Please try again!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITextViewDelegate
extension ViewController: UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}

// MARK: - OAuth Login
extension ViewController {
    
    func oauthService() {
        let credentials = "\(kOAuthUser):\(kOAuthPassword)"
        if let data = credentials.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            let headers = [kAuthorization: "Basic \(data.base64EncodedString())", kContentType: kApplicationJson]
            let kTemp = kOAuthUrl + "&username=" + (self.userName?.text)!
            let kUrl = kTemp + "&password=" + (self.password?.text)!
            Alamofire.request(kUrl, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { [weak self] response in
                self?.handleOAuthResponse(response: response.result.value)
            }
        }
        
    }
    
    func handleOAuthResponse(response: Any?) {
        print(response! as Any)        
        guard let responseJSON = response as? [String : Any] else {
                handleFailureResponse()
                return
            }
        // Save OAuth Info into model
        Utilities.sharedInstance.oauthResponse = Mapper<OAuthResponse>().map(JSON: responseJSON)
        print("Printing-->"+(Utilities.sharedInstance.oauthResponse?.accessToken)! as Any)
        GlobalVariables.sharedManager.myToken = ""+String(describing: (Utilities.sharedInstance.oauthResponse?.accessToken)! as Any)
       
        activityIndicator.stopAnimating()
        guard let _ = response as? [String : Any], let status = responseJSON["access_token"] as? String else {
            print("STATUS-------<><><><><>", responseJSON["access_token"] as? String as Any )
            showAlert()
            return
        }
        
        if status != " nil" {
            performSegue(withIdentifier: "ProductListViewController", sender: self)
        } else {
            showAlert()
        }
        
        
    }
    
    
}

