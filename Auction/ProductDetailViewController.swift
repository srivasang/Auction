//
//  ProductDetailViewController.swift
//  Auction
//
//  Created by PACE on 11/13/17.
//  Copyright © 2017 PACE. All rights reserved.


import UIKit

class ProductDetailViewController: UIViewController {
   var getCellNo =  Int()
    var getImage = String()
    var getName = String()
    var currentBid =  Int()
    var basePrice =  Int()
    var getTime = String()
    var getDesc = String()
    var getProdId = String()
    var strAuctId: NSString = ""
    let proto = "http://"
    var arrDict :NSMutableArray=[]
    
    @IBOutlet weak var prodNameLbl: UILabel!
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var cBidLbl: UILabel!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var endTimeLbl: UILabel!
    @IBOutlet weak var timeRemainLbl: UILabel!
    @IBOutlet weak var bPriceLbl: UILabel!
    @IBOutlet weak var yourBidLbl: UILabel!
    @IBOutlet weak var proDescTxt: UITextView!
    @IBOutlet weak var amntText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view.
       
        let urlString = URL(string: "http://localhost:8993/auction/getauction/\(getProdId)")
        let session = URLSession.shared
        session.dataTask(with: urlString!) { (data, response, error) in
        if let response =  response {
            print(response)
            }
            if let data = data {
                print(data)
                do{
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
                    let jsonArray = (jsonResult as AnyObject).value(forKey: "auction") as! NSArray
                    for json in jsonArray {
                   
                      //var  auctionId = json ["id"] as? [String:Any]
                    }
                     // let userName = userDict["name"] as? String
                        //print("auc id of the product \(auctionId)")
                    print(jsonResult)
                    } catch {
                    print(error)
                }
            }
         }
           .resume()
      
    
      /*  var i = 0
        func startParsing(data :NSData)
        {
            
            let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            
            for i in 0..<(dict.value(forKey: "auction") as! NSArray).count
            {
                arrDict.add((dict.value(forKey: "auction") as! NSArray).object(at: i))
                print (String(describing: arrDict[i]))
            }
          .reloadData()
           
        }*/
      //  strAuctId = (arrDict[i] as AnyObject) .value(forKey:"id") as! NSString
     // print("auc id of the product \(strAuctId)")
       let img = proto + getImage
   //   prodImage.image = getImage
        navigationItem.title = getProdId
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 224.0/255.0, green: 35.0/255.0, blue: 67.0/255.0, alpha: 1.0)
  
        cBidLbl.text! = String(currentBid)
        bPriceLbl.text! = String(basePrice)
        prodNameLbl.text! = getName
        proDescTxt.text! = getDesc
        let url = URL(string: img as String)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!)
            {
                DispatchQueue.main.async {
                    self.prodImage.image = UIImage(data: data)
                }
            }
        }
        
    }
   
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
        func PlaceBidButnTapped(_ sender: UIButton) {
       // invokePlaceBid()
        yourBidLbl.text = amntText.text!
        let alert = UIAlertController(title: "Alert",message: "Your Bid has been placed successfully.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
   /* func invokePlaceBid() {
        let parameters = ["PlacedBid": amntText.text ?? ""]
        print (amntText.text ?? "")
        Alamofire.request("http://localhost:8993/auction/getauction?productId=getProdId&userId=", method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { [weak self] response in
            self?.handleResponse(response: response.result.value)
        }
    }*/
}

