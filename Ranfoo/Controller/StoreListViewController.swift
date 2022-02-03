//
//  StoreListViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/27.
//

import UIKit

class StoreListViewController: UIViewController {
    
    var storeArray = ["혜화문 식당", "BHC", "BBQ", "한반도", "샐러디"]
    
    @IBOutlet weak var storeListTableView: UITableView!
    

    override func viewDidLoad() {
        
        storeListTableView.dataSource = self
        storeListTableView.delegate = self
        storeListTableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        super.viewDidLoad()
    }
    
    @IBAction func reloadButtonPressed(_ sender: UIButton) {
        
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
        return CGFloat(Int(tableView.bounds.size.height) / storeArray.count)
    }
    
}


//MARK: - UITableViewDelegate

extension StoreListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ListCell
        cell.selectionStyle = .none
        
        // 만약 true면 parentVC의 view 위에 표시
        self.definesPresentationContext = true
        
        let mapVC = MapViewController()

        present(mapVC, animated: true)
        
        
        //        if let url = URL(string: "kakaomap://open?page=placeSearch") {
        //            UIApplication.shared.open(url, options: [:])
        //        }
        //        tableView.deselectRow(at: indexPath, animated: true)
    }

}

