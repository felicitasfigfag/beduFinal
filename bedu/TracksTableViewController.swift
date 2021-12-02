//
//  TableTableViewController.swift
//  bedu2
//
//  Created by Felicitas Figuero Fagalde on 03/11/2021.
//

import UIKit

class TracksTableViewController: UITableViewController, ButtonOnCellDelegate {

    var delegado : TableViewControllerDelegate?
    
    
    func buttonTouchedOnCell(aCell: UITableViewCell){
        view.endEditing(true)
        self.view.endEditing(true)
        
        guard let index = tableView.indexPath(for: aCell) else {return}
        let titleName = misTracks[index.item]
        self.delegado?.sendData(track: titleName.title)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SongViewController") as? AudioPlayerViewController
        self.present(vc!, animated: true)
        
        //let audioPlayer = AudioPlayerViewController()
        //self.present(audioPlayer, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .black
        
        self.tableView.rowHeight = 80
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
       // let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
       
        //configure the cell

        cell.backgroundColor = UIColor(named: "Color1")
        cell.textLabel?.textColor = UIColor(named: "Color2")
        
        let track = misTracks[indexPath.row]
        cell.track = track
        cell.parent = self
        cell.titulo.text = track.title
        cell.artista.text = track.artist
       
        return cell
        //para saber que fila dentro de que seccion va cada celda
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        let callback: ([Track]?, Error?) -> () = { canciones, error in
            if error != nil {
                print("no se pudo obtener canciones")
               
            }
            else{
                misTracks = canciones ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        let api = APIManager()
        api.getMusic(completion: callback)
    }

}


//extension AudioPlayerViewController: ViewCellToAudioPlayer {
//    func sendData(track: String) {
//        let track = misTracks[indexPath.row]
//        print("entre??")
//        print(track)
//        song.title = track
//    }
//}
