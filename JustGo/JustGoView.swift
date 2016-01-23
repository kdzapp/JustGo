//
//  JustGoView.swift
//  JustGo
//
//  Created by Kyle Zappitell on 1/21/16.
//  Copyright © 2016 Kyle Zappitell. All rights reserved.
//

import UIKit
import UberRides
import CoreLocation
import MapKit

class JustGoView: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{

    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var tripMap: MKMapView!
    @IBOutlet weak var planeCircle: UIImageView!
    @IBOutlet weak var uberButton: RequestButton!
    var locationManager: CLLocationManager!
    var localBool: Bool = true
    var coords = CLLocationCoordinate2D(latitude: 40.7127, longitude: 74.0059)
    var address: [String: AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getLocation()
        let gotoLocation: CLLocationCoordinate2D = createLocation()

        if(localBool)
        {
            planeCircle.alpha = 0
            calculateUberCost(convertLocation(gotoLocation))
        }
        else
        {
            disableUber()
            planeCircle.alpha = 0.75
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomAnnotation") as MKAnnotationView!
        
        annotationView.annotation = annotation;
        
        return annotationView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func disableUber()
    {
        uberButton.enabled = false;
        uberButton.alpha = 0;
    }
    
    func getLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled()
        {
            tripMap.showsUserLocation = true;
            let span = MKCoordinateSpanMake(0.3, 0.3)
            let region = MKCoordinateRegion(center: (locationManager.location?.coordinate)!, span: span)
            tripMap.setRegion(region, animated: true)
        }
        else
        {
            print("Location Not Active")
        }
    }
    
    func getDirections(goto: CLLocationCoordinate2D, locationName: [String: AnyObject]?)
    {
        let destinationConversion = MKPlacemark(coordinate: goto, addressDictionary: locationName)
        let destination = MKMapItem(placemark: destinationConversion)
        let request = MKDirectionsRequest()
        request.transportType = MKDirectionsTransportType.Automobile
        request.destination = destination
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler({
            (response: MKDirectionsResponse?, error: NSError?) in
            if((error) != nil)
            {
                print(error)
            }
            else
            {
                print(response)
            }
        })
    }
    
    func createLocation() -> CLLocationCoordinate2D
    {

        if(localBool)
        {
            var lat: Double
            var long: Double
            let addition = Int(arc4random_uniform(1))
        
            print(addition)
            if(addition == 1)
            {
                lat = (locationManager.location?.coordinate.latitude)! + Double(arc4random_uniform(20))*0.01
                long = (locationManager.location?.coordinate.longitude)! + Double(arc4random_uniform(20))*0.01
            }
            else
            {
                lat = (locationManager.location?.coordinate.latitude)! - Double(arc4random_uniform(20))*0.01
                long = (locationManager.location?.coordinate.longitude)! - Double(arc4random_uniform(20))*0.01
            }
            let gotoLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = gotoLocation
            tripMap.addAnnotation(dropPin)
        
            return gotoLocation
        }
        else
        {
            //Generate Random City/Place to Travel to
            //travelMethod(currentLocation, randomCity, false)
            
            let testLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)
            
            return testLocation
        }
    }
    
    func convertLocation(location: CLLocationCoordinate2D) -> CLLocation
    {
        let lat: CLLocationDegrees = location.latitude
        let long: CLLocationDegrees = location.longitude
        
        let newCLLocation: CLLocation = CLLocation(latitude: lat, longitude: long)
        return newCLLocation
    }
    
    func calculateUberCost(gotoLocation: CLLocation)
    {
        let distance: CLLocationDistance = (locationManager.location?.distanceFromLocation(gotoLocation))!
        let currentLat = String(locationManager.location?.coordinate.latitude)
        let currentLong = String(locationManager.location?.coordinate.longitude)
        let gotoLat = String(gotoLocation.coordinate.latitude)
        let gotoLong = String(gotoLocation.coordinate.longitude)
        
        uberButton.setProductID("RandomLocationGenerator")
        uberButton.setPickupLocation(latitude: currentLat, longitude: currentLong, nickname: "Your Current Location")
        uberButton.setDropoffLocation(latitude: gotoLat, longitude: gotoLong, nickname: "Random Place to Go")
        
        if(distance > 16093) //Is Greater than 10 miles
        {
            costLabel.text = "~$11"
        }
        else if(distance > 11265) //Is Greater than 7 miles
        {
            costLabel.text = "~$8"
        }
        else if(distance > 6437) //Is Greater than 4 miles
        {
            costLabel.text = "~$6"
        }
        else
        {
            costLabel.text = "~$4"
        }
    }
    
    func setAddress()
    {
//        address = [
//        "kABPersonAddressStreetKey": location,
//        "kABPersonAddressCityKey": location,
//        "kABPersonAddressStateKey": location,
//        "kABPersonAddressZIPKey": location,
//        "kABPersonAddressCountryKey": location,
//        "kABPersonAddressCountryCodeKey": location]
    }
}

func createActivity(location: Bool) -> Void
{
    //Create a list of activites?
    //Average Cost? NSDictionary?
    //get location of activity
    //return location of activity
}

func getAirFare(location: String) -> Int
{
    //This is for SkyScanner.... getFare for a specified location
    return 0
}

func getUberFare(currentLocation: String, gotoLocation: String)
{
   // button.setProductID("abc123-productID")
   // button.setPickupLocation(latitude: "37.770", longitude: "-122.466", nickname: "California Academy of Sciences")
   // button.setDropoffLocation(latitude: "37.791", longitude: "-122.405", nickname: "Pier 39")
}









