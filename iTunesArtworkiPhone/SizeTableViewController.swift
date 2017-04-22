//
//  SizeTableViewController.swift
//  iTunesArtworkiPhone
//
//  Created by piyo on 2017/04/16.
//  Copyright © 2017年 piyo. All rights reserved.
//

import UIKit

internal final class SizeTableViewController: UITableViewController {
    
    private let cellArray: [String] = ["Medium", "Large"]
    private var selectSize: Int = 0
    private var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = false
        self.tableView.reloadData()
        
        print(userDefaults.integer(forKey: "size"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let setCell = tableView.dequeueReusableCell(withIdentifier: "sizeCell", for: indexPath) as? SizeCell else {
            return UITableViewCell()
        }
        setCell.sizeLabel.text = cellArray[indexPath.row]
        
        //userDefaultと同じ値のセルにチェックマークをつける
        if userDefaults.integer(forKey: "size") == indexPath.row {
            setCell.accessoryType = .checkmark
        }
        // 存在するセル以外の罫線を消す
        tableView.tableFooterView = UIView()
        
        return setCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("cellを押しました")
        selectSize = indexPath.row
        print("selectSizeに\(selectSize)をセットしました")
        for i in 0..<cellArray.count {
            let indexPath: IndexPath = IndexPath(row: i, section: 0)
            if let cell: UITableViewCell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
            }
        }
        //ユーザーデフォルトに選択したセル番号をセット
        userDefaults.set(indexPath.row, forKey: "size")
        let cell = tableView.cellForRow(at:indexPath)
        // チェックマークを入れる
        cell?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        self.tableView.reloadData()
    }
    
    
}
