//
//  SettingViewController.swift
//  iTunesArtworkiPhone
//
//  Created by いちもつ青田 on 2017/04/23.
//  Copyright © 2017年 piyo. All rights reserved.
//

import UIKit

internal final class SettingViewController: UIViewController {

    let countries: [Country] = [.japan, .usa]
    let imageSize: [ArtworkSize] = [.medium, .large]
    
    private let userDefaults = UserDefaults.standard
    
    // TODO: 本当はLocalizable.stringsを作って文字列はすべてそこに定義し、あとから変更しやすいようにすべき
    //       また、タイトルのラベルもstoryboard上ではなくoutletを引っ張ってきて↑の定義を設定する作りにすべき
    @IBOutlet weak var countrySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var artworkSegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didChangeCountry(_ sender: UISegmentedControl) {
        userDefaults[.country] = sender.selectedSegmentIndex
        
        
    }
    @IBAction func didChangeArtworkSize(_ sender: UISegmentedControl) {
        userDefaults[.imageSize] = sender.selectedSegmentIndex
    }
    
    private func setupViews() {
        countrySegmentedControl.setTitle(Country.japan.title, forSegmentAt: 0)
        countrySegmentedControl.setTitle(Country.usa.title, forSegmentAt: 1)
        countrySegmentedControl.selectedSegmentIndex = Country.currentCountry.rawValue
        
        artworkSegmentedControl.setTitle(ArtworkSize.medium.title, forSegmentAt: 0)
        artworkSegmentedControl.setTitle(ArtworkSize.large.title, forSegmentAt: 1)
        artworkSegmentedControl.selectedSegmentIndex = ArtworkSize.currentSize.rawValue
    }
}


