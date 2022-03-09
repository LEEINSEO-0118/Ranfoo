//
//  MainViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/02/21.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet var usingManualBubble: UIView!
    @IBOutlet var collectionViewEx: UIView!    
    @IBOutlet var findButtonEx: UIView!
    @IBOutlet var kindViewButton: UIButton!
    
    //MARK: - 각종 상수 변수
    
    var locationManager = CLLocationManager()
 
    let kindVC = KindViewController()
    
    var lat = CLLocationDegrees()
    var lon = CLLocationDegrees()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        
        setObejctFrame()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리정확도
        locationManager.requestWhenInUseAuthorization() // 위치 사용 허용 알림
        locationManager.requestLocation() // location을 요청
       
    }
    
    //MARK: - viewWillDisappear
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    //MARK: - button
    
    @IBAction func kindViewButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.kindViewSegueIdentifier, sender: self)
        self.kindViewButton.layer.opacity = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.kindViewButton.layer.opacity = 1.0
          }
        
    }

}

//MARK: - setObjectFrame method

extension MainViewController {
    
    func setObejctFrame() {
        usingManualBubble.layer.cornerRadius = 20
        usingManualBubble.layer.borderWidth = 1
        usingManualBubble.layer.borderColor = UIColor.gray.cgColor
        
//        usingManualBubble.layer.shadowColor = UIColor.black.cgColor
//        usingManualBubble.layer.shadowOpacity = 0.3
//        usingManualBubble.layer.shadowRadius = 3
//        usingManualBubble.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        kindViewButton.layer.cornerRadius = 13
        kindViewButton.layer.borderWidth = 2
        kindViewButton.layer.borderColor = UIColor(named: Constants.thirdColor)?.cgColor
        
        kindViewButton.translatesAutoresizingMaskIntoConstraints = false
        kindViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionViewEx.layer.cornerRadius = 15
        
        findButtonEx.layer.cornerRadius = 10
    }
    
}

//MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            print("✅ 위도: \(lat)")
            print("✅ 경도: \(lon)")
            
            LocationData.lat = lat   // 다음 페이지로 넘어가야 notificaiton center를 통해 값이 옮겨 가는데, 넘어가기 전에 찾기가 완료되면 바로 그 값을 바꾸어 주어야 다음 페이지로 넘어가서 무한 로딩에 빠지지 않는다.
            LocationData.lon = lon
    
            NotificationCenter.default.post(name: Notification.Name("getLat"), object: lat)
            NotificationCenter.default.post(name: NSNotification.Name("getLon"), object: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❗error")
    }
    
}


