//
//  PlayListDetailController.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 09/11/2021.
//


import UIKit

class PlayListDetailController: UIViewController, TracksPickerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var playlistView: UIView!
    
    let textField = UITextField()
    let pickerModal = UIButton(type: .custom)
    let playlist = UITableView()
    var tracks = Set<Track>()
    var tracksArray = [Track]()
    //var cancionDeAudioPlayer = String()
    
    
   
    
    //delegate
    func addTrack(track: Track) {
        tracks.insert(track)
        tracksArray = Array(tracks)
        playlist.reloadData()
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textField)
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
      
        view.insertSubview(backgroundImage, at: 0) // 2
       
        textField.placeholder = "Playlist..."
        textField.backgroundColor = UIColor(named: "Purple")
        textField.tintColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(pickerModal)
        pickerModal.backgroundColor = UIColor(named: "MedPurpleTr")
        pickerModal.tintColor = .white
        pickerModal.setImage(UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill"), for: .normal)
        pickerModal.translatesAutoresizingMaskIntoConstraints=false
        pickerModal.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
        pickerModal.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10).isActive = true
        pickerModal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        pickerModal.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pickerModal.addTarget(self, action:#selector(showView), for: .touchUpInside)
        
        self.view.addSubview(playlist)
        playlist.translatesAutoresizingMaskIntoConstraints=false
        playlist.topAnchor.constraint(equalTo:textField.bottomAnchor, constant: 20).isActive = true
        playlist.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        playlist.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        playlist.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -20).isActive = true
        playlist.backgroundColor = UIColor(named: "MedPurpleTr")
        playlist.separatorColor = UIColor(named: "MedPurple")
        playlist.separatorStyle = .singleLine
        playlist.register(UITableViewCell.self, forCellReuseIdentifier: "track")
        playlist.dataSource = self
        playlist.delegate = self
    }
    
    @objc func showView() {
        let picker = TracksPickerView (frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2))
        
        //delegate
        picker.delegate = self
        picker.backgroundColor = UIColor(named: "Color1")
        self.view.addSubview(picker)
    }


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         tracksArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
         let track = tracksArray[indexPath.row]
         cell.textLabel?.text = track.title
         cell.backgroundColor = UIColor(named: "LigthPurple")
         return cell
     }
}

extension PlayListDetailController: TracksDelegate {


    func addTrackto(track: Track) {
           tracks.insert(track)
           tracksArray = Array(tracks)
           playlist.reloadData()
       }

}
