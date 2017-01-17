//
//  SongPlayerViewController.swift
//  MusicPlayer
//
//  Created by Ferdy Rodriguez on 12/12/16.
//  Copyright © 2016 Ferdy Rodriguez. All rights reserved.
//

import UIKit
import AVFoundation

class SongPlayerViewController: UIViewController, AVAudioPlayerDelegate {
    
    var songId: Int = 0;
    let songs = Song.songsFromDocuments()
    var player = AVAudioPlayer()
    
    @IBOutlet var albumCover: UIImageView!
    @IBOutlet var songName: UILabel!
    @IBOutlet var songArtist: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var songTime: UILabel!
    @IBOutlet var previousBtn: UIButton!
    @IBOutlet var playBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var stopBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        songToPlay(songIndex: songId)
        playBtn.setImage(UIImage(named: "ic_pause"), for: .normal)
        player.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.stop()
    }
    
    func viewWillDisappear() {
        player.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func songToPlay(songIndex: Int) {
        let songURL = songs[songIndex].songPath
        player = try! AVAudioPlayer(contentsOf: songURL)
        songName.text = songs[songIndex].name
        songArtist.text = songs[songIndex].artist
        albumCover.image = songs[songIndex].cover
        player.play()
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SongPlayerViewController.updateProgressBarAndTime), userInfo: nil, repeats: true)
        progressBar.setProgress(Float(player.currentTime / player.duration), animated: false)

        
    }
    
    func updateProgressBarAndTime(){
        if player.isPlaying {
            let currentTime = Int(player.currentTime)
            let minutes = currentTime / 60
            let seconds = currentTime - minutes * 60
            
            songTime.text = String(format: "%02d:%02d", minutes,seconds) as String
            progressBar.setProgress(Float(player.currentTime / player.duration), animated: true)
        }
        
    }
    
    @IBAction func play(_ sender: UIButton) {
        if player.isPlaying {
            playBtn.setImage(UIImage(named: "ic_play_arrow"), for: .normal)
            player.pause()
        } else {
            player.play()
            playBtn.setImage(UIImage(named: "ic_pause"), for: .normal)
        }
    }
    
    @IBAction func nextSong(_ sender: UIButton) {
        if songId == songs.count-1 {
            songId = 0
            songToPlay(songIndex: songId)
        } else {
            songId += 1
            songToPlay(songIndex: songId)
        }
    }

    @IBAction func previousSong(_ sender: UIButton) {
        if songId == 0 {
            songId = songs.count - 1
            songToPlay(songIndex: songId)
        } else {
            songId -= 1
            songToPlay(songIndex: songId)
        }
    }

    @IBAction func stopSong(_ sender: UIButton) {
        if player.isPlaying {
            playBtn.setImage(UIImage(named: "ic_play_arrow"), for: .normal)
            player.stop()
            player.currentTime = 0
            progressBar.progress = 0
        }
    }
    
    func playNextSong(){
        if songId == songs.count-1 {
            songId = 0
            songToPlay(songIndex: songId)
        } else {
            songId += 1
            songToPlay(songIndex: songId)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playNextSong()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

