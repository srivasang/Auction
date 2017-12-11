//
//  ProductListViewController.swift
//  Auction
//
//  Created by mac3 on 11/17/17.
//  Copyright © 2017 PACE. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    let yourJsonFormat: String = "JSONurl"
    var strProdName: NSString = ""
    var strImageurl: NSString = ""
    var strProdDesc: NSString = ""
    var strProdBprice: NSInteger = 0
    var strProdId: NSString = ""
    var data : UIImage?
    
    @IBOutlet weak var lstTableView: UITableView!
    var arrDict :NSMutableArray=[]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("Hi2")
        return arrDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print ("Hi3")
        let proto = "http://"
        let cell : TableViewCell! = tableView.dequeueReusableCell(withIdentifier: "TblViewCell") as! TableViewCell
         strProdName = (arrDict[indexPath.row] as AnyObject) .value(forKey:"productName") as! NSString
        strImageurl = (arrDict[indexPath.row] as AnyObject) .value(forKey:"imageURL") as! NSString
         strProdDesc = (arrDict[indexPath.row] as AnyObject) .value(forKey:"description") as! NSString
        strProdBprice = (arrDict[indexPath.row] as AnyObject) .value(forKey:"basePrice") as! NSInteger
        strProdId = (arrDict[indexPath.row] as AnyObject) .value(forKey:"id") as! NSString
        //let strProdCprice : NSString=(arrDict[indexPath.row] as AnyObject) .value(forKey:"basePrice") as! NSString
        let strImage  = proto + String(strImageurl)
        cell.lblDetails.text=strProdName as String
        cell.lblDesc.text=strProdDesc as String
        cell.lblBp.text=String (strProdBprice) as String
        cell.lblCp.text=String (strProdBprice)  as String
        let url = URL(string: strImage as String)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!)
            {
            DispatchQueue.main.async {
                cell.productImg.image = UIImage(data: data)
            }
            }
        }
        
        print (cell)
        return cell as TableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let DVC = Storyboard.instantiateViewController(withIdentifier: "detailSegueId") as! ProductDetailViewController
        
       DVC.getCellNo = indexPath.row
        DVC.getImage = (arrDict[indexPath.row] as AnyObject) .value(forKey:"imageURL") as! NSString as String
        DVC.getName = (arrDict[indexPath.row] as AnyObject) .value(forKey:"productName") as! NSString as String
        DVC.currentBid = (arrDict[indexPath.row] as AnyObject) .value(forKey:"basePrice") as! NSInteger
        DVC.basePrice = (arrDict[indexPath.row] as AnyObject) .value(forKey:"basePrice") as! NSInteger
        DVC.getDesc = (arrDict[indexPath.row] as AnyObject) .value(forKey:"description") as! NSString as String
        DVC.getProdId = ((arrDict[indexPath.row] as AnyObject) .value(forKey:"id") as! NSString) as String
        // DVC.getTime = name[indexPath.row] as! String
        
        self.navigationController?.pushViewController(DVC, animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose an Item"
        navigationController?.navigationBar.barTintColor = UIColor(red: 224.0/255.0, green: 35.0/255.0, blue: 67.0/255.0, alpha: 1.0)
        if yourJsonFormat == "JSONFile" {
            //jsonParsingFromFile()
            jsonParsingFromURL()
        } else {
            jsonParsingFromURL()
        }
    }
    
    
    func jsonParsingFromURL () {
        let url = URL(string: "http://localhost:8992/product/list")
        let request = URLRequest(url: url! as URL)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
          self.startParsing(data: data! as NSData)
        }
    }
    
    func startParsing(data :NSData)
    {
        
        let dict: NSDictionary!=(try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        
        for i in 0..<(dict.value(forKey: "Productlist") as! NSArray).count
        {
           arrDict.add((dict.value(forKey: "Productlist") as! NSArray).object(at: i))
            print (String(describing: arrDict[i]))
        }
        lstTableView .reloadData()
    }
    

    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        print ("Hi1")
        return 1
    }
}


