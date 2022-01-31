//
//  ViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/27.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var kindTableView: UITableView!
    @IBOutlet weak var numberStepper: UIStepper!
    
    var kindArray = ["한식", "양식", "중식", "일식", "치킨", "기타"]
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        kindTableView.dataSource = self
        kindTableView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리정확도
        locationManager.requestWhenInUseAuthorization() // 위치 사용 허용 알림
        locationManager.requestLocation()
        
        numberStepper.value = 5.0   // UIStepper 객체를 위에 생성해주어야 시작 값을 설정해줄 수 있다.
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func numberStepper(_ sender: UIStepper) {
        numberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func randomPressed(_ sender: UIButton) {
        
//        sender.alpha = 0.5 // button이 누르고 때면 alpha값을 바꿔준다... 이게 아닌데
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            sender.alpha = 1.0
//        } // 0.2초의 딜레이 이후에 alpha값이 1.0으로 돌아온다.
        
    }
    
    
    
}


//MARK: - UITableViewDatatSource

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kindArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kindCell", for: indexPath)
        cell.textLabel?.text = kindArray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(tableView.bounds.size.height) / kindArray.count)
    }
    
}


//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


//MARK: -CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            print("위치 업데이트!")
            print("위도 : \(location.coordinate.latitude)")
            print("경도 : \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}


