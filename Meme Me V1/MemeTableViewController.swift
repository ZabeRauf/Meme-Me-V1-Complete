//
//  MemeTableViewController.swift
//  Meme Me V1
//
//  Created by Zabe Rauf on 5/8/18.
//  Copyright © 2018 Zaben. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
  
    struct Meme {
        var topMemeText: String
        var bottomMemeText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    var memes: [Meme]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = getAppDelegate()
        memes = appDelegate.memes
        toggleNavAndTabBars(on: false)
        self.tableView.reloadData()
    }
    
    func toggleNavAndTabBars(on: Bool) {
        self.tabBarController?.tabBar.isHidden = on
        self.navigationController?.navigationBar.isHidden = on
    }
    
    func getAppDelegate() -> AppDelegate {
        let object = UIApplication.shared.delegate
        return object as! AppDelegate
    }
}
