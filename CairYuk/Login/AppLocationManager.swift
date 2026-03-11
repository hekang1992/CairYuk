//
//  AppLocationManager.swift
//  CairYuk
//
//  Created by hekang on 2026/3/11.
//

import Foundation
import CoreLocation

typealias LocationResultBlock = ((_ result:[String:Any], _ error:Error?) -> Void)

class AppLocationManager: NSObject {

    private var locationManager = CLLocationManager()
    private var resultBlock: LocationResultBlock?
    private let geocoder = CLGeocoder()

    private let alertKey = "LocationPermissionAlertDate"

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func startLocation(_ block:@escaping LocationResultBlock) {

        self.resultBlock = block

        let status = CLLocationManager().authorizationStatus

        switch status {

        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()

        case .restricted, .denied:
            block([:],nil)

        @unknown default:
            break
        }
    }

    func shouldShowLocationAlert() -> Bool {

        let status = CLLocationManager().authorizationStatus

        guard status == .denied else { return false }

        let today = todayString()

        let last = UserDefaults.standard.string(forKey: alertKey)

        if last == today {
            return false
        }

        UserDefaults.standard.set(today, forKey: alertKey)

        return true
    }

    private func todayString() -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.string(from: Date())
    }
}

extension AppLocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        let status = manager.authorizationStatus

        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }
        
        let latNumber = String(location.coordinate.latitude)
        let longNumber = String(location.coordinate.longitude)
        
        UserDefaults.standard.set(latNumber, forKey: "latNumber")
        UserDefaults.standard.set(longNumber, forKey: "longNumber")
        
        manager.stopUpdatingLocation()

        geocoder.reverseGeocodeLocation(location) { [weak self] places, error in

            guard let self = self else { return }

            if let place = places?.first {

                let dic:[String:Any] = [

                    "my":"",

                    "physicalial":place.isoCountryCode ?? "",

                    "arriveaire":place.country ?? "",

                    "quaternity":place.name ?? "",

                    "startel":location.coordinate.latitude,

                    "pod":location.coordinate.longitude,

                    "legiatic":place.locality ?? "",

                    "ord":place.subLocality ?? place.administrativeArea ?? ""
                ]

                self.resultBlock?(dic,nil)

            } else {

                self.resultBlock?([:],error)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        resultBlock?([:],error)
    }
}
