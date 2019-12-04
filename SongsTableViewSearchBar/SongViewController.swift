//
//  SongViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Maitree Bain on 12/2/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var song = [Song]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData() {
        song = Song.loveSongs
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let songDetailVC = segue.destination as? SongDetailViewController,
        let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("no segue found")
        }
        let selectedArtist = song[indexPath.row]
        
        songDetailVC.song = selectedArtist
        
    }
}

extension SongViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SongViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        let selectedSong = song[indexPath.row]
        
        cell.textLabel?.text = selectedSong.name
        cell.detailTextLabel?.text = selectedSong.artist
        
        return cell
    }
    
}


