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
        
        super.viewDidLoad()
    }
    
    @IBAction func reloadButtonPressed(_ sender: UIButton) {
        
        guard let mvc = storyboard?.instantiateViewController(withIdentifier: "MapVC") else {
            return
        }
        mvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        present(mvc, animated: true)
    }

}


//MARK: - UITableViewDatatSource

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)
        cell.textLabel?.text = storeArray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(tableView.bounds.size.height) / kindArray.count)
    }
    
}


//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
//    @IBAction func URLButtonPressed(_ sender: UIButton) {
//        if let url = URL(string: "kakaomap://place?id=7813422") {
//            UIApplication.shared.open(url, options: [:])
//        }
//    }

}

