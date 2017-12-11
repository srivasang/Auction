//
//  ViewController.swift
//  Auction
//
//  Created by PACE on 11/13/17.
//  Copyright © 2017 PACE. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
 
    
    @IBAction func SignIn(_ sender: UIButton) {
        activityIndicator.startAnimating()
        invokeLogin()
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func invokeLogin() {
        let parameters = ["username": userName.text ?? "", "password": password.text ?? ""]
        print (userName.text ?? "")
        Alamofire.request("http://localhost:8991/login/auth", method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { [weak self] response in
            self?.handleResponse(response: response.result.value)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func handleResponse(response: Any?) {
        print(response ?? "$$$$$$$$$$$$$$$")
        guard let responseJSON = response as? [String : Any], let status = responseJSON["status"] as? Int else {
            showAlert()
            return
        }
        
        if status == 200 {
            performSegue(withIdentifier: "ProductListViewController", sender: self)
        } else {
            showAlert()
        }
        activityIndicator.stopAnimating()
    }
    
    func showAuctionDetailsView() {
        self.performSegue(withIdentifier: "ProductListViewController", sender: self)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Login Error", message: "Invalid Usernmae or Password Please try again!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
