//
//  SongViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Maitree Bain on 12/2/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

enum SearchBarScope {
    case artist
    case title
}

class SongViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var song = [Song]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentScope = SearchBarScope.artist
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func loadData() {
        song = Song.loveSongs
    }

    var searchQuery = "" {
        didSet {
            switch currentScope {
            case .artist:
                song = Song.loveSongs.filter { $0.artist.lowercased().contains(searchQuery.lowercased())}
            case .title:
                song = Song.loveSongs.filter { $0.name.lowercased().contains(searchQuery.lowercased())}
            }
        }
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

extension SongViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count != 0 {
            loadData()
        }
        
        searchQuery = searchText
        
    }
    
}
