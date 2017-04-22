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

class WebViewController: UIViewController {
  
  @IBOutlet weak var webView: UIWebView!
  
  var itemUrl: String?
  var itemImage: UIImage?
  let board = UIPasteboard.general



  // ボタン押したとき
  @IBAction func buttonPush(_ sender: Any) {
    
    
    // アラートを作成
    let alert = UIAlertController(
      title: "完了",
      message: "クリップボードに送りました",
      preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "OK", style: .default))
    self.present(alert, animated: true, completion: nil)
  
    Alamofire.request(itemUrl!).responseImage { response in
      debugPrint(response)
      if let image = response.result.value {
        print("image downloaded: \(image)")
        self.board.image = image
      }
    }
  }

    override func viewDidLoad() {
      super.viewDidLoad()

      guard let urlurl = itemUrl else {
        return
      }
      guard let url = URL(string: urlurl) else {
        return
      }
      let request = URLRequest(url: url)
      webView.loadRequest(request)
    }
  
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
