//
//  VendorIDClient.swift
//  Runr
//
//  Created by Nashid  on 1/22/17.
//  Copyright © 2017 Vendr. All rights reserved.
//

import UIKit

import MapKit
import AFNetworking
import Alamofire

class VendorIDClient {
   
   static func loadVendors (lat: Double, lon: Double, refreshControl: UIRefreshControl? = nil, handler: @escaping ([Vendor])->Void) {
      
      
      let queryItems = [NSURLQueryItem (name: "lat", value: String(lat)), NSURLQueryItem(name:"lon", value:String(lon))]
      let urlComp = NSURLComponents(string:"https:/runr.nyc/apidev/v0.3.0/vendor")!
      urlComp.queryItems = queryItems as [URLQueryItem]?
      let urlString = urlComp.url!
      
      
      let request = URLRequest(url: urlString)
      let session = URLSession(
         configuration: URLSessionConfiguration.default,
         delegate: nil,
         delegateQueue: OperationQueue.main) // Load configuration into Session
      
      let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
         
         
         
         if let data = dataOrNil {
            
           // let decodedString = String(data: data, encoding: .utf8)!
            
            //print(decodedString)
            
            if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
               
               
               //responseDictionary : see api
               // responseDictionary['result'] -> [NSDictionary] 
               //take that array of dics and turn it into an array of vendors
               
               
               let result = responseDictionary["result"] as! [NSDictionary]
               let venArr = Vendor.arrayFromDic(dics: result)
               
               for vendor in venArr{
                  print(vendor.name);
               }
               
               handler(venArr)
               
               //[Vendor]
               
               if refreshControl != nil {
                  refreshControl?.endRefreshing()
               }
            }
            
         }else{
            //print an error
         }
         
         
      });
      task.resume()
      
      
   
   }

   /**
    Makes call to https://runr.nyc/apidev/v0.3.0/vendor/:itemId/menu and creates a Menu object from the returned data
    */
   static func loadVendorMenu(itemId : String, refreshControl: UIRefreshControl? = nil, handler: @escaping(Menu)->Void){
      
     

      var urlComp = URLComponents(string:"https:/runr.nyc/apidev/v0.3.0/vendor/"+itemId+"/menu")!
      //let idQuery = URLQueryItem (name: "id", value: String(itemId))
      //let menuQuery = URLQueryItem (name: "menuString", value:"/menu")
      
     // urlComp.queryItems = [idQuery,menuQuery]
      let urlString = (urlComp.url!)
      
      
      let request = URLRequest(url: urlString)
      let session = URLSession(
         configuration: URLSessionConfiguration.default,
         delegate: nil,
         delegateQueue: OperationQueue.main) // Load configuration into Session
      
      let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
        
         
         if let data = dataOrNil {
            
            
            
             let decodedString = String(data: data, encoding: .utf8)!
            
            print(decodedString)
            
            
            if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
               
               
               //responseDictionary : see api
               // responseDictionary['result'] -> [NSDictionary]
               //take that array of dics and turn it into an array of vendors
               
               
               let result = responseDictionary["result"] as! [NSDictionary]
               let menu = Menu.fromDic(dics: result)
               NSLog(result.description)
               NSLog(menu.description)
               
               handler(menu)
               
               
               //[Vendor]
               
               if refreshControl != nil {
                  refreshControl?.endRefreshing()
               }
            }
            
         }else{
            //print an error
         }
         
         
      });
      task.resume()
      
      
      
   }
}



/* static let baseUtl = (String:"https:/runr.nyc/apidev/v0.3.0/")
 
 private init(){}
 
 
 static func loadVendors(lat: Int, lon: Int, refreshControl: UIRefreshControl? = nil) -> [vendor]{
 var id:String
 id = "";
 
 
 
 
 
 
 let path = (String:"vendor?lat=" + String(lat))
 let urlString = (String: (runrClient.baseUtl + path+"&lon="+String(lon)))
 let url = URL(string:urlString);
 
 
 let config = URLSessionConfiguration.default // Session Configuration
 let request = URLRequest(url: url!)
 let session = URLSession(
 configuration: URLSessionConfiguration.default,
 delegate: nil,
 delegateQueue: OperationQueue.main) // Load configuration into Session
 
 let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
 
 if let data = dataOrNil {
 
 let decodedString = String(data: data, encoding: .utf8)!
 
 print(decodedString)
 
 
 
 if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
 NSLog("response: \(responseDictionary)")
 id = responseDictionary.value(forKeyPath: "result") as! String
 
 // reposnseDict["result"] (NSArray)
 //loop through array
 //NSDicts
 
 
 let responseDictionary = responseDictionary["response"] as! NSDictionary
 id = responseDictionary["id"] as! String
 if refreshControl != nil {
 refreshControl?.endRefreshing()
 }
 }
 
 }
 
 
 });
 task.resume()
 
 
 
 } */
//
//   static func loadMenu(_ refreshControl: UIRefreshControl? = nil){
//        var id:String
//        id = "";
//
//        let path = "vendor/:id/menu"
//
//    let url = URL(string:(baseUtl + path))
//
//        let config = URLSessionConfiguration.default // Session Configuration
//        let request = URLRequest(url: url!)
//        let session = URLSession(
//            configuration: URLSessionConfiguration.default,
//            delegate: nil,
//            delegateQueue: OperationQueue.main) // Load configuration into Session
//
//        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (dataOrNil, response, error) in
//
//            if let data = dataOrNil {
//
//                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
//                    NSLog("response: \(responseDictionary)")
//                   id = responseDictionary["id"] as! String
//                    if refreshControl != nil {
//                        refreshControl?.endRefreshing()
//                    }
//                }
//            }
//
//
//        });
//        task.resume()
//
//
//
//    }
