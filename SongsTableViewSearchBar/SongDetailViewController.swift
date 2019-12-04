//
//  SongDetailViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Maitree Bain on 12/4/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    var song: Song!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "loveSongs")
        nameLabel.text = song.name
        artistLabel.text = song.artist
    }
    

}
