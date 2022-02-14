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
        cell.storeNameLabel.text = storeArray[indexPath.row]
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
        
        
        if let url = URL(string: ListModel.storeListDictionary[cell.storeNameLabel.text ?? ""] ?? Constants.kakaoMapUrl) { // 카카오 맵으로 연결되는 url
            UIApplication.shared.open(url, options: [:])
        }

        tableView.deselectRow(at: indexPath, animated: true)
               
    }

}

