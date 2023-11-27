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
        locateAddress()
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
