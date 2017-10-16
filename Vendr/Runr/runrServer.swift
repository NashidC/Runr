//
//  runrServer.swift
//  Runr
//
//  Created by Nashid  on 1/19/17.
//  Copyright © 2017 Vendr. All rights reserved.
//

import UIKit

class runrServer {
    var id:String
//    var name:String
//    var description:String
//    var cuisine:String
//    var location: NSObject
//    var x:NSNumber
//    var y: NSNumber
//    var distance: NSNumber
//    var menu: NSObject
    
    init(id:String){
         
        //name:String, description: String, cuisine:String,location: NSObject, x:NSNumber, y: NSNumber, distance: NSNumber, menu: NSObject ) {
        self.id = id
//        self.name = name
//        self.description = description
//        self.cuisine = cuisine
//        self.location = location
//        self.x = x
//        self.y = y
//        self.distance = distance
//        self.menu = menu
    }
    
    func toJSON() -> String {
        return "{\"id\":\(id)}}"
        
//        ,\"name\":\"\(name)\",\"description\":\"\(description)\",\"cuisine\":\"\(cuisine)\", \"location\":\(location),\"x\":\(x),\"y\":\(y),\"distance\":\(distance),\"menu\":\(menu)
    }
}



