//
//  ViewController.swift
//  Runr
//
//  Created by Nashid  on 1/14/17.
//  Copyright © 2017 Vendr. All rights reserved.
//

import UIKit
import MapKit
import AFNetworking

class ViewController: UIViewController, MKMapViewDelegate {

   @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mapView.delegate = self;
        
        let location = CLLocationCoordinate2D(
            latitude: 40.8199,
            longitude: -73.9506)
        
        let locationManager = CLLocationManager()
        
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            mapView.showsPointsOfInterest = true

        }
        //let userLocation = mapView.userLocation

        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
        //calls api method to retrieve vendors at specified lat and lon
        VendorIDClient.loadVendors(lat:40, lon:-73, refreshControl:  nil,
            //handler aka callback. this function is called when the vendors are retrieved. 
            //The retrieved vendors are passed as a parameter
               handler: {(vendors) in
                //executes code in the loop for every vendor
                for vendor in vendors{
                    //adds vendor (which extends MapAnnotation) to the map
                    self.mapView.addAnnotation(vendor)
                                  }
            }
        )
        
        VendorIDClient.loadVendorMenu(itemId: "8b0b3ae0-3080-44b4-ba01-6e18832030fb", handler: {(menu) in
            
        
        })

    }

    //called when a pin is touched
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //starts segue with identifier 'menusegue' (defined in main.storyboard)
        performSegue(withIdentifier: "menusegue", sender: view.annotation)
        
    }
    
    
  /*  func mapView(mapView: MKMapView!, annotationView: MKAnnotationView!,
                 calloutAccessoryControlTapped control: UIControl!) {
        let location = annotationView.annotation as! Vendor
        let butt = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = butt
        
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //called whenever a segue starts
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if the segue has the identifier "menusegue"
        if(segue.identifier == "menusegue"){
            //cast segue destination to MenuViewController and set its vendor to the sender (which is a Vendor object)
            (segue.destination as! MenuViewController).setVendor(vendor: sender as! Vendor)
        }
    }


}

