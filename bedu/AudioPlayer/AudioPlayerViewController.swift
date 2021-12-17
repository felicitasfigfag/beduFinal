//  AudioPlayerViewController.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 05/11/2021.
//

import UIKit
import AudioPlayer
import CoreAudio
import CoreMedia
import AVFoundation

class AudioPlayerViewController: UIViewController {
    
    @IBOutlet var videoLayer: UIView!
    
   //var delegate:TableViewControllerDelegate?
    var delegate: AudioPlayerViewControllerProtocol?
    var delegadoPlaylist: TracksDelegate?
    var isPlaying = true
    var song: AudioPlayer?
    var tituloCancion: String?
    var artistaCancion: String?
    var indexCancion: Int?
    var cancion: Track?
    var timer = Timer()
    var slider = UISlider()
    var favorites = [Int]()
    let regFont = UIFont(name: "Fractul-Regular", size: 32)
    let medFont = UIFont(name: "Fractul-Medium", size: 32)
    let boldFont = UIFont(name: "Fractul-SemiBold", size: 32)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let cancion = Bundle.main.url(forResource: "songJB", withExtension: ".mp3")
        else {return}
        
        do{
            song =  try AudioPlayer(contentsOf: cancion)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(update), userInfo: nil, repeats: true)
           
        }catch{
            print("Ocurrio un error")
        }
        playVideo()
        play()
        
        
        
      //elementos

        let label1 = UILabel()
        label1.text = self.tituloCancion
        label1.font = UIFont(name: "Fractul-SemiBold", size: 36)
        label1.textColor = .white
        label1.autoresizingMask = .flexibleWidth
        label1.translatesAutoresizingMaskIntoConstraints=true
        label1.frame=CGRect(x: 0, y: 640, width: self.view.frame.width, height: 50)
        label1.textAlignment = .center
        self.view.addSubview(label1)
    
      
        
        let buttonPlay: UIButton = {
        let button1=UIButton(type: .system)
            button1.setImage(UIImage(systemName: "play.fill"), for: .normal )
            button1.autoresizingMask = .flexibleWidth
            button1.translatesAutoresizingMaskIntoConstraints=true
            button1.tintColor = .white
            button1.layer.cornerRadius = 10
            button1.autoresizingMask = .flexibleWidth
            //button1.frame=CGRect(x: 40, y: 650, width: 40, height: 40)
            return button1
        }()
        
        buttonPlay.frame = CGRect(x: 80, y: 500, width: 150, height: 100)
        buttonPlay.addTarget(self, action: #selector(play), for: .touchUpInside)
        self.view.addSubview(buttonPlay)



        let buttonPause : UIButton = {
        let button2=UIButton(type: .system)
            button2.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            button2.tintColor = .white
            button2.layer.cornerRadius = 10
            button2.autoresizingMask = .flexibleWidth
            button2.translatesAutoresizingMaskIntoConstraints=true
           // button2.frame=CGRect(x: -80, y: 680, width: 40, height: 40)
            return button2
        }()
        
        buttonPause.frame=CGRect(x: 200, y: 500, width: 150, height: 100)
        buttonPause.addTarget(self, action: #selector(pause), for: .touchUpInside)
        self.view.addSubview(buttonPause)
        
        
        slider.autoresizingMask = .flexibleWidth
        slider.tintColor = .purple
        slider.translatesAutoresizingMaskIntoConstraints = true
        slider.frame=CGRect(x:20, y: 700, width: self.view.frame.width-40, height: 50)
        guard let duration = song?.duration else {return}
        slider.maximumValue = Float(duration)
    
        self.view.addSubview(slider)
        slider.addTarget(self, action: #selector(timeSound), for: .touchUpInside)
   

        let slider2 = UISlider ()
        slider2.autoresizingMask = .flexibleWidth
        slider2.translatesAutoresizingMaskIntoConstraints=true
        slider2.frame=CGRect(x: 40, y:780, width: self.view.frame.width-60, height: 50)
        slider2.value = 1.0
        self.view.addSubview(slider2)
        slider2.addTarget(self, action: #selector(volumen), for: .valueChanged)
        
        
        //menu btn
        let menuBtn = UIButton(type: .system)
            menuBtn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
            menuBtn.autoresizingMask = .flexibleWidth
            menuBtn.translatesAutoresizingMaskIntoConstraints=true
            menuBtn.tintColor = .white
            menuBtn.layer.cornerRadius = 10
            menuBtn.autoresizingMask = .flexibleWidth

        //llamada al menu
        menuBtn.frame=CGRect(x: 350, y: 40, width: 40, height: 40)
        menuBtn.addTarget(self, action: #selector(menuFunc), for: .touchUpInside)
        menuBtn.menu = addMenuItems()
        menuBtn.showsMenuAsPrimaryAction = true
        self.view.addSubview(menuBtn)
        
        let closeBtn = UIButton(type: .system)
        closeBtn.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeBtn.autoresizingMask = .flexibleWidth
        closeBtn.translatesAutoresizingMaskIntoConstraints=true
        closeBtn.tintColor = .white
        closeBtn.layer.cornerRadius = 10
        closeBtn.autoresizingMask = .flexibleWidth
        
        closeBtn.frame=CGRect(x: 20, y: 40, width: 40, height: 40)
        closeBtn.addTarget(self, action: #selector(closeFunc), for: .touchUpInside)
        self.view.addSubview(closeBtn)
        
        
        
        
      
        
        
       
        
        
//        if let laURL = Bundle.main.url(forResource: "stegosaurus-studio", withExtension: ".gif") {
//            let elGIF = UIImage.animatedImage(withAnimatedGIFURL: laURL)
//            let imgContainer = UIImageView(image: elGIF)
//            imgContainer.autoresizingMask = .flexibleWidth
//            imgContainer.translatesAutoresizingMaskIntoConstraints=true
//            imgContainer.frame=CGRect(x: 0, y: 400, width: self.view.frame.width, height: 150)
//            self.view.addSubview(imgContainer)
//        }
        
    }

    
 @objc func botonPlayTouch(_ sender:UIButton!) {
        print("tocaste el botón Play")
     if(isPlaying){
         isPlaying = false
         song?.play()
         
     }
     else{
         isPlaying = !isPlaying
         song?.stop()     }
        
    }

    @objc func botonStopTouch(_ sender:UIButton!) {
       print("tocaste el botón Stop")
        song?.stop()
        
    }

    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if(isPlaying){
            isPlaying = false
            print("Me estoy reproduciendo")
            song?.play()
        }
        else{
            isPlaying = !isPlaying
            song?.stop()
        }
    }
    
    
    @objc func update(){
       
        guard let tiempo = song?.currentTime else {return}
        slider.value = Float(tiempo)
    }
    @objc func pause(){
        song?.stop()
        timer.invalidate()
        print("PAUSa")
        //traer un delegado de botonplay
            //self.botonPlay.performTwoStateSelection()
    }
    
 
    
    @objc func volumen(sender: UISlider){
        song?.volume = sender.value
    }

    @objc func play(){
       song?.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func timeSound(sender:UISlider){
        song?.stop()
        song?.currentTime = TimeInterval(sender.value)
        song?.play()
    }
    
    
    
    //--------------------------------------------------
    @IBAction func dismiss(_ sender: Any) {
       dismiss(animated: true, completion: nil)
     }
    @objc func menuFunc(){
        //song?.stop()
        //timer.invalidate()
        print("estos son mis tracks desde el menu")
        
        print(misTracks)
       
    }
    @objc func closeFunc(){
        print("dismiss")
       // self.botonPlay.performTwoStateSelection()
        pause()
        dismiss(animated: true, completion: nil)
       
    }
    
    
    func addMenuItems() -> UIMenu {
//        var like = Bool()
        let miCancion = self.cancion!
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
        
            
            UIAction(title: "Delete from Library",
                     image: UIImage(systemName: "trash"),
                     attributes: .destructive,
                     handler: {(_) in
                         print("Estas por eliminar \(self.tituloCancion!) de tu lista")
                         let alert=UIAlertController(title: "Estas por borrar \(self.tituloCancion!)", message: "Estas seguro?", preferredStyle: .alert)
                         let accept = UIAlertAction(title: "Yes", style:.default, handler: {(action:UIAlertAction!) in
                            
                             
                             self.delegate?.deleteTrack(trackLocation : self.indexCancion!)
                             self.pause()
                             let alert = UIAlertController(title: "Exito", message: "Borraste \(self.tituloCancion!)", preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{_ in
                                 self.dismiss(animated: true, completion: nil)
                             }))
                             self.present(alert, animated: true)
                             
                         })
                             let deny = UIAlertAction(title: "No", style:.default, handler: {(action:UIAlertAction!) in
                                 print("apretaste cancel")
                             })
                             
                         
                         
                             alert.addAction(accept)
                             alert.addAction(deny)
                         self.present(alert, animated: true, completion:nil)
            }),
            
            
            UIAction(title: "Download",
                     image: UIImage(systemName: "square.and.arrow.down"),
                     handler: {(_) in
                         DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
            }),
//            UIAction(title: "Add to a Playlist...",
//                     image: UIImage(systemName: "text.badge.plus"),
//                     handler: { [self](_) in
////                         let playlistView = PlayListDetailController()
////                         self.delegadoPlaylist = playlistView.self
////                         print("PLAYLIST DESDE AUDIOPLAYER______________________")
////                         print(playlistView.tracksArray )
////                         if self.delegadoPlaylist != nil {                          delegadoPlaylist?.addTrackto(track: miCancion as! Track)
////                        }
//
//                         let playlistView = PlayListDetailController()
//                         self.delegadoPlaylist = playlistView.self
//                         if self.delegadoPlaylist != nil {
//                             let track = miCancion
//                             self.delegadoPlaylist?.addTrackto(track: track as! Track)
//
//                             playlistView.playlist.reloadData()
//                         }
//                     }),
//
            
            UIAction(title: "Share Song...",
                     image: UIImage(systemName: "square.and.arrow.up"),
                     handler : { (_) in
                        //let songSelected = miCancion
                        let song = [self.artistaCancion, self.tituloCancion]
                        let ac = UIActivityViewController(activityItems: song as [Any], applicationActivities: nil)
                        ac.popoverPresentationController?.sourceView = self.view
                        self.present(ac, animated: true)
            }),
         

            UIAction(title: cancion!.like == true ? "Unlove" : "Love",
                     image: cancion!.like == true ?  UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"))
                       {_ in
                        
                         
                           if self.cancion!.like == true  {
                               self.cancion!.like = false
                               print("YA no te gusta")
                               print("LIKE = ", self.cancion!.like)
                               
                               let alert=UIAlertController(title: "Ya no te gusta", message: self.tituloCancion!, preferredStyle: .alert)
                               var imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
                               imageView.image = UIImage(systemName: "heart")
                               alert.view.addSubview(imageView)
                               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{_ in
                                  // self.dismiss(animated: true, completion: nil)
                               }))
                               self.present(alert, animated: true)
                               
                         }else{
                             self.cancion!.like = true
                             print("TE gusta")
                             print("LIKE = ", self.cancion!.like)
                             let alert=UIAlertController(title: "Te gusta", message: self.tituloCancion!, preferredStyle: .alert)
                             var imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
                             imageView.image = UIImage(systemName: "heart.fill")
                             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{_ in
                                 //self.dismiss(animated: true, completion: nil)
                             }))
                             alert.view.addSubview(imageView)
                             self.present(alert, animated: true)
                         }
            },
        ])
        return menuItems
    }
    
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "videoTemitas", ofType: "mp4") else {
            return
        }
        
       
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.videoLayer.layer.addSublayer(playerLayer)
        
        player.play()
        
    
    }

}
