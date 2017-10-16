//
//  Vendor.swift
//  Runr
//
//  Created by Nashid  on 1/25/17.
//  Copyright © 2017 Vendr. All rights reserved.
//

import MapKit

class Vendor: NSObject, MKAnnotation {
    let id : String
    let name : String
    var title: String?
    let coordinate: CLLocationCoordinate2D
    var menu: Menu
    
    
    
    init(id:String, coordinate:CLLocationCoordinate2D, name:String, menu:Menu) {
        self.id = id
        self.name = name
        self.title = name
        self.coordinate = coordinate
        self.menu = menu
        
        super.init()
    }
   //parsing
   static func fromDic (dic: NSDictionary) -> Vendor {
        let id =  dic["id"] as! String
        let name = dic["name"] as! String
        let location = dic["location"] as! NSDictionary
           let x =  location["x"] as! Double
           let y = location["y"] as! Double
        let menu = Menu.fromDic(dics: dic["menu"] as! [NSDictionary])
    
    let actLocation = CLLocationCoordinate2D(
        latitude: x,
        longitude: y)

    
    let vendor = Vendor(id: id, coordinate: actLocation , name: name, menu: menu)
    
    return vendor
    
    
    }
    
    static func arrayFromDic ( dics:[NSDictionary]) -> [Vendor] {
        
       //initialze
        var venArr: [Vendor] = []
        
    
        for i in 0...dics.count-1 {
            let obj = Vendor.fromDic(dic:dics[i])
            //put in array
            venArr.append(obj)
        }
        //returns
        return venArr
    }
    
    
    
    
    

}
