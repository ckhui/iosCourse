//
//  ViewController.swift
//  sushiBuffet
//
//  Created by NEXTAcademy on 11/22/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.delegate = self
            mapView.isHidden = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.isEditing = true
        }
    }
    
    @IBOutlet weak var textView: UITextView!{
        didSet{
            textView.isHidden = true
        }
    }
    
    
    let locationManager = CLLocationManager()
    var targetWord : String = "Burgers"
    var targetShop : [Place] = []
    
    var currentLoc : MKPointAnnotation!
    
    var colorSet : [UIColor] = [.black,.red, .blue, .green, .orange, .yellow, .purple, .brown]
    var count = 0
    var saveRoutes : [FullRoute] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        targetWord = "sushi"
        
        start()
    }
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            tableView.isHidden = false
            mapView.isHidden = true
            textView.isHidden = true
            
        case 1,2:
            tableView.isHidden = true
            mapView.isHidden = false
            textView.isHidden = false
            
            textView.text = ""
            saveRoutes = []
            mapView.removeOverlays(mapView.overlays)
            
            switch segmentedControl.selectedSegmentIndex{
            case 1:
                endFetchingData(type: .walking)
            case 2:
                endFetchingData(type: .automobile)
            default:
                break;
            }
            
        default:
            break;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func start(){
        print("Start")
        //locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        //locationManager.startUpdatingLocation()
        
        print("Finding your location .....")
        
        let location = CLLocation(latitude: 48.85815, longitude: 2.29452)
        
        currentLoc = MKPointAnnotation()
        currentLoc.coordinate = location.coordinate
        currentLoc.title = "You are here"
        mapView.addAnnotation(currentLoc)
        
        mapView.setRegion(MKCoordinateRegionMake(currentLoc.coordinate, MKCoordinateSpanMake(0.2,0.2)), animated: true)
        
        self.reverserGeocode(location: location)
        
    }
    
    //1.
    func reverserGeocode(location : CLLocation){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, errors) in
            if let placemarks = placemarks{
                if let placemark = placemarks.first {
                    var address = ""
                    if let thoroughfare = placemark.thoroughfare,
                        let locality = placemark.locality {
                        address = "\(thoroughfare),\(locality)"
                        
                        print("\(address)")
                        
                        self.findShop(location: location)
                    }
                }
            }
            
            DispatchQueue.main.async {
                print("haha")
            }
            
        })
    }
    
    //2.
    func findShop(location : CLLocation){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = targetWord
        request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.5, 0.5))
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: { (response,error) in
            if let response = response{
                //let mapItem = response.mapItems.first
                for mapItem in response.mapItems{
                    print("\(mapItem.name!)")
                    
                    let shop = Place(item: mapItem)
                    
                    self.findRoute(mapItem: mapItem, place: shop, type: .automobile)
                }
                
            }
        })
        
    }
    
    //3.
    func findRoute(mapItem : MKMapItem, place : Place, type : MKDirectionsTransportType){
        let request = MKDirectionsRequest()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = mapItem
        request.transportType = type
        
        let direction = MKDirections(request: request)
        direction.calculate(completionHandler: {(response, error) in
            if let response = response {
                if let route = response.routes.first {
                    
                    //                    if let name = mapItem.name {
                    //                        print("\n Going to \(name)")
                    //                    }
                    //                    for (index,steps) in route.steps.enumerated(){
                    //                        print("\(index+1). \(steps.instructions)")
                    //                    }
                    if type == .automobile{
                        place.automobileRoute = route
                    }
                    else if type == .walking{
                        place.walkingRoute = route
                    }
                }
            }
            
            if type == .automobile{
                self.findRoute(mapItem: mapItem, place: place, type: .walking)
            }
            else if type == .walking{
                self.targetShop.append(place)
                self.tableView.reloadData()
            }
        })
    }
    
    func calculateRoute(source : MKMapItem, destination : MKMapItem, type : MKDirectionsTransportType, destinationName : String, index : Int){
        
        let request = MKDirectionsRequest()
        request.source = source
        request.destination = destination
        request.transportType = type
        
        let direction = MKDirections(request: request)
        direction.calculate(completionHandler: {(response, error) in
            if let response = response {
                if let route = response.routes.first {
                    
                    self.mapView.add(route.polyline, level:.aboveRoads)
                    
                    
                    let str = "to \(destinationName) \(String(format: "%.3f", route.distance / 1000))km in \(Int(route.expectedTravelTime / 60)) min"
                    self.textView.text = "\(self.textView.text!) \n \(str)"
                    
                    
                    let fullRoute = FullRoute()
                    fullRoute.route = route
                    fullRoute.destination = destinationName
                    fullRoute.index = index
                    self.saveRoutes.append(fullRoute)
                    
                }
            }
        })
        
    }
    
    func endFetchingData(type : MKDirectionsTransportType){
        for i in targetShop{
            mapView.addAnnotation(i.annotation)
        }
        let num = min(4,targetShop.count)
        
        if num == 0{
            return
        }
        
        for index in 0...num {
            
            var sourceCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D()
            
            if index == 0{
                sourceCoordinate = currentLoc.coordinate
                
            }else{
                let source = targetShop[index-1]
                sourceCoordinate = source.location.coordinate
            }
            
            let sourceLocation = sourceCoordinate
            
            let destination = targetShop[index]
            let destinationLocation = destination.location.coordinate
            
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
            
            let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
            
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
            
            calculateRoute(source: sourceMapItem, destination: destinationMapItem, type: type, destinationName: destination.name, index: index)
            
            //mapView.add(i.automobileRoute.polyline, level:.aboveRoads)
        }
        
        
        
        
        self.tableView.reloadData()
    }
    
    @IBAction func detailsButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "toDetailsMap", sender: self)
        saveRoutes.sort {$0.index < $1.index }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsMap"{
            let vc = segue.destination as! DetailsMapViewController
            vc.savedRoutes = saveRoutes
            vc.previousCoord = currentLoc.coordinate
        }
    }
    
    
}

extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            print("trying")
            if location.verticalAccuracy < 1000 && location.horizontalAccuracy < 1000 {
                
                locationManager.stopUpdatingLocation()
                print("Found You")
                
                currentLoc = MKPointAnnotation()
                currentLoc.coordinate = location.coordinate
                currentLoc.title = "You are here"
                mapView.addAnnotation(currentLoc)
                
                mapView.setRegion(MKCoordinateRegionMake(currentLoc.coordinate, MKCoordinateSpanMake(0.2,0.2)), animated: true)
                
                self.reverserGeocode(location: location)
            }
        }
    }
    
}


extension ViewController : MKMapViewDelegate{
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
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
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
            mapView.setRegion(MKCoordinateRegionMake((view.annotation?.coordinate)!, MKCoordinateSpanMake(0.01, 0.01)), animated: true)
        }
            
        else{
            if (control == view.rightCalloutAccessoryView) {
                
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        count += 1
        
        let color = colorSet[count%8]
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = color
        renderer.lineWidth = 4.0
        
        return renderer
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = targetShop[sourceIndexPath.row]
        
        targetShop.remove(at: sourceIndexPath.row)
        targetShop.insert(temp, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetShop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else{
                return UITableViewCell()
        }
        
        let temp = targetShop[indexPath.row]
        
        cell.textLabel?.text = temp.name
        cell.detailTextLabel?.text = temp.displayTime()
        
        if indexPath.row < 5{
            cell.backgroundColor = UIColor.green
        }
        else{
            cell.backgroundColor = UIColor.clear
        }
        
        
        return cell
    }
}
