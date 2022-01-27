//
//  StoreListViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/27.
//

import UIKit

class StoreListViewController: UIViewController {
    
    @IBOutlet weak var storeListTableView: UITableView!
    

    override func viewDidLoad() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Back", style: .plain, target: nil, action: nil)

        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reloadButtonPressed(_ sender: UIButton) {
    }
    
    //    @IBAction func URLButtonPressed(_ sender: UIButton) {
    //        if let url = URL(string: "kakaomap://place?id=7813422") {
    //            UIApplication.shared.open(url, options: [:])
    //        }
    //    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

