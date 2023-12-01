//
//  LandmarkAnnotation.swift
//  Hunger
//
//  Created by Sofia Abd Alwaheb on 2022-12-15.
//

import Foundation
import UIKit
import MapKit

final class LandmarkAnnotation: NSObject, MKAnnotation{
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}
