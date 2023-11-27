//
//  ViewController.swift
//  PlaceNameToMap
//
//  Created by SomnicsAndrew on 2023/11/27.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    let geocoder = CLGeocoder()
    let address = "Section 4th, Nanjing East Road, Songshan District, Taipei City, Taiwan"//"Taipei arena"

    override func viewDidLoad() {
        super.viewDidLoad()
//        locateAddress()
        searchForPlaceOnMap()
    }

    func locateAddress() {
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let strongSelf = self else { return }

            if let error = error {
                print("Error geocoding address: \(error)")
                return
            }

            if let placemark = placemarks?.first, let location = placemark.location {
                let coordinate = location.coordinate
                strongSelf.setMapRegion(coordinate)
                strongSelf.addPinToMap(coordinate)
            }
        }
    }

    func searchForPlaceOnMap() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Taipei Main Station"
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            guard let self = self else {
                return
            }
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }

            for item in response.mapItems {
                // Process each item, e.g., by adding them to a list or placing pins on a map
                print("test11 item: \(item)")
                let coordinate = item.placemark.coordinate

                self.setMapRegion(coordinate)
                self.addPinToMap(coordinate)
                
                // Assume you want to open the first result in Apple Maps
                let launchOptions1 = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                let launchOptions2 = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsCameraKey]
                let launchOptions3 = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]

                let launchOptions4 = [MKLaunchOptionsMapTypeKey: MKLaunchOptionsMapSpanKey]
                let launchOptions5 = [MKLaunchOptionsMapTypeKey: MKLaunchOptionsMapCenterKey]
                let launchOptions6 = [MKLaunchOptionsMapTypeKey: MKLaunchOptionsCameraKey]

                item.openInMaps(launchOptions: launchOptions4)
            }
        }
    }
    
    func setMapRegion(_ coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }

    func addPinToMap(_ coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Location Title"
        mapView.addAnnotation(annotation)
    }
}
