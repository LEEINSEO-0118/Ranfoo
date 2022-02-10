//
//  ViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/27.
//

import UIKit
import CoreLocation
import NVActivityIndicatorView

//MARK: - ViewController

class ViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var kindTableView: UITableView!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet var randomButton: UIButton!
    
    @IBOutlet var locationLoadingMessage: UILabel!
    let locationIndicator = NVActivityIndicatorView(frame: CGRect(x: 300, y: 700, width: 30, height: 30),
                                                    type: .circleStrokeSpin,
                                                    color: .black,
                                                    padding: 0)
    
    //MARK: - 기본 상수, 변수
    
    let kindArray = ["한식", "중식", "일식", "양식", "분식", "치킨", "아시아음식"]
    var storeArrayNumber = 1...5
    var locationManager = CLLocationManager()
    var lat: CLLocationDegrees = 128.612027
    var lon: CLLocationDegrees = 35.890398
    var listManager = ListManager()
    
    //MARK: - viewDidLoad 및 각종 함수
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
        
        self.view.addSubview(locationIndicator)
        
        randomButton.isEnabled = false
        locationIndicator.startAnimating()
        
        super.viewDidLoad()
        // Do any additiingonal setup after loading the view.
        
        
        let testString = "음식점고기"
        
        if testString.contains("고기") {
            print("contains")
        }
    }

    
    @IBAction func numberStepper(_ sender: UIStepper) {
        numberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        randomButton.isEnabled = false
        locationIndicator.startAnimating()
        locationLoadingMessage.isHidden = false
        locationManager.requestLocation()
    }
    
    @IBAction func randomPressed(_ sender: UIButton) {
        
        self.randomButton.isEnabled = false
        self.locationIndicator.startAnimating()
    
        storeArrayNumber = 1...Int(numberStepper.value)
        ListModel.storeListKeyArray.removeAll()
        ListModel.storeListDictionary.removeAll()
        KindData.kindArray.removeAll()
        
        let cells = kindTableView.visibleCells as! [ListCell]
        for cell in cells {
            if cell.checkButton.isHidden == false {
                KindData.kindArray.append(cell.label.text!)
            }
        }
        print(KindData.kindArray)
        
        let group = DispatchGroup()
        
        for keyword in KindData.kindArray {
            group.enter()
            listManager.getList(lat: lat, lon: lon, keyword: keyword) { result in
               
                switch result {
                case .success(let isTrue):
                    print("\(isTrue)")
                case .failure(let error):
                    print(error)
                }
                
                group.leave()
            }
            
        }
        
        group.notify(queue: .main) {
            print("network done!!")
            
            self.performSegue(withIdentifier: Constants.storeListSegueIdentifier, sender: self)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
//            self.performSegue(withIdentifier: Constants.storeListSegueIdentifier, sender: self)
//        }
        
    }
    
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
        
    }

}


//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            print("위치 업데이트!")
            print("위도 : \(lat)")
            print("경도 : \(lon)")
            locationLoadingMessage.isHidden = true
            locationIndicator.stopAnimating()
            randomButton.isEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}


//MARK: - StoreListView로 가기전 storeArray에 가게 목록을 추가

extension ViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare 진행중")
        if segue.identifier == Constants.storeListSegueIdentifier {
            let storeListVC = segue.destination as! StoreListViewController
            
            print(storeArrayNumber)
            storeListVC.storeArrayNumber = storeArrayNumber
            
            for _ in storeArrayNumber {
                let item = ListModel.storeListKeyArray.randomElement()
                storeListVC.storeArray.append(item ?? "수신된 가게가 없습니다.")
            }
            
            locationIndicator.stopAnimating()
            randomButton.isEnabled = true
        }
        
    }
    
}



