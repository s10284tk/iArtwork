//
//  SettingViewController.swift
//  iTunesArtworkiPhone
//
//  Created by いちもつ青田 on 2017/04/23.
//  Copyright © 2017年 piyo. All rights reserved.
//

import UIKit

internal final class SettingViewController: UIViewController {

    let countries = ["JAPAN", "USA"]
    let imageSize = ["Medium", "Large"]
    
    // TODO: 本当はLocalizable.stringsを作って文字列はすべてそこに定義し、あとから変更しやすいようにすべき
    //       また、タイトルのラベルもstoryboard上ではなくoutletを引っ張ってきて↑の定義を設定する作りにすべき
    
    @IBOutlet fileprivate weak var countryLabel: UILabel!
    @IBOutlet fileprivate weak var artworkLabel: UILabel!
    
    @IBOutlet private weak var dataSetPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSetPickerView.dataSource = self
        dataSetPickerView.delegate = self
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupViews() {
        let countryRawValue = DeviceData.countryRawValue
        let artworkRawValue = DeviceData.imageSizeRawValue
        countryLabel.text = countries[countryRawValue]
        artworkLabel.text = imageSize[artworkRawValue]
        dataSetPickerView.selectRow(countryRawValue, inComponent: 0, animated: false)
        dataSetPickerView.selectRow(artworkRawValue, inComponent: 1, animated: false)
    }
}

// MARK: - UIPickerViewDataSource
extension SettingViewController: UIPickerViewDataSource {
    
    /// コンポーネント(スクロースする塊)がいくつあるか
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        // countriesとimageSize
        return 2
    }
    
    /// コンポーネントの中に何行あるか
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            // 国
            return countries.count
            
        case 1:
            // アートワークのサイズ
            return imageSize.count
            
        default:
            assertionFailure("ここには来ないはず")
            return 0
        }
    }
}

// MARK: - UIPickerViewDelegate
extension SettingViewController: UIPickerViewDelegate {
    
    /// ピッカー内のタイトル(引数のcomponentとrowを使って値を返す)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            // 国
            return countries[row]
            
        case 1:
            // アートワークのサイズ
            return imageSize[row]
            
        default:
            assertionFailure("ここには来ないはず")
            return ""
        }
    }
    
    /// ピッカーが選択された際の処理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            // 国
            DeviceData.countryRawValue = row
            countryLabel.text = countries[row]
            
        case 1:
            // アートワークのサイズ
            DeviceData.imageSizeRawValue = row
            artworkLabel.text = imageSize[row]
            
        default:
            assertionFailure("ここには来ないはず")
        }
    }
}


