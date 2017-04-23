//
//  MovieViewController.swift
//  iTunesArtworkiPhone
//
//  Created by piyo on 2017/04/19.
//  Copyright © 2017年 piyo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

internal final class MovieViewController: UITableViewController, UISearchBarDelegate {
    
    // タプル配列
    private var listArray: [(name: String, url: String)] = []
    private var listArray2: [(name: String, url: String)] = []
    private let section: [String] = ["iTunes", "IMDb"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //サーチボタンが押された時動くやつ
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //初期化
        listArray.removeAll()
        listArray2.removeAll()
        //国選択
        let country = Country.currentCountry.requestParameter
        
        if let search = searchBar.text {
            let listUrl = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?"
            let listUrlIMDB = "http://www.omdbapi.com/?"
            
            Alamofire.request(listUrl, parameters: [
                "term": search,
                "country": country,
                "entity": "movie"
                ])
                .responseJSON{ response in
                    let json = JSON(response.result.value ?? 0)
                    json["results"].forEach{ _, data in
                        let name: String = data["trackCensoredName"].stringValue
                        let url: String = data["artworkUrl60"].stringValue
                        let list = (name, url)
                        self.listArray.append(list)
                    }
                    self.tableView.reloadData()
            }
            
            Alamofire.request(listUrlIMDB, parameters: [
                "s": search
                ])
                .responseJSON{response in
                    let json = JSON(response.result.value ?? 0)
                    json["Search"].forEach{(i, data) in
                        let name2 : String = data["Title"].stringValue
                        let url2 : String = data["Poster"].stringValue
                        let list2 = (name2, url2)
                        self.listArray2.append(list2)
                    }
                    self.tableView.reloadData()
            }
        }
    }
    
    //rowの数を設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return listArray.count
        case 1:
            return listArray2.count
        default:
            return 0
        }
    }
    
    //sectionの数を設定
    override func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    //sectionのタイトル
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    
    //tableViewを設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.trackTitle.text = listArray[indexPath.row].name
            cell.itemUrl = listArray[indexPath.row].url
            cell.accessoryType = .disclosureIndicator
            let URL = NSURL(string: listArray[indexPath.row].url.replacingOccurrences(of: "60x60bb.jpg", with: "600x600bb.jpg"))!
            cell.itemImageView.af_setImage(withURL: URL as URL)
        case 1:
            cell.trackTitle.text = listArray2[indexPath.row].name
            cell.itemUrl = listArray2[indexPath.row].url
            cell.accessoryType = .disclosureIndicator
            let URL = NSURL(string: listArray2[indexPath.row].url)!
            cell.itemImageView.af_setImage(withURL: URL as URL)
        default:
            break
        }
        
        return cell
    }
    
    //webViewへページ遷移する際の値受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? MovieCell {
            if let webViewController = segue.destination as? WebViewController {
                
                //サイズによってURLを置換
                let size: [String] = ["600x600bb.jpg", "100000x100000-999.jpg"]
                let sizeIMDB: [String] = ["1000.jpg", "1500.jpg"]
                guard let urlurl = cell.itemUrl else{
                    return
                }
                switch DeviceData.imageSizeRawValue {
                case 0:
                    if urlurl.contains("60x60bb.jpg"){
                        webViewController.itemUrl = urlurl.replacingOccurrences(of: "60x60bb.jpg", with: size[0])
                    } else {
                        webViewController.itemUrl = urlurl.replacingOccurrences(of: "300.jpg", with: sizeIMDB[0])
                    }
                case 1:
                    if urlurl.contains("60x60bb.jpg"){
                        webViewController.itemUrl = urlurl.replacingOccurrences(of: "60x60bb.jpg", with: size[1])
                    } else {
                        webViewController.itemUrl = urlurl.replacingOccurrences(of: "300.jpg", with: sizeIMDB[1])
                    }
                default:
                    assertionFailure("ここには来ないはず")
                    webViewController.itemUrl = urlurl
                }
                print(cell.itemUrl ?? "error")
                webViewController.navigationItem.title = cell.trackTitle.text
            }
        }
    }
    
    
    
}
