//
//  WebVC.swift
//  MovieGuide
//
//  Created by Dev on 25/3/2566 BE.
//

import UIKit
import WebKit

class WebVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let urls = url{
            let url = URL(string: "https://www.imdb.com/title/" + urls)!
            webView.navigationDelegate = self
            webView.allowsBackForwardNavigationGestures = true
            webView.load(URLRequest(url: url))
        }
    }
}
