//
//  SignUpViewController.swift
//  RunrMVP
//
//  Created by Nashid  on 4/22/17.
//  Copyright © 2017 Nashid Chowdhury. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var scrollingView: UIScrollView!
    
    @IBOutlet weak var firstField: UITextField!
    
    @IBOutlet weak var lastField: UITextField!
    @IBOutlet weak var numField: UITextField!
    @IBOutlet weak var emField: UITextField!
    @IBOutlet weak var passField: UITextField!
   // @IBAction func addButt(_ sender: Any) {
  //  }
    
    
    @IBOutlet var signUpView: UIView!
    
    
    
    @IBAction func doneAction(_ sender: Any) {
        if ((firstField.text?.isEmpty)! || (lastField.text?.isEmpty)! || (emField.text?.isEmpty)! || (numField.text?.isEmpty)! || (passField.text?.isEmpty)!) {
            let alertController = UIAlertController(title: "Whoa Buddy!", message: "You forgot to fill in one or more fields ", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
            }
            
        }else {
            
            API.signUp(first_name: firstField.text!, lname: lastField.text!, email: emField.text!, phone: numField.text!, password: passField.text!, handler: {(succesful : Bool) in
                
                if(succesful){
                    self.performSegue(withIdentifier: "registerSegue", sender: SignUpViewController.self)
                }else{
                    let alertController = UIAlertController(title: "User Exists", message: "This email is already in use, sorry! ", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "ok :(", style: .default) { (action) in
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true) {
                    }
                }
                
            }) ;
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let contentWidth: CGFloat = scrollingView.bounds.width
        let contentHeight = scrollingView.bounds.height * 2
        scrollingView.contentSize = CGSize(width: contentWidth, height:contentHeight)

        
        
        var initialY: CGFloat!
        var offset: CGFloat!
        initialY = signUpView.frame.origin.y
        offset = -120
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            
            self.signUpView.frame.origin.y = initialY + offset
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            
            self.signUpView.frame.origin.y = initialY
        }
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
}
