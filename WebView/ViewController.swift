//
//  ViewController.swift
//  WebView
//
//  Created by Citizen on 10.09.2018.
//  Copyright © 2018 Citizen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var goBackBarItem: UIBarButtonItem!
    @IBOutlet weak var goForwardBarItem: UIBarButtonItem!
    let application = UIApplication.shared
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let urlPDF = Bundle.main.url(forResource: "test", withExtension: "pdf")
    let url = URL(string: "https://www.google.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        webView.scalesPageToFit = true

        let request = URLRequest(url: urlPDF!)
        webView.loadRequest(request)
    }
    
    func isWorkIndicator(isAnimated: Bool, indicator: UIActivityIndicatorView) {
        application.isNetworkActivityIndicatorVisible = isAnimated
        if isAnimated {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        isWorkIndicator(isAnimated: true, indicator: activityIndicator)
        application.isNetworkActivityIndicatorVisible = true
        self.goBackBarItem.isEnabled = false
        self.goForwardBarItem.isEnabled = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        isWorkIndicator(isAnimated: false, indicator: activityIndicator)
        application.isNetworkActivityIndicatorVisible = false
        if webView.canGoBack {
           self.goBackBarItem.isEnabled = true
        }
        if webView.canGoForward {
            self.goForwardBarItem.isEnabled = true
        }
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request)
        return true
    }
    
    @IBAction func goBackAction(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForwardAction(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refrashAction(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    
    
}

