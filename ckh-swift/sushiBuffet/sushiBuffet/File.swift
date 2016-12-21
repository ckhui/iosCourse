//
//  File.swift
//  sushiBuffet
//
//  Created by NEXTAcademy on 11/22/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Place{
    var name : String = ""
    var address : String = ""
    var automobileRoute : MKRoute = MKRoute()
    var walkingRoute : MKRoute = MKRoute()

    var location : CLLocation = CLLocation()
    
    var annotation : MKPointAnnotation!
    
    init(item : MKMapItem) {
        location = item.placemark.location!
        name = item.name!
        address = item.placemark.title!
        
        
        annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = name
        annotation.subtitle = address
    }
    
    
    func displayTime() -> String{
        let carDist = String(format: "%.3f", automobileRoute.distance / 1000)
        let carTime = Int(automobileRoute.expectedTravelTime / 60)
        let walkDist = String(format: "%.3f", walkingRoute.distance / 1000)
        let walkTime = Int(walkingRoute.expectedTravelTime / 60)
        
        let str = "Walk: \(walkDist)km in \(walkTime)min , Car: \(carDist)km in \(carTime)min"
        return str
    }
    
}


class FullRoute {
    var route = MKRoute()
    var destination = ""
    var index = 0
}
