//
//  Song.swift
//  MusicPlayer
//
//  Created by Ferdy Rodriguez on 11/28/16.
//  Copyright © 2016 Ferdy Rodriguez. All rights reserved.
//

import UIKit
import AVFoundation

struct Song {
    let name: String
    let artist: String
    let album: String
    let cover: UIImage
    let songPath: URL
    
    init(name: String, artist: String, album: String, cover: UIImage, songPath: URL){
        self.name = name
        self.artist = artist
        self.album = album
        self.cover = cover
        self.songPath = songPath
    }
    
    static func songsFromDocuments() -> [Song] {
        
        var songs = [Song]()
        var songName:String = ""
        var songArtist:String = ""
        var songAlbum:String = ""
        var songCover:UIImage!
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentsPath)
        
        do{
            let fm = FileManager.default
            let allsongs = try fm.contentsOfDirectory(atPath: documentsPath.path)
            
            for song in allsongs {
                let songURL = documentsPath.appendingPathComponent(song)
                print(songURL)
                let Item = AVAsset(url: songURL)
                let metadataList = Item.commonMetadata
                for item in metadataList {
                    if let value = item.value {
                        if item.commonKey == "title" {
                            songName = value as! String
                        }
                        if item.commonKey  == "artist" {
                            songArtist = value as! String
                        }
                        if item.commonKey  == "albumName" {
                            songAlbum = value as! String
                        }
                        if item.commonKey == "artwork" {
                            if let image = UIImage(data: value as! Data) {
                                songCover = image
                            }
                        }
                    }
                }
                let song = Song(name: songName, artist: songArtist, album: songAlbum, cover: songCover, songPath: songURL)
                songs.append(song)
            }
        }catch {
            print("Error")
        }
        return songs
    }


}




