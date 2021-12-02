//
//  Modelos.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 04/11/2021.
//

import Foundation


struct Track: Codable, Hashable{
    let title: String
    let artist: String?
    let album: String?
    let song_id: String
    let genre: String?
    let duration: Double?
}

enum CodingKeys: String, CodingKey{
    case songId = "song_id"
    case name
    case duration
    case artist
    case genre

}


var misTracks = [
    Track(title:"Donda", artist:"Kanye West", album:"", song_id: "1", genre: "", duration: nil),
    Track(title:"Lost", artist:"Frank Ocean", album:"", song_id: "2", genre: "", duration: nil),
    Track(title:"Cherry", artist:"Lana del Rey", album:"", song_id: "3", genre: "", duration: nil),
    Track(title:"Me and my Husband", artist:"Mitski", album:"", song_id: "4", genre: "", duration: nil),
    Track(title:"Hell", artist:"King Gizzard and the lizard wizard", album:"", song_id: "5", genre: "", duration: nil),
    Track(title:"Inolvidable", artist:"Luis Miguel", album:"", song_id: "6", genre: "", duration: nil),
    Track(title:"All too well", artist:"Taylor Swift", album:"", song_id: "7", genre: "", duration: nil),
    Track(title:"Traicion", artist:"Miranda", album:"", song_id: "8", genre: "", duration: nil),
    Track(title:"Countdown", artist:"Beyonce", album:"", song_id: "9", genre: "", duration: nil),
    Track(title:"Voyeur", artist:"James Blake", album:"", song_id: "10", genre: "", duration: nil),
    Track(title:"Batphone", artist:"Arctic Monkeys", album:"", song_id: "11", genre: "", duration: nil),
    Track(title:"Honey", artist:"Brockhapmton", album:"", song_id: "12", genre: "", duration: nil),
    Track(title:"Tra Tra", artist:"El pepo, XXL Irione", album:"", song_id: "13", genre: "", duration: nil),
    Track(title:"Cellular", artist:"King Krule", album:"", song_id: "14", genre: "", duration: nil),
    Track(title:"Zona gangster", artist:"Daddy Yankee ft Snoop Dogg", album:"", song_id: "15", genre: "", duration: nil)
];
