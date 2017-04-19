//
//  CountryTableViewController.swift
//  iTunesArtworkiPhone
//
//  Created by piyo on 2017/04/18.
//  Copyright © 2017年 piyo. All rights reserved.
//

import UIKit

class CountryTableViewController: UITableViewController {

  let cellArray: [String] = ["JAPAN", "USA"]
  var selectCountry: Int = 0
  var userDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.allowsMultipleSelection = false
    self.tableView.reloadData()
    
    print(userDefaults.integer(forKey: "country"))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let setCell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as? CountryCell else {
      return UITableViewCell()
    }
    setCell.countryLabel.text = cellArray[indexPath.row]
    
    //userDefaultと同じ値のセルにチェックマークをつける
    if userDefaults.integer(forKey: "country") == indexPath.row {
      setCell.accessoryType = .checkmark
    }
    // 存在するセル以外の罫線を消す
    tableView.tableFooterView = UIView()
    return setCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print ("cellを押しました")
    selectCountry = indexPath.row
    print("selectCountryに\(selectCountry)をセットしました")
    for i in 0..<cellArray.count {
      let indexPath: IndexPath = IndexPath(row: i, section: 0)
      if let cell: UITableViewCell = tableView.cellForRow(at: indexPath) {
        cell.accessoryType = .none
      }
    }
    //ユーザーデフォルトに選択したセル番号をセット
    userDefaults.set(indexPath.row, forKey: "country")
    let cell = tableView.cellForRow(at:indexPath)
    // チェックマークを入れる
    cell?.accessoryType = .checkmark
    tableView.deselectRow(at: indexPath, animated: true)
    self.tableView.reloadData()
  }


}
