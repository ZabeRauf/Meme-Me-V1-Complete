//
//  detailViewController.swift
//  Meme Me V1
//
//  Created by Zabe Rauf on 5/10/18.
//  Copyright © 2018 Zaben. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var detailView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailView.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
     
}
