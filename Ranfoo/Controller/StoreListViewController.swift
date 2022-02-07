//
//  StoreListViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/27.
//

import UIKit


class StoreListViewController: UIViewController {
    
    @IBOutlet weak var storeListTableView: UITableView!
    
    var storeArray = [String]()
    var storeArrayNumber = 1...5

    override func viewDidLoad() {
        
        storeListTableView.dataSource = self
        storeListTableView.delegate = self
        storeListTableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        super.viewDidLoad()
    }
    
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
        cell.checkButton.isHidden = true
        cell.label.text = storeArray[indexPath.row]
        cell.label.font = UIFont.systemFont(ofSize: 18.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(tableView.bounds.size.height) / 7)
    }
    
}


//MARK: - UITableViewDelegate

extension StoreListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListCell
        cell.selectionStyle = .none
        
        
        if let url = URL(string: ListModel.storeListArray[cell.label.text ?? ""] ?? Constants.kakaoMapUrl) { // 카카오 맵으로 연결되는 url
            UIApplication.shared.open(url, options: [:])
        }

        tableView.deselectRow(at: indexPath, animated: true)
               
    }

}

