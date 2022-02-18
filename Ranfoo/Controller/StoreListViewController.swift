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
        cell.selectionStyle = .none
        

        tableView.deselectRow(at: indexPath, animated: true)
               
    }

}

