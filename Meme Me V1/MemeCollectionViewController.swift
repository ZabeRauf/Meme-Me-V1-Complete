//
//  MemeCollectionViewController.swift
//  Meme Me V2
//
//  Created by Zabe Rauf on 4/23/18. I'm a bad student. :(
//  Copyright © 2018 Zaben. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        navigationItem.title = "Meme Collection!"
        collectionView?.backgroundColor = UIColor.gray
        
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.memeImageView.image = memes[indexPath.row].memedImage
        return cell
    }
    
    // detail view stuff
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailView") as! detailViewController
        detailVC.meme = self.memes[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
