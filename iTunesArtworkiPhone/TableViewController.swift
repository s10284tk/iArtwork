//
//  TableViewController.swift
//  iTunesArtworkiPhone
//
//  Created by piyo on 2017/04/12.
//  Copyright © 2017年 piyo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class TableViewController: UITableViewController, UISearchBarDelegate{
  
    // タプル配列
    var listArray: [(name: String, url: String)] = []
    // ユーザーデフォルト
    var userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.register(defaults: ["size": 0])
        userDefaults.register(defaults: ["genre": 0])
        userDefaults.register(defaults: ["country": 0])
        self.tableView.reloadData()
        print(userDefaults.integer(forKey: "size"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//サーチボタンが押された時動くやつ
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    //初期化
    listArray.removeAll()
    
    //ジャンル選択
    let entity: [String] = ["musicTrack", "movie"]
    var setEntity: String
    switch userDefaults.integer(forKey: "genre") {
    case 0:
      setEntity = entity[0]
    case 1:
      setEntity = entity[1]
    default:
      setEntity = entity[0]
    }
    //国選択
    let country: [String] = ["jp", "us"]
    var setCountry: String
    switch userDefaults.integer(forKey: "country") {
    case 0:
      setCountry = country[0]
    case 1:
      setCountry = country[1]
    default:
      setCountry = country[0]
    }

    if let search = searchBar.text {
      let listUrl = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?"
      Alamofire.request(listUrl, parameters: [
        "term": search,
        "country": setCountry,
        "entity": setEntity
        ])
        .responseJSON{ response in
          let json = JSON(response.result.value ?? 0)
          json["results"].forEach{(i, data) in
            let name: String = data["trackCensoredName"].stringValue
            let url: String = data["artworkUrl60"].stringValue
            let list = (name, url)
            self.listArray.append(list)
          }
          self.tableView.reloadData()
      }
    }
  }
  
  //rowの数を設定
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listArray.count
  }
 
  //tableViewを設定
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {
      return UITableViewCell()
    }
    cell.trackTitle.text = listArray[indexPath.row].name
    cell.itemUrl = listArray[indexPath.row].url
    cell.accessoryType = .disclosureIndicator

    let URL = NSURL(string: listArray[indexPath.row].url.replacingOccurrences(of: "60x60bb.jpg", with: "600x600bb.jpg"))!
    cell.itemImageView.af_setImage(withURL: URL as URL)

    return cell
  }
  
  //webViewへページ遷移する際の値受け渡し
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? ItemTableViewCell {
      if let webViewController = segue.destination as? WebViewController {
        
        //サイズによってURLを置換
        let size: [String] = ["600x600bb.jpg", "100000x100000-999.jpg"]
        switch userDefaults.integer(forKey: "size") {
        case 0:
          webViewController.itemUrl = cell.itemUrl?.replacingOccurrences(of: "60x60bb.jpg", with: size[0])
        case 1:
          webViewController.itemUrl = cell.itemUrl?.replacingOccurrences(of: "60x60bb.jpg", with: size[1])
        default:
          webViewController.itemUrl = cell.itemUrl
        }
        print(cell.itemUrl ?? "error")
        webViewController.navigationItem.title = cell.trackTitle.text
      }
    }
  }
  
  //設定画面へ遷移する際の値受け渡し
  @IBAction func ButtonSet(_ sender: Any) {
    print("push")
    //segue使わない方法
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let settingView = storyboard.instantiateViewController(withIdentifier: "MainSetting") as! SettingViewController
//    self.navigationController?.pushViewController(settingView, animated: true)
  }


}
