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
    
    var kindArray = ["한식", "중식", "일식", "양식", "아시아음식", "치킨", "술집"]
    var locationManager = CLLocationManager()
    
    var listManager = ListManager()
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리정확도
        locationManager.requestWhenInUseAuthorization() // 위치 사용 허용 알림
        locationManager.requestLocation() // location을 요청하는 동시에 getList()까지 실행
        
        kindTableView.dataSource = self
        kindTableView.delegate = self
        kindTableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        numberStepper.minimumValue = 1.0
        numberStepper.value = 5.0   // UIStepper 객체를 위에 생성해주어야 시작 값을 설정해줄 수 있다.
        numberStepper.maximumValue = 10.0 // 최대 10개 가게를 표시가능
        
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
        
        // location이 찾아지지 않았을 때 비활성화 되도록 설정하자.
        
    }
    
    
//    var cell = ListCell()
}


//MARK: - UITableViewDatatSource

extension ViewController: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kindArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ListCell
        cell.label.text = kindArray[indexPath.row]
        cell.label.font = UIFont.systemFont(ofSize: 18.0)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(tableView.bounds.size.height) / kindArray.count)
    }
    
}


//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ListCell
        if cell.checkButton.isHidden == false {
            cell.checkButton.isHidden = true
        } else {
            cell.checkButton.isHidden = false
        }
        cell.selectionStyle = .none

//        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}


//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("위치 업데이트!")
            print("위도 : \(lat)")
            print("경도 : \(lon)")
            listManager.fetchList(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}


//MARK: - StoreListView로 가기전 storeArray에 가게 목록을 추가

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.storeListSegueIdentifier {
            print("prepare함수 준비완료")
            let storeListVC = segue.destination as! StoreListViewController
            storeListVC.storeArray.append(contentsOf: ListModel.storeListArray.keys)
        }
    }
    
}



