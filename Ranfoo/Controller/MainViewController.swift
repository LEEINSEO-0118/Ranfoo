//
//  MainViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/02/21.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var kindViewButton: UIButton!
    
    let kindVC = KindViewController()
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.tintColor = .white
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func kindViewButtonPressed(_ sender: UIButton) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
