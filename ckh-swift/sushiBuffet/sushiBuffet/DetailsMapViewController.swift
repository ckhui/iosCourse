//
//  DetailsMapViewController.swift
//  sushiBuffet
//
//  Created by NEXTAcademy on 11/23/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailsMapViewController: UIViewController, MKMapViewDelegate {
    
    
    var savedRoutes : [FullRoute] = []
    var currentRoute = FullRoute()
    var saveSteps : [MKRouteStep] = []
    var currentDestination = ""
    
    var camera: MKMapCamera?
    var previousCoord = CLLocationCoordinate2D()
    var previousOverlay = MKPolyline()
    
    var savedDistanceCount = 0.0
    var savedTimeCount = 0.0
    
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var detailMapView: MKMapView!{
        didSet{
            detailMapView.mapType = .satelliteFlyover
            detailMapView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextRoute()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func nextRoute(){
        if savedRoutes.first != nil
        {
            currentRoute = savedRoutes.removeFirst()
            saveSteps = currentRoute.route.steps
            currentDestination = currentRoute.destination
            
            self.title = "Heading to \(currentDestination)"
            detailMapView.removeOverlays(detailMapView.overlays)
        }
        else{
            print("no route found")
            self.title = "End !!!!"
        }
    }
    
    @IBAction func nextPressed(_ sender: AnyObject) {
        
        
        
        
        if saveSteps.first == nil {
            nextRoute()
            return
        }
        
        
        let step = saveSteps.removeFirst()
        
        //savedTimeCount += step.transportType.
        
        savedDistanceCount += step.distance
        
        textLabel.text = step.instructions
        
        let coordinate = step.polyline.coordinate
        
        let distance = step.distance * 5
        let pitch: CGFloat = 40
        let heading = getBearingBetweenTwoPoints1(point1: previousCoord, point2: coordinate)
        
        //camera = MKMapCamera(lookingAtCenter: coordinate, fromEyeCoordinate: previousCoord, eyeAltitude: 20)
        
        camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: distance, pitch: pitch,heading: heading)
        
        detailMapView.setCamera(camera!, animated: true)
        
        //detailMapView.removeOverlays(detailMapView.overlays)
        
        detailMapView.add(step.polyline, level: .aboveRoads)
        detailMapView.add(previousOverlay, level: .aboveRoads)
        
        previousCoord = coordinate
        previousOverlay = step.polyline
        previousOverlay.title = "previous"
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        var color = UIColor.blue
        
        if let title = overlay.title {
            if title == "previous"{
                color = UIColor.red
            }
        }
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = color
        renderer.lineWidth = 4.0
        
        return renderer
        
        
    }
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * M_PI / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / M_PI }
    
    func getBearingBetweenTwoPoints1(point1 : CLLocationCoordinate2D, point2 : CLLocationCoordinate2D) -> Double {
        
        let lat1 = degreesToRadians(degrees: point1.latitude)
        let lon1 = degreesToRadians(degrees: point1.longitude)
        
        let lat2 = degreesToRadians(degrees: point2.latitude)
        let lon2 = degreesToRadians(degrees: point2.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        return radiansToDegrees(radians: radiansBearing)
    }
    
}
