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

internal final class MovieViewController: UITableViewController, UISearchBarDelegate {
    
    // タプル配列
    private var listArray = [(name: String, url: String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //サーチボタンが押された時動くやつ
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //初期化
        listArray.removeAll()
        self.tableView.reloadData()
        //国選択
        let country = Country.currentCountry.requestParameter
        
        //Codable準備
        struct Json: Codable {
            let results: [SongData]
            struct SongData: Codable{
                let trackCensoredName: String
                let artistName: String
                let artworkUrl60: String
            }
        }
        
        print("押したよ")
        
        if let search = searchBar.text {
            let listUrl = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?"
            Alamofire.request(listUrl, parameters: [
                "term": search,
                "country": country,
                "entity": "movie"
                ])
                .responseData{ response in
                    // codableでデコード
                    guard let jsonData = response.result.value else {
                        print("data is nil")
                        return
                    }
                    let decoder: JSONDecoder = JSONDecoder()
                    do {
                        let decodedJson: Json = try decoder.decode(Json.self, from: jsonData)
                        for (_, element) in decodedJson.results.enumerated(){
                            let name: String = element.trackCensoredName
                            let url: String = element.artworkUrl60
                            let list = (name, url)
                            self.listArray.append(list)
                            self.tableView.insertRows(at: [IndexPath(row: self.listArray.count - 1, section: 0)], with: .right)
                        }
                    } catch {
                        print("json decode faild")
                }
            }
        } else {
            print("searchBar text is nil")
        }
    }
    
    //rowの数を設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listArray.count
    }
    
    //tableViewを設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieItemCell", for: indexPath) as? MovieCell else {
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
        if let cell = sender as? MovieCell {
            if let webViewController = segue.destination as? WebViewController {
                //サイズによってURLを置換
                guard let itemUrl = cell.itemUrl else{
                    return
                }
                let currentSize = ArtworkSize.currentSize
                if itemUrl.contains("60x60bb.jpg"){
                    webViewController.itemUrl = itemUrl.replacingOccurrences(of: "60x60bb.jpg", with: currentSize.sizeString(at: .itunes))
                } else {
                    webViewController.itemUrl = itemUrl.replacingOccurrences(of: "300.jpg", with: currentSize.sizeString(at: .imdb))
                }
                print(cell.itemUrl ?? "error")
                webViewController.navigationItem.title = cell.trackTitle.text
            }
        }
    }
    
    
    
}
