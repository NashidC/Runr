//
//  Menu.swift
//  Runr
//
//  Created by Nashid  on 1/27/17.
//  Copyright © 2017 Vendr. All rights reserved.
//

import UIKit

class Menu: NSObject {
   
    let menuGroups: [MenuGroup]
    
    init(menuGroups:[MenuGroup]) {

        self.menuGroups = menuGroups
    
        super.init()
    }
    
    /**
     creates an NSDictionary with an MenuGroup for each category in dics
     
     parameters:
        dics:    Array of NSDictionaries, each NSDictionary represents a MenuItem
                Each menu item has a name, description, category
     
     
 
 */
    
    static func fromDic(dics:[NSDictionary]) -> Menu {
        var menuGroups = Dictionary<String, MenuGroup>()
        
        for i in 0...dics.count-1 {
            let dic = dics[i]                               //gets a dictionary
            let cat = dic["category"] as! String   //value for "category" from the dictionary
            
            //made sure menuGroups[cat] has a MenuGroup object
            if (menuGroups[cat] == nil) {                   //check if the value at cat is nil, where cat is the category
                // set  menuGroups at cat to a new menugroup with the name cat
                let menuItems : [MenuItem] = Array();
                menuGroups[cat] = MenuGroup(name:cat, menuItems : menuItems)
            }
            
            //insert the menu item into the right MenuGroup object
            let menuGroup : MenuGroup = menuGroups[cat]!
            menuGroup.menuItems.append(MenuItem.fromDic(dic: dic));
            
        }
        
        return Menu(menuGroups: Array(menuGroups.values));
        
    }
    
    func getMenuItems() -> [MenuItem] {
        
        var menuArr: [MenuItem] = []
        
        for menuGroup in menuGroups {
            for menuItem in menuGroup.menuItems{
               menuArr.append(menuItem)
            }
    }
        return menuArr
    }

}

class MenuGroup: NSObject {
    let name: String
    var menuItems: [MenuItem]
    
    init(name:String, menuItems:[MenuItem]) {
        self.name = name
        self.menuItems = menuItems
        
        super.init()
    }
}

class MenuItem: NSObject {
    let name:String
    let price: Double
    let desc: String?
    
    init(name:String, price:Double, desc:String?){
        self.name = name
        self.price = price
        self.desc = desc
        
        super.init()
    }
    
    static func fromDic (dic:NSDictionary) ->MenuItem {
        let name = dic["name"] as! String
        var price = dic["price"]
        if (price is String){
            price = Double((price as? String)!)
        }
        else{
            price = price as? Double

        }
        
        if(price == nil){
            price = Double(-1)
        }
        
       
        
       let desc : String? = dic["description"] as? String
        
        
        
        
        let menuItem = MenuItem(name: name, price: price as! Double, desc: desc)
    
        return menuItem
    }
    
    static func arrayFromDic (dics:[NSDictionary]) ->[MenuItem] {
        var itemArr: [MenuItem] = []
        
        for i in 0...dics.count-1 {
            let obj = MenuItem.fromDic(dic: dics[i])
            itemArr.append(obj)
        }
        return itemArr
    }
    
    
    
    
    
}









