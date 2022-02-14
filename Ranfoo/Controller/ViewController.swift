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
    @IBOutlet var kindCollection: UICollectionView!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet var randomButton: UIButton!    
    @IBOutlet var locationLoadingMessage: UILabel!
    let locationIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                                    type: .circleStrokeSpin,
                                                    color: .black,
                                                    padding: 0)
    
    //MARK: - 기본 상수, 변수
    
    let kindArray = ["한식", "중식", "일식", "양식", "분식", "치킨", "아시아음식", "패스트푸드"]
    var storeArrayNumber = 1...5
    var locationManager = CLLocationManager()
    var lat: CLLocationDegrees = 128.612027
    var lon: CLLocationDegrees = 35.890398
    var listManager = ListManager()
    
    
    //MARK: - viewDidLoad 및 각종 함수
    
    override func viewDidLoad() {
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리정확도
        locationManager.requestWhenInUseAuthorization() // 위치 사용 허용 알림
        locationManager.requestLocation() // location을 요청하는 동시에 getList()까지 실행
        
        let layout = UICollectionViewFlowLayout()
        kindCollection.collectionViewLayout = layout
        kindCollection.allowsMultipleSelection = true
        kindCollection.dataSource = self
        kindCollection.delegate = self
        kindCollection.register(UINib(nibName: "KindCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.collectionCellIdentifier)
        
        
        numberStepper.minimumValue = 1.0
        numberStepper.value = 5.0   // UIStepper 객체를 위에 생성해주어야 시작 값을 설정해줄 수 있다.
        numberStepper.maximumValue = 10.0 // 최대 10개 가게를 표시가능
        
        locationIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(locationIndicator)
        locationIndicator.centerXAnchor.constraint(equalTo: self.randomButton.centerXAnchor).isActive = true
        locationIndicator.centerYAnchor.constraint(equalTo: self.randomButton.centerYAnchor).isActive = true
        locationIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        locationIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
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
        
        let cells = kindCollection.visibleCells as! [KindCollectionCell]
        for cell in cells {
            if cell.isSelected == false {
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
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kindArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellIdentifier, for: indexPath) as! KindCollectionCell
        
        cell.label.text = kindArray[indexPath.row]
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! KindCollectionCell
//    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2 - 10 // 2등분하여 배치, 옆 간격 빼줌
        let height = collectionView.frame.height / 4 - 5
        return CGSize(width: width, height: height)
    }
    
}


////MARK: - UITableViewDelegate
//
//extension ViewController: UITableViewDelegate {
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let cell = tableView.cellForRow(at: indexPath) as! ListCell
//        if cell.checkButton.isHidden == false {
//            cell.checkButton.isHidden = true
//        } else {
//            cell.checkButton.isHidden = false
//        }
//
//        cell.selectionStyle = .none
//
//    }
//
//}


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



