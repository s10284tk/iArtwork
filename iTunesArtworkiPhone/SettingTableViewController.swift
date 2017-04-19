//
//  SettingTableViewController.swift
//  iTunesArtworkiPhone
//
//  Created by piyo on 2017/04/16.
//  Copyright © 2017年 piyo. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {
  
  
  let cellArray: [String] = ["国","アートワークのサイズ","ジャンル"]
  

    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      guard let setCell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as? SettingCell else {
        return UITableViewCell()
      }
    setCell.setLabel.text = cellArray[indexPath.row]
    setCell.accessoryType = .disclosureIndicator
    // 存在するセル以外の罫線を消す
    tableView.tableFooterView = UIView()
    return setCell
    }

  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print ("cellを押しました")
    if indexPath.row == 0 {
      performSegue(withIdentifier: "country", sender: nil)
    } else if indexPath.row == 1{
      performSegue(withIdentifier: "size", sender: nil)
//      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//      let size = storyboard.instantiateViewController(withIdentifier: "SizeSetting") as! SettingSizeViewController
//      navigationController?.pushViewController(size, animated: true)
    } else if indexPath.row == 2{
      print ("hello!")
      performSegue(withIdentifier: "genre", sender: nil)
    } else {
      return
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
 
}
