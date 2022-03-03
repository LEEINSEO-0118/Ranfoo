//
//  MainViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/02/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var usingManualBubble: UIView!
    @IBOutlet var collectionViewEx: UIView!    
    @IBOutlet var findButtonEx: UIView!
    @IBOutlet var kindViewButton: UIButton!
 
    let kindVC = KindViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
        
        setObejctFrame()
       
    }
    
    @IBAction func kindViewButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: Constants.kindViewSegueIdentifier, sender: self)
        
        self.kindViewButton.layer.opacity = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.kindViewButton.layer.opacity = 1.0
          }
        
    }
    
    func setObejctFrame() {
        usingManualBubble.layer.cornerRadius = 20
        usingManualBubble.layer.borderWidth = 1
        usingManualBubble.layer.borderColor = UIColor.gray.cgColor
        
        usingManualBubble.layer.shadowColor = UIColor.black.cgColor
        usingManualBubble.layer.shadowOpacity = 0.3
        usingManualBubble.layer.shadowRadius = 5
        usingManualBubble.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        kindViewButton.layer.cornerRadius = 13
        kindViewButton.layer.borderWidth = 2
        kindViewButton.layer.borderColor = UIColor(named: Constants.thirdColor)?.cgColor
        
        kindViewButton.translatesAutoresizingMaskIntoConstraints = false
        kindViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        collectionViewEx.layer.cornerRadius = 15
        
        findButtonEx.layer.cornerRadius = 10
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
