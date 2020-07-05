import Foundation
import Combine
import CoreLocation
import SwiftUI

class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationAuthorized: Bool = false
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    
    private let locationManager = CLLocationManager()
    
    override init()
    {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.latitude  = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status
        {
        case .authorizedWhenInUse, .authorizedAlways:
            if !locationAuthorized { locationAuthorized = true }
        default:
            if locationAuthorized { locationAuthorized = false }
        }
    }
    
    func getDistanceToUser(lat: Double, lon: Double) -> Double {
        let p1 = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let p2 = CLLocation(latitude: lat, longitude: lon)
        
        return p1.distance(from: p2)
    }
}
