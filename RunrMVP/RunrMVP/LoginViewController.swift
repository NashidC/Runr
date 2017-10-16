//
//  LoginViewController.swift
//  RunrMVP
//
//  Created by Nashid  on 4/22/17.
//  Copyright © 2017 Nashid Chowdhury. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBAction func login(_ sender: Any) {
        
        if ((loginField.text?.isEmpty)!  || (passField.text?.isEmpty)!){
            let alertController = UIAlertController(title: "Wait", message: "You forgot to fill in a field", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
            }
            
        } else {
            
            API.login(email: loginField.text!, password: passField.text!, handler:
                {(loggedIn:Bool)->Void in
                    
                    if(loggedIn){
                        self.performSegue(withIdentifier: "loginSegue", sender: LoginViewController.self)
                    }else{
                        let alertController = UIAlertController(title: "Error", message: "Incorrect Login Information ", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                        }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true) {
                        }
                        
                    }
                    
            })
            
        }
    }
    @IBAction func signUp(_ sender: Any) {
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(API.getToken() != nil){
            performSegue(withIdentifier: "loginSegue", sender: LoginViewController.self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if (segue.identifier == "loginSegue") {
    //            (segue.destination as! OrderViewController)
    //        }
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
}
