//
//  ViewController.swift
//  Week5 Assessment
//
//  Created by NEXTAcademy on 11/25/16.
//  Copyright © 2016 ckhui. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let locationManager = CLLocationManager()
    var currentLocAnno : MKPointAnnotation!
    var stations : [BikeStation] = []
    var allStations : [BikeStation] = []
    var savedIndex = -1
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.definesPresentationContext = true
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        stations.sort { $0.route.distance < $1.route.distance }
        tableView.reloadData()

    }
    
    func fetchData(){
        let url = "https://feeds.citibikenyc.com/stations/stations.json"
        Alamofire.request(url).responseJSON(completionHandler: {(response) in
            switch response.result {
            case .success(let responseValue):
                let json = JSON(responseValue)
                for (key,subJson) : (String ,JSON) in json{
                    if key == "stationBeanList"{
                        for (_,subsubJson) : (String ,JSON) in subJson{
                            let temp = BikeStation(json: subsubJson)

                            self.getRoute(sourceLocation: self.currentLocAnno.coordinate, station: temp)
                            
                        }
                        
                    }
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        })

    }
    
    func getRoute(sourceLocation : CLLocationCoordinate2D ,station : BikeStation){
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        

        let destinationPlacemark = MKPlacemark(coordinate: station.coordiate(), addressDictionary: nil)
        
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let request = MKDirectionsRequest()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.transportType = .walking
        
        let direction = MKDirections(request: request)
        direction.calculate(completionHandler: {(response, error) in
            if let response = response {
                if let route = response.routes.first {
                    station.route = route
                    self.stations.append(station)
                }
            }
            self.stations.sort { $0.route.distance < $1.route.distance }
            self.allStations = self.stations
            self.tableView.reloadData()
        })
        
        
    }
    
    func filterContentForSearchText(searchText: String)
    {
        
        stations = []
        
        if searchText == ""{
            stations = allStations
        }
        else{
            stations = allStations.filter { temp in
                return (temp.stationName.lowercased().contains(searchText.lowercased()))
            }
        }
        
        tableView.reloadData()

    }
    
    
    @IBAction func mapButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "showMap", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap"{
            let vc = segue.destination as! MapViewViewController
            vc.stations = allStations
            vc.currentLocAnno = currentLocAnno
        }
        else if segue.identifier == "showRoute"{
            let vc = segue.destination as! MapViewViewController
            vc.stations = allStations
            vc.currentLocAnno = currentLocAnno
            vc.showPathIndex = savedIndex
        }
        
        
    }
    

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return stations.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else{
                return UITableViewCell()
        }
        
        let temp = stations[indexPath.row]

        cell.textLabel?.text = temp.stationName
        let dist = String(format: "%0.3f", temp.route.distance/1000)
        cell.detailTextLabel?.text = "# Bike: \(temp.availableBikes) \t\t Distance: \(dist)km"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        let selectedName = stations[indexPath.row].stationName
        let indexes = allStations.index(where: {$0.stationName == selectedName})
        
        savedIndex = indexes!
        performSegue(withIdentifier: "showRoute", sender: self)
            
        
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
                
                currentLocAnno = MKPointAnnotation()
                currentLocAnno.coordinate = location.coordinate
                currentLocAnno.title = "You are here"
                //mapView.addAnnotation(currentLocAnno)
                
                //mapView.setRegion(MKCoordinateRegionMake(currentLoc.coordinate, MKCoordinateSpanMake(0.2,0.2)), animated: true)
                
                self.fetchData()
            }
        }
    }
    
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar)
    {
        filterContentForSearchText(searchText: searchBar.text!)
    }
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
