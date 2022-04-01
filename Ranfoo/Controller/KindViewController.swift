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

class KindViewController: UIViewController {
    
    //MARK: - Outlet
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet var kindCollection: UICollectionView!
    @IBOutlet weak var numberStepper: UIStepper!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var locationLoadingMessage: UILabel!
    @IBOutlet var randomButtonBubble: UIView!
    
    let locationIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                                    type: .circleStrokeSpin,
                                                    color: .gray,
                                                    padding: 0) 
    
    //MARK: - 기본 상수, 변수
    
    let kindArray = ["한식", "중식", "일식", "양식", "분식", "치킨", "아시아음식", "패스트푸드"]
    var storeArrayNumber = 1...5
    var locationManager = CLLocationManager()
    var listManager = ListManager()
    
    
    //MARK: - viewDidLoad 및 각종 함수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getLat(_:)), name: Notification.Name("getLat"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getLon(_:)), name: Notification.Name("getLon"), object: nil)
        
        if LocationData.lat == 0.0 {    // 이미 값을 받은 후 다시 첫번째 VC를 갔다가 돌아오면 무한 로딩에 빠지는 오류... // LocationData라는 model을 만들어서 문제를 해결.
            randomButton.isEnabled = false
            locationIndicator.startAnimating()
        } else {
            locationLoadingMessage.isHidden = true
            locationIndicator.stopAnimating()
            randomButton.isEnabled = true
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 거리정확도
        locationManager.requestWhenInUseAuthorization() // 위치 사용 허용 알림
        
        let layout = UICollectionViewFlowLayout()
        kindCollection.collectionViewLayout = layout
        kindCollection.allowsMultipleSelection = true
        kindCollection.dataSource = self
        kindCollection.delegate = self
        kindCollection.register(UINib(nibName: "KindCollectionCell", bundle: nil), forCellWithReuseIdentifier: Constants.collectionCellIdentifier)
                        
        numberStepper.minimumValue = 1.0
        numberStepper.value = 4.0   // UIStepper 객체를 위에 생성해주어야 시작 값을 설정해줄 수 있다.
        numberStepper.maximumValue = 10.0 // 최대 10개 가게를 표시가능
        
        setObject()
        
    }
    
    //MARK: - notification selector method
    
    @objc func getLat(_ notification: Notification){
        let getLat = notification.object as! CLLocationDegrees
        print("✅ notification 통한 위도: \(getLat)")
        LocationData.lat = getLat
        locationLoadingMessage.isHidden = true
        locationIndicator.stopAnimating()
        randomButton.isEnabled = true
    }
    
    @objc func getLon(_ notification: Notification){
        let getLon = notification.object as! CLLocationDegrees
        print("✅ notification 통한 경도: \(getLon)")
        LocationData.lon = getLon
    }
    
//MARK: - stepper and locationPressed method
    
    @IBAction func numberStepper(_ sender: UIStepper) {
        numberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        randomButton.isEnabled = false
        locationIndicator.startAnimating()
        locationLoadingMessage.isHidden = false
        locationManager.requestLocation()
        
        self.locationButton.layer.opacity = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.locationButton.layer.opacity = 1.0
        }
        
    }
    
    //MARK: - Random method
    
    @IBAction func randomPressed(_ sender: UIButton) {
        
        self.randomButtonBubble.layer.opacity = 0.5
        self.randomButton.layer.opacity = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.randomButtonBubble.layer.opacity = 1.0
            self.randomButton.layer.opacity = 1.0
          }
        
        
        self.randomButton.isEnabled = false
        self.locationIndicator.startAnimating()
    
        storeArrayNumber = 1...Int(numberStepper.value)
        ListModel.storeListKeyArray.removeAll()
        ListModel.storeUrlDict.removeAll()
        KindData.kindArray.removeAll()
        
        let cells = kindCollection.visibleCells as! [KindCollectionCell]
        for cell in cells {
            if cell.isSelected == true {
                KindData.kindArray.append(cell.label.text!)
            }
        }
        
        print(KindData.kindArray)
        
        let group = DispatchGroup()
        
        for keyword in KindData.kindArray {
            group.enter()
            listManager.getList(lat: LocationData.lat, lon: LocationData.lon, keyword: keyword) { result in
               
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

extension KindViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kindArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellIdentifier, for: indexPath) as! KindCollectionCell
        
        cell.label.text = kindArray[indexPath.row]
        guard let kind = cell.label.text else {fatalError()}
        cell.kindImage.image = UIImage(named: Constants.kindIcon[kind] ?? Constants.kindIconDefault)
        cell.checkButton.isHidden = true
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate

extension KindViewController: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension KindViewController: UICollectionViewDelegateFlowLayout {
    
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
//        let height = 527 / 4 - 5
        return CGSize(width: width, height: height)
    }
    
}


//MARK: - CLLocationManagerDelegate

extension KindViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            LocationData.lat = location.coordinate.latitude
            LocationData.lon = location.coordinate.longitude
            print("위치 업데이트!")
            print("위도 : \(LocationData.lat)")
            print("경도 : \(LocationData.lon)")
            locationLoadingMessage.isHidden = true
            locationIndicator.stopAnimating()
            randomButton.isEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
}


//MARK: - Prepare를 통해 StoreListView로 가기전 storeArray에 가게 목록을 추가

extension KindViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare 진행중")
        if segue.identifier == Constants.storeListSegueIdentifier {
            let storeListVC = segue.destination as! StoreListViewController            
            print(storeArrayNumber)
            storeListVC.storeArrayNumber = storeArrayNumber
            
            var preventRepeatArray = [String]()
            preventRepeatArray.removeAll()
            
            for _ in storeArrayNumber {
                if let item = ListModel.storeListKeyArray.randomElement() {
                    
                    if preventRepeatArray.contains(item) {
                        if let item2 = ListModel.storeListKeyArray.randomElement() {
                            preventRepeatArray.append(item2)
                            storeListVC.storeArray.append(item2)
                        } else {}
                    } else {
                        preventRepeatArray.append(item)
                        storeListVC.storeArray.append(item)
                    }
                } else {
                    storeListVC.storeArray.append("음식 종류를 다시 선택해 주세요")
                }
                print("✅ 중복방지 \(preventRepeatArray)")
                
            }
            
            storeListVC.storeNumberInt = Int(numberStepper.value)
            
            locationIndicator.stopAnimating()
            randomButton.isEnabled = true
        }
        
    }
    
}

//MARK: - setObject method

extension KindViewController {
    
    func setObject() {
        
        randomButtonBubble.layer.cornerRadius = 10
        randomButtonBubble.layer.masksToBounds = false
        randomButtonBubble.layer.shadowColor = UIColor.black.cgColor
        randomButtonBubble.layer.shadowOpacity = 0.3
        randomButtonBubble.layer.shadowRadius = 2
        randomButtonBubble.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        locationIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(locationIndicator)
        locationIndicator.centerXAnchor.constraint(equalTo: self.randomButton.centerXAnchor).isActive = true
        locationIndicator.centerYAnchor.constraint(equalTo: self.randomButton.centerYAnchor).isActive = true
        locationIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        locationIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
}

