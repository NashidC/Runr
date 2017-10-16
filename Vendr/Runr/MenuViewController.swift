//
//  MenuViewController.swift
//  Runr
//
//  Created by Nashid  on 1/29/17.
//  Copyright © 2017 Vendr. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //vendor for the menu this controller is displaying (not necessary, this can be removed and wont hurt the class)
    var vendor:Vendor?
    
    //array of menu items this controller is displaying
    var tableMenuItems: [MenuItem]?
    
    func setVendor(vendor : Vendor){
        tableMenuItems = vendor.menu.getMenuItems();
        
        VendorIDClient.loadVendorMenu(itemId: vendor.id) { (fullMenu: Menu) in
            self.tableMenuItems =
                fullMenu.getMenuItems()
            
            self.tableView.reloadData()
            
        }

    }

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        
//        menuItems = vendor?.menu.getMenuItems();
        
    }
    
    
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(tableMenuItems == nil){
            return 0
        }
        print(self.tableMenuItems?.count)
        return (tableMenuItems!.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        
        //let itemid = "8b0b3ae0-3080-44b4-ba01-6e18832030fb"
        
       // let baseURL = "https:/runr.nyc/apidev/v0.3.0/vendor\(itemid)/menu"
        
        let menuItem = tableMenuItems![indexPath.row]
        cell.nameLabel.text = menuItem.name
        cell.descripLabel.text = menuItem.desc
        
        
        return cell
    }
    
    
    
    

}
