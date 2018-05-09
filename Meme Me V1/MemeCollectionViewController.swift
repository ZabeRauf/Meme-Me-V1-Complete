//
//  MemeCollectionViewController.swift
//  Meme Me V2
//
//  Created by Zabe Rauf on 4/23/18. I'm a bad student. :(
//  Copyright © 2018 Zaben. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    struct Meme {
        var topMemeText: String
        var bottomMemeText: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    var memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        navigationItem.title = "Meme Collection!"
        collectionView?.reloadData()
        collectionView?.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellLayout()
    }
    
    // got help from another student for this and the layout idea depending on orientation
    // it seemed pretty cool.
    struct Constants {
        static let CellVerticalSpacing: CGFloat = 2
    }
    
    // This method determines the cell layout
    // depending on the devices orientation.
    func cellLayout() {
        var cellWidth: CGFloat
        var numWide: CGFloat
        
        // This method sets the amount of cells that will
        // display depending on the devices orientation.
        switch UIDevice.current.orientation {
            case .portrait:
                numWide = 3
            case .portraitUpsideDown:
                numWide = 3
            case .landscapeLeft:
                numWide = 4
            case .landscapeRight:
                numWide = 4
            default:
                numWide = 4
        }
        
        cellWidth = collectionView!.frame.width / numWide
        cellWidth -= Constants.CellVerticalSpacing
        
        flowLayout.itemSize.width = cellWidth
        flowLayout.itemSize.height = cellWidth
        flowLayout.minimumInteritemSpacing = Constants.CellVerticalSpacing
        
        let actualCellVerticalSpacing: CGFloat = (collectionView!.frame.width - (numWide * cellWidth))/(numWide - 1)
        flowLayout.minimumLineSpacing = actualCellVerticalSpacing
        flowLayout.invalidateLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView!.reloadData()
    }
    
    func numberOfSections(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let meme = self.memes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.memeImageView.image = meme.memedImage
        cell.memeImageView.contentMode = UIViewContentMode.scaleAspectFill
        return cell
    }
    
}
