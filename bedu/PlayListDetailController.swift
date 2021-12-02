//
//  PlayListDetailController.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 09/11/2021.
//


import UIKit

class PlayListDetailController: UIViewController, TracksPickerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let textField = UITextField()
    let pickerModal = UIButton(type: .custom)
    let tv = UITableView()
    var tracks = Set<Track>()
    var tracksArray = [Track]()
    
    func addTrack(track: Track) {
        tracks.insert(track)
        tracksArray = Array(tracks)
        tv.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(textField)
        textField.placeholder = "Playlist..."
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(pickerModal)
        pickerModal.setImage(UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill"), for: .normal)
        pickerModal.translatesAutoresizingMaskIntoConstraints=false
        pickerModal.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 50).isActive = true
        pickerModal.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10).isActive = true
        pickerModal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        pickerModal.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pickerModal.addTarget(self, action:#selector(showView), for: .touchUpInside)
        
        self.view.addSubview(tv)
        tv.translatesAutoresizingMaskIntoConstraints=false
        tv.topAnchor.constraint(equalTo:textField.bottomAnchor, constant: 20).isActive = true
        tv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tv.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -20).isActive = true
        tv.backgroundColor = .white
        tv.separatorColor = UIColor(named: "Color2")
        tv.separatorStyle = .singleLine
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "track")
        tv.dataSource = self
        tv.delegate = self
    }
    
    @objc func showView() {
        let trv = TracksPickerView (frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2))
        trv.delegate = self
        trv.backgroundColor = UIColor(named: "Color1")
        self.view.addSubview(trv)
    }


     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         tracksArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
         let track = tracksArray[indexPath.row]
         cell.textLabel?.text = track.title
         cell.backgroundColor = UIColor(named: "Color1")
         return cell
     }
}
