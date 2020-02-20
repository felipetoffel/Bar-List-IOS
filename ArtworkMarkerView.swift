//
//  ArtworkMarkerView.swift
//  Meu primeiro app
//
//  Created by Jonathan on 20/02/20.
//  Copyright © 2020 teste. All rights reserved.
//

import UIKit
import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            image = UIImage(named: "image")
        }
    }
}
