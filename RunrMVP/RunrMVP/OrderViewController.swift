//
//  OrderViewController.swift
//  RunrMVP
//
//  Created by Nashid  on 4/25/17.
//  Copyright © 2017 Nashid Chowdhury. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    @IBOutlet weak var what: UITextField!
    
    @IBOutlet weak var whereFrom: UITextField!
    
    @IBOutlet weak var whereTo: UITextField!
    
    @IBOutlet weak var OrderButt: UIButton!
    
    @IBAction func loggout(_ sender: Any) {
        let alertController = UIAlertController(title: "Are you sure you want to logout?", message: nil, preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Log Out", style:.destructive) { (action) in
            API.loggout(token: "")
            self.performSegue(withIdentifier: "loggoutSegue", sender: OrderViewController.self)
        }
       
        alertController.addAction(logoutAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
      
        alertController.addAction(cancelAction)
        present(alertController, animated: true) {
           
        }
//        
//        API.loggout(token: "")
//        self.performSegue(withIdentifier: "loggoutSegue", sender: OrderViewController.self)

       }

    
    @IBAction func PlaceOrder(_ sender: Any) {
        if ((what.text?.isEmpty)! || (whereTo.text?.isEmpty)! || (whereFrom.text?.isEmpty)!) {
            let alertController = UIAlertController(title: "Unable to Complete Request", message: "Please fill out all fields", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "okay", style: .default) { (action) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
            }
        }else {
            
            API.postOrder(item: what.text!, retrieve_from: whereFrom.text!, deliver_to: whereTo.text!) { (isSuccess: Bool)->Void in
                if(isSuccess){
                    self.performSegue(withIdentifier: "orderSegue", sender: OrderViewController.self)
                }else {
                    //NSAlert
                }
                
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
