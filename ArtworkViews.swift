//
//  ArtworkViews.swift
//  Meu primeiro app
//
//  Created by Jonathan on 18/02/20.
//  Copyright © 2020 teste. All rights reserved.
//

import UIKit
import MapKit

class ArtworkViews: MKMarkerAnnotationView {
    
    class ArtworkView: MKAnnotationView {
        override var annotation: MKAnnotation? {
            willSet {
                guard let artwork = newValue as? Artwork else {return}
                canShowCallout = true
                calloutOffset = CGPoint(x: -5, y: 5)
                let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                        size: CGSize(width: 30, height: 30)))
                mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())
                rightCalloutAccessoryView = mapsButton
                
                
                image = UIImage(named: "image")
                
            }
        }
}
}




