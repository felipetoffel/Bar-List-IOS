//
//  MapViewController.swift
//  Meu primeiro app
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 teste. All rights reserved.
//

import UIKit
import MapKit
import Contacts


class MapViewController: UIViewController {
    
    var artworks: [Artwork] = []
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.register(ArtworkMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadInitialData()
        //define; a localização inicial em Honolulu
       let initialLocation = CLLocation (latitude:  -26.8918542 , longitude: -49.0655956 )
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        
        mapView.addAnnotations(artworks)
        let bar1 = Artwork (title: "Moitilas Bar",
                            locationName: "Rua Santa Quitéria",
                            discipline: "Bar" ,
                            coordinate: CLLocationCoordinate2D(latitude: -26.8918542, longitude: -49.0655956))
        
        let bar2 = Artwork (title:"Dogão Lanches",
                              locationName:" Rua Paris",                              discipline:"Lanchonete",coordinate:CLLocationCoordinate2D(latitude: -26.8861998,longitude:-490820582))
        
        let bar3 = Artwork (title:"Mega Batata",
                              locationName:" Rua General Osório",                              discipline:"Lanchonete",coordinate:CLLocationCoordinate2D(latitude: -26.9057364,longitude:-49.1316242))
        
        artworks += [bar1,bar2,bar3]
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    
    }
    func loadInitialData() {
        // 1
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            // 2
            let json = try? JSONSerialization.jsonObject(with: data),
            // 3
            let dictionary = json as? [String: Any],
            // 4
            let works = dictionary["data"] as? [[Any]]
            else { return }
        // 5
        let validWorks = works.compactMap { Artwork(json: $0) }
        artworks.append(contentsOf: validWorks)
    }
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
}

extension MapViewController: MKMapViewDelegate{
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    /*func loadBares() {
        let bares = NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
        
        for bar in bares! {
            // exibie a class Atwork no mapa
            
            mapView.addAnnotation(bar)
            
            // Do any additional setup after loading the view.
            
        }
    }*/
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
