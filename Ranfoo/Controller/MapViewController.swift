//
//  MapViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/28.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MTMapView(frame: self.view.frame)
        mapView.delegate = self
        mapView.baseMapType = .standard
        self.view.addSubview(mapView)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}