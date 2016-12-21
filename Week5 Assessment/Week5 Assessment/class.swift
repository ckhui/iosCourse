//
//  class.swift
//  Week5 Assessment
//
//  Created by NEXTAcademy on 11/25/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation
import MapKit


class BikeStation {
    var id : Int
    var stationName : String
    var totalDocks : Int
    
    var latitude : Double
    var longitude : Double
//    var statusValue :
//    var statusKey :
    var availableBikes : Int
    var stAddress1 : String
    var stAddress2 : String
//    var statusKey :
    
    var route = MKRoute()
    var annotation : MKPointAnnotation!

    
    init(json : JSON){
        self.id = json["id"].int ?? 0
        self.stationName = json["stationName"].string ?? "No Name"
        
        self.totalDocks = json["totalDocks"].int ?? 0
        
        
        self.latitude = json["latitude"].double ?? 0
        self.longitude = json["longitude"].double ?? 0
        
        self.availableBikes = json["availableBikes"].int ?? 0
        
        self.stAddress1 = json["stAddress1"].string ?? ""
        self.stAddress2 = json["stAddress2"].string ?? ""
        
        annotation = MKPointAnnotation()
        annotation.coordinate = self.coordiate()
        annotation.title = stationName
        annotation.subtitle = "Available Bikes: \(availableBikes)"
        
    }
    
    func coordiate() -> CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
   }
