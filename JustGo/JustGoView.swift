//
//  JustGoView.swift
//  JustGo
//
//  Created by Kyle Zappitell on 1/21/16.
//  Copyright © 2016 Kyle Zappitell. All rights reserved.
//

import UIKit

class JustGoView: UIViewController {
    
    var localBool = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

func createActivity(location: Bool) -> Void
{
    //Create a list of activites?
    //Average Cost? NSDictionary?
    //get location of activity
    //return location of activity
}

func createLocation(local: Bool) -> Void
{
    //getCurrentLocation
    if(local)
    {
        //travelMethod(currentLocation, xActivityLocation, true)
        //xActivityLocation = currentLocation
    }
    else
    {
        //Generate Random City/Place to Travel to
        //travelMethod(currentLocation, randomCity, false)
    }
}

func travelMethod(currentLocation: String, gotoLocation: String, local: Bool) -> Void
{
    if(local)
    {
        //let activityLocation = getActivity(gotoLocation) -> Return CLLocation..
        //uberApiFunction(currentLocation, activityLocation);
        //Yes, you won't be able to use strings... you must use Location objects
    }
    else
    {
        //SkyScanner HTTP Request for location provided...
        //getFare(location)
        //Set Fare in JustGoView and Symbol (Circle around a Plane)
    }
}

func createDirections(location: String)
{
    //Create directions on the map to the location... 
    //if posisble pass through 'type' (plane or car) and specify on map
}

func getAirFare(location: String) -> Int
{
    //This is for SkyScanner.... getFare for a specified location
    return 0
}

func getUberFare(currentLocation: String, gotoLocation: String)
{
    //User UberAPI to get cost of travel from currentLocation to gotoLocation
}









