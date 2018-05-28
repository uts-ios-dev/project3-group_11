//
//  MyWebViewController.swift
//  ios-group
//
//  Created by Christopher on 28/05/2018.
//  Copyright © 2018 Minny Lin. All rights reserved.
//

import UIKit
import WebKit
class MyWebViewController: UIViewController, WKUIDelegate  {
    var url:String = "https://www.buycott.com/upc/"
    var data:String = ""
    @IBAction func tapHome(_ sender: Any) {
          navigationController?.popToRootViewController(animated: true)
    }
    var webView: WKWebView!
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        url = url + data
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
    //     makeGetCall(str: url)
        webView.load(myRequest)
        
//        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()",
//                                   completionHandler: { (html: Any?, error: Error?) in
//                                    print(html)
       // })
        
    }
 
    
    func makeGetCall(str: String){
        let url = URL(string: str)
        let urlRequest = URLRequest(url:url!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest){
            (data,respone,error) in
            if error != nil {
                return;
            }
            print(respone!)
        }
        
        task.resume()
    }
    
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
