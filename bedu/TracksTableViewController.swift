//
//  TableTableViewController.swift
//  bedu2
//
//  Created by Felicitas Figuero Fagalde on 03/11/2021.
//

import UIKit
import CoreData

class TracksTableViewController: UITableViewController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.backgroundColor = UIColor(named: "Color1")
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        self.tableView.rowHeight = 80
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.savedData()
        
    }
    
    func savedData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracks")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context!.fetch(request)
            misTracks = [Track]()
            
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as? String
                let artist = data.value(forKey: "artist") as? String
                let album = data.value(forKey: "album") as? String
                let genre = data.value(forKey: "genre") as? String
                let songId = data.value(forKey: "song_id") as? String

                let track = Track(title: title ?? "",
                                  artist: artist ?? "",
                                  album: album ?? "",
                                  song_id: songId ?? "",
                                  genre: genre ?? "")
                misTracks.append(track)
            }
            
            self.tableView.reloadData()
            
        } catch {
            print("Falle al obtener info de la BD, \(error), \(error.localizedDescription)")
        }
        
        self.downloadTraks()
        
    }
    
    func downloadTraks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        
        
        
        RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in
            misTracks = [Track]()
            if let _data = data {
                misTracks = _data
                
                //Usamos CoreData
                if let _context = context {
                    
                    //Eliminar contenido
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Tracks")
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    
                    do {
                        try appDelegate.persistentStoreCoordinator?.execute(deleteRequest, with: _context)
                    } catch {
                        print(error)
                    }
                    //FIN eliminar contenido
                    
                    
                    
                    //Agregamos contenido
                    for item in _data {
                        guard let tracksEntity = NSEntityDescription.insertNewObject(forEntityName: "Tracks", into: _context) as? NSManagedObject else {
                            return
                        }
                        
                        tracksEntity.setValue(item.artist, forKey: "artist")
                        tracksEntity.setValue(item.genre, forKey: "genre")
                        tracksEntity.setValue(item.album, forKey: "album")
                        tracksEntity.setValue(item.song_id, forKey: "song_id")
                        tracksEntity.setValue(item.title, forKey: "title")
                        
                        do {
                            try _context.save()
                        } catch {
                            print("No se guardo la info. \(error), \(error.localizedDescription)")
                        }
                    }
                    
                    
                }
                
                
                
                
                self.tableView.reloadData()
            }
        }
        /*
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTable(_:)),
                                               name: NSNotification.Name("updateTable"),
                                               object: nil)
        
        let _ = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: nil)
        }
         */
    }
    
    
    @objc func updateTable(_ notification: Notification) {
        
        misTracks.append(Track(title: "Nueva cancion", artist: "Nuevo artista", album: "Nuevo album", song_id: "0", genre: "Genero")) //, duration: "123"))
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return misTracks.count
    }

   
    //esto sirve para el espacio entre las secciones
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
       
        //configure the cell

        cell.backgroundColor = .clear
        cell.textLabel?.textColor = UIColor(named: "Color2")
        
        let track = misTracks[indexPath.row]
        cell.track = track
        cell.parent = self
        cell.titulo.text = track.title
        cell.artista.text = track.artist
        
        return cell
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        RestServiceManager.shared.getToServer(responseType: [Track].self, method: .get, endpoint: "songs") { status, data in
            misTracks = [Track]()
            if let _data = data {
                misTracks = _data
//        print(#function)
//        let callback: ([Track]?, Error?) -> () = { canciones, error in
//            if error != nil {
//                print("no se pudo obtener canciones")
//
//            }
//            else{
//                misTracks = canciones ?? []
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
            }
        }
//
//        let api = APIManager()
//        api.getMusic(completion: callback)
   }

}







extension TracksTableViewController: AudioPlayerViewControllerProtocol, ButtonOnCellDelegate{
  
    
    func buttonTouchedOnCell(aCell: UITableViewCell){
        view.endEditing(true)
        self.view.endEditing(true)
        
        guard let index = tableView.indexPath(for: aCell) else {return}
        let cancion = misTracks[index.item]
        let songTitle = cancion.title
        let songArtist = cancion.artist
        let favorites = [Int]()
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SongViewController") as? AudioPlayerViewController
        
        vc?.tituloCancion = songTitle
        vc?.artistaCancion = songArtist
        vc?.cancion = cancion
        vc?.delegate = self
        vc?.indexCancion = index[1]
        vc?.favorites = favorites
        
        self.present(vc!, animated: true)
        
    }
    
    func deleteTrack(trackLocation: Int) {
        let deletedTrack = misTracks.remove(at: trackLocation)
        print("Borraste \(deletedTrack.title)")
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("DATA RELOADED")
        }
        
       
    }
    
    
}
