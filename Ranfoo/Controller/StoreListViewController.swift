//
//  StoreListViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/27.
//

import UIKit

//MARK: - StoreListViewController

class StoreListViewController: UIViewController {
    
    @IBOutlet weak var storeListTableView: UITableView!
    var storeArray = [String]()
    var storeArrayNumber = 1...5 // 기본값
    var webViewUrl = ""


    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.tintColor = .white
        
        storeListTableView.dataSource = self
        storeListTableView.delegate = self
        storeListTableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        storeListTableView.separatorStyle = .none
        
        super.viewDidLoad()
    }

    //MARK: - reloadButton
    
    @IBAction func reloadButtonPressed(_ sender: UIButton) {
        
        print(storeArrayNumber)
        storeArray.removeAll()
        for _ in storeArrayNumber {
            let item = ListModel.storeListKeyArray.randomElement()
            storeArray.append(item ?? "")
        }
        storeListTableView.reloadData()
    
    }

}


//MARK: - UITableViewDatatSource

extension StoreListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ListCell
                
        let storeName = storeArray[indexPath.row]
        cell.storeNameLabel.text = storeName
        cell.storeKindLabel.text = ListModel.storeKindDict[storeName]
        
        if ListModel.storeLocationDict[storeName] == "" {
            cell.storeLocationLabel.text = "등록된 주소가 없습니다."
        } else {
            cell.storeLocationLabel.text = ListModel.storeLocationDict[storeName]
        }
        
        if ListModel.storePhoneDict[storeName] == "" {
            cell.storePhoneNumberLabel.text = "등록된 번호가 없습니다."
        } else {
            cell.storePhoneNumberLabel.text = ListModel.storePhoneDict[storeName]
        }
        
        if let distance = ListModel.storeDistanceDict[storeName] {
            cell.storeDistanceLabel.text = "\(distance)m"
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(tableView.bounds.size.height) / 4)
    }
    
}


//MARK: - UITableViewDelegate

extension StoreListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListCell
        cell.selectionStyle = .none  // 선택하는 애니메이션이 없음
        tableView.deselectRow(at: indexPath, animated: true)  // 선택 후 그림자 사라짐
        
        // 옵셔널 에러가 발생했다. 흠 if let 발생전 performsegue가 발생해버린 것일까. 그게 아니였다.  url의 문제도 아니었다... 그렇다면.. 내가 perform method에서 loadWeb을 실행해서 그렇다면?

        if let storeName = cell.storeNameLabel.text {
            self.webViewUrl = ListModel.storeUrlDict[storeName] ?? Constants.kakaoMapUrl
        } else {
            print("❗ error. 가게 이름이 들어오지 않았음.")
        }
        
        self.performSegue(withIdentifier: Constants.webViewSegueIdentifier, sender: self)
        

    }
    

}

//MARK: - Prepare method

extension StoreListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.webViewSegueIdentifier {
            let webViewVC = segue.destination as! WebViewController
            print("✅ \(self.webViewUrl)")
            webViewVC.webViewUrl = self.webViewUrl
           
        }
        
    }
    
}

