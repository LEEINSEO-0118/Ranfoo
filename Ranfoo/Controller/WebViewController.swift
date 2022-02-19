//
//  MapViewController.swift
//  Ranfoo
//
//  Created by TOAD on 2022/01/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController, MTMapViewDelegate {
    
    @IBOutlet var webView: WKWebView!
    var webViewUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeb(self.webViewUrl)
    }
    
    func loadWeb(_ url: String) {
        guard let myUrl = URL(string: url) else { return }
        let request = URLRequest(url: myUrl)
        webView.load(request)
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
