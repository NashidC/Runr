//
//  API.swift
//  RunrMVP
//
//  Created by Nashid  on 4/22/17.
//  Copyright © 2017 Nashid Chowdhury. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class API: BDBOAuth1SessionManager {
    
    

    
    
    static func signUp( first_name: String, lname: String, email: String, phone: String, password: String, handler: @escaping (Bool)->Void) {
        
        
        let urlComp : URLComponents = URLComponents(string:"https://runr.nyc/api/v0.5.0/accounts/")!
        let url : URL = (urlComp.url!)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //attach post body
        let postString = "first_name=\(first_name)&last_name=\(lname)&email=\(email)&phone=\(phone)&password=\(password)"
        request.httpBody = postString.data(using: .utf8)
        
        
        //make session (copy paste this)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate:nil ,delegateQueue: OperationQueue.main) // Load configuration into Session
        
        let task: URLSessionDataTask = session.dataTask(with: request,
                                                        
                                                        
                                                        completionHandler:
            { (dataOrNil, response, error) in
                
                var isRegistrationSuccesful : Bool = false;
                
                if let data = dataOrNil {
                    //dataOrNil != nil
                    let decodedString = String(data: data, encoding: .utf8)!
                    print(decodedString)
                    
                    if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                        if let token = (responseDictionary?["result"] as! NSDictionary) ["token"]{
                            saveToken(token: token as! String)
                            isRegistrationSuccesful = true;
                        }
                    }else{
                        
                    }
                    
                    
                    
                }else{
                    //dataOrNil == nil
                }
                
                handler(isRegistrationSuccesful)
                
        }
        );
        task.resume();
    }
    
    
    
    
    
    static func login(email: String, password: String, handler : @escaping (Bool) -> Void ) {
        
        let urlComp: URLComponents = URLComponents(string: "https://runr.nyc/api/v0.5.0/accounts/login/")!
        let url: URL = (urlComp.url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        print(email)
        print(password)
        
        let getString = "email=\(email)&password=\(password)"
        request.httpBody = getString.data(using: .utf8)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate:nil ,delegateQueue: OperationQueue.main) // Load configuration into Session
        
        let task: URLSessionDataTask = session.dataTask(with: request,completionHandler:
        { (dataOrNil, response, error) in
            var loginSuccesful: Bool = false; //store whether login is succesful or not
            
            if let data = dataOrNil {
                //dataOrNil != nil
                let decodedString = String(data: data, encoding: .utf8);
                print(decodedString!)
                
                
                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    if let token = (responseDictionary?["result"] as! NSDictionary) ["token"]{
                        saveToken(token: token as! String)
                        loginSuccesful = true;
                    }
                }else{
                    
                }
            }else{
                
                //dataOrNil == nil
            }
            
            handler(loginSuccesful);
            
        });
        task.resume();
    }
    
    static func saveToken(token:String){
        
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "token")
    }
    
    static func getToken()-> String?{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "token")
    }
    
    static func loggout (token:String){
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "token")
    }
    
    
    static func postOrder (item: String, retrieve_from:String, deliver_to: String, handler : @escaping (Bool) -> Void ) {
        let urlComp: URLComponents = URLComponents(string: "https://runr.nyc/api/v0.5.0//orders")!
        let url: URL = (urlComp.url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        print(item)
        print(retrieve_from)
        print(deliver_to)
        
        let getString = "items=\(item)&retrieve_from=\(retrieve_from)&deliver_to=\(deliver_to)"
        request.httpBody = getString.data(using: .utf8)
        request.allHTTPHeaderFields?["Authorization"] = getToken();
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate:nil ,delegateQueue: OperationQueue.main) // Load configuration into Session
        
        let task: URLSessionDataTask = session.dataTask(with: request,completionHandler:
        { (dataOrNil, response, error) in
            var loginSuccesful: Bool = false; //store whether login is succesful or not
            
            if let data = dataOrNil {
                //dataOrNil != nil
                let decodedString = String(data: data, encoding: .utf8);
                print(decodedString as! String)
                
                
                if let httpResponse = response as? HTTPURLResponse {
                    if(httpResponse.statusCode == 200){
                        loginSuccesful = true;
                    }
                }
            }else{
                
                //dataOrNil == nil
            }
            
            handler(loginSuccesful);
            
        });
        task.resume();
    }
    
}
