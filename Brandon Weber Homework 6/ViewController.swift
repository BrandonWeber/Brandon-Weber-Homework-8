//
//  ViewController.swift
//  Brandon Weber Homework 6
//
//  Created by Brandon Weber on 4/11/23.
//

import UIKit
import CoreLocation
import WebKit
import MessageUI

class DistanceViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var distanceLabel: UILabel!
  
    @IBOutlet weak var webView: WKWebView!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    // wfc = wells fargo center
    let wfcLatitude: CLLocationDegrees = 39.901333
    let wfcLongitude: CLLocationDegrees = -75.172592
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let newLocation: CLLocation=locations[0]
        
        if newLocation.horizontalAccuracy >= 0 {
            let wfc:CLLocation = CLLocation(latitude: wfcLatitude, longitude: wfcLongitude)
            let change: CLLocationDistance = wfc.distance(from: newLocation)
            let miles: Double = (change * 0.0000621371) + 0.5
            if miles < 3 {
                locationManager.stopUpdatingLocation()
                distanceLabel.text = "You Have Arrived!"
            }else {
                let commaFormat: NumberFormatter = NumberFormatter()
                commaFormat.numberStyle = NumberFormatter.Style.decimal
                distanceLabel.text = commaFormat.string(from: NSNumber(value: miles))!+" Miles to the Wells Fargo Center"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.distanceFilter = 1609;
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
        
        
        
    }
    
}
//Program 8 code
    	
    
    
class sendSMS: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    
    }
    

    
    @IBAction func message(_ sender: Any) {
        
    let SMS = MFMessageComposeViewController()
        SMS.messageComposeDelegate = self
        
        SMS.recipients = ["4846440238"]
        SMS.body = "Have a great day!"
        
        if MFMessageComposeViewController.canSendText() {
            self.present(SMS, animated:true, completion:nil)
        }else{
            print("Cant send messages.")
        }
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        let myURL = URL(string:"https://www.wellsfargocenterphilly.com/")
        let request = URLRequest(url: myURL!)
        webView.load(request)
        
    }
        
        
    }
    
    
    
    
    
    
    
    


