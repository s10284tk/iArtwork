//
//  WebViewController.swift
//  iTunesArtworkiPhone
//
//  Created by piyo on 2017/04/12.
//  Copyright © 2017年 piyo. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

internal final class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet private weak var webView: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var itemUrl: String?
    private var itemImage: UIImage?
    private let board = UIPasteboard.general
    
    // ボタン押したとき
    @IBAction private func buttonPush(_ sender: Any) {
        Alamofire.request(itemUrl!).responseImage { response in
            debugPrint(response)
            if let image = response.result.value {
                print("image downloaded: \(image)")
                let shareItem = [image]
                let controller = UIActivityViewController(activityItems: shareItem, applicationActivities: nil)
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        activity.hidesWhenStopped = true
        guard let urlurl = itemUrl else {
            return
        }
        guard let url = URL(string: urlurl) else {
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        activity.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activity.stopAnimating()
    }
    
}
