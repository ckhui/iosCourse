//
//  MapViewViewController.swift
//  Week5 Assessment
//
//  Created by NEXTAcademy on 11/25/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import MapKit

class MapViewViewController: UIViewController {

    var stations : [BikeStation] = []
    var currentLocAnno : MKPointAnnotation!
    var showPathIndex : Int?
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setRegion(MKCoordinateRegionMake(currentLocAnno.coordinate, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
        
        mapView.addAnnotation(currentLocAnno)
        for station in stations {
            mapView.addAnnotation(station.annotation)
        }
        
        if let i = showPathIndex{
            let station = stations[i]
            mapView.add(station.route.polyline , level: .aboveRoads)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MapViewViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.title! == "You are here"
        {
            let identifier = "Home"
            var annotationView : MKAnnotationView?
            
            if let dequeueAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
                annotationView = dequeueAnnotationView
                annotationView?.annotation = annotation
                
            }else{
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            
            if let annotationView = annotationView {
                annotationView.image = #imageLiteral(resourceName: "youarehere")
                annotationView.layer.frame.size = CGSize(width: 40, height: 60)
                annotationView.canShowCallout = true
            }
            
            return annotationView
        }
        else{
            var annotationView : MKPinAnnotationView?
            let identifier = "PinPoint"
            
            if let dequeueAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                annotationView = dequeueAnnotationView
                annotationView?.annotation = annotation
                
            }else{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                
            }
            
            if let annotationView = annotationView {
                annotationView.pinTintColor = UIColor.brown
                annotationView.canShowCallout = true
            }
            
            return annotationView
        }
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let name = (view.annotation?.title!)!
        if name == "You are here" {
            mapView.setRegion(MKCoordinateRegionMake((view.annotation?.coordinate)!, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
        }
            
        else{
            if (control == view.rightCalloutAccessoryView) {
                
                mapView.removeOverlays(mapView.overlays)
                //showRoute
                for station in stations{
                    if station.annotation.title == (view.annotation?.title)!{
                        mapView.add(station.route.polyline, level: .aboveRoads)
                        
                    }
                }
                
            }
        }
        
    }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let color = UIColor.red
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = color
            renderer.lineWidth = 2.0
            
            return renderer
        }


    
}
