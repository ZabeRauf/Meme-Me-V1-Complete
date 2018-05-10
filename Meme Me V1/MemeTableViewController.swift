//
//  MemeTableViewController.swift
//  Meme Me V1
//
//  Created by Zabe Rauf on 5/8/18.
//  Copyright © 2018 Zaben. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        cell.memeImageView?.image = memes[indexPath.row].memedImage
        cell.Label?.text = "\(memes[indexPath.row].topMemeText)...\(memes[indexPath.row].bottomMemeText)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailView") as! detailViewController
        detailVC.meme = self.memes[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
