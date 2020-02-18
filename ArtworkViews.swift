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
    
        override var annotation: MKAnnotation? {
            willSet {
                // 1
                guard let artwork = newValue as? Artwork else { return }
                canShowCallout = true
                calloutOffset = CGPoint(x: -5, y: 5)
                let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                        size: CGSize(width: 30, height: 30)))
                mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())
                rightCalloutAccessoryView = mapsButton
                // 2
                markerTintColor = artwork.markerTintColor
                //glyphText = String(artwork.discipline.first!)
                if let imageName = artwork.imageName {
                    glyphImage = UIImage(named: imageName)
                } else {
                    glyphImage = nil
                }
                let detailLabel = UILabel()
                detailLabel.numberOfLines = 0
                detailLabel.font = detailLabel.font.withSize(12)
                detailLabel.text = artwork.subtitle
                detailCalloutAccessoryView = detailLabel
            }
        }
    }


