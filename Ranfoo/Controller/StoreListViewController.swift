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
        cell.storeLocationLabel.text = ListModel.storeLocationDict[storeName] ?? "등록된 주소가 없습니다."
        
        if ListModel.storePhoneDict[storeName] == "" {
            cell.storePhoneNumberLabel.text = "등록된 번호가 없습니다."
        } else {
            cell.storePhoneNumberLabel.text = ListModel.storePhoneDict[storeName]
        }
        
        if let distance = ListModel.storeDistanceDict[storeName] {
            cell.storeDistanceLabel.text = "\(distance)m"
        }
        
        switch ListModel.storeKindDict[storeName] {
        case "아시아음식" :
            cell.storeKindBackground.widthAnchor.constraint(equalToConstant: 60).isActive = true
        case "패스트푸드" :
            cell.storeKindBackground.widthAnchor.constraint(equalToConstant: 60).isActive = true
        default :
            cell.storeKindBackground.widthAnchor.constraint(equalToConstant: 30).isActive = true
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
        cell.selectionStyle = .none
        
        
        if let url = URL(string: ListModel.storeUrlDict[cell.storeNameLabel.text ?? ""] ?? Constants.kakaoMapUrl) { // 카카오 맵으로 연결되는 url
            UIApplication.shared.open(url, options: [:])
        }

        tableView.deselectRow(at: indexPath, animated: true)
               
    }

}

