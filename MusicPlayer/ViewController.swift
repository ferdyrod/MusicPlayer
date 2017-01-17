//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Ferdy Rodriguez on 11/18/16.
//  Copyright © 2016 Ferdy Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let songs = Song.songsFromDocuments()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85
        print(songs)
        
    }
    
    // NAVIGATION MARK
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let d = segue.destination as! SongPlayerViewController
        let pos = self.tableView.indexPathForSelectedRow!.row
        d.songId = pos
    }   
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SongViewCell
        
        let song = songs[indexPath.row]
        cell.songName.text = song.name
        cell.songAlbum.text = song.album
        cell.songArtist.text = song.artist
        
        return cell
    }
}

