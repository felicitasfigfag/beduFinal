////
////  ViewDePrueba.swift
////  newbedu
////
////  Created by Felicitas Figuero Fagalde on 16/12/2021.
////
//
//import UIKit
//import AVFoundation
//
//class VideoViewController: UIViewController {
//
//    @IBOutlet var videoLayer: UIView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        playVideo()
//        
//    }
//    
//    func playVideo() {
//        guard let path = Bundle.main.path(forResource: "videoTemitas", ofType: "mp4") else {
//            return
//        }
//        
//       
//        let player = AVPlayer(url: URL(fileURLWithPath: path))
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.bounds
//        playerLayer.videoGravity = .resizeAspectFill
//        self.videoLayer.layer.addSublayer(playerLayer)
//        
//        player.play()
//        
////        videoLayer.bringSubviewToFront(img)
////        videoLayer.bringSubviewToFront(lbl)
////        videoLayer.bringSubviewToFront(signIn)
////        videoLayer.bringSubviewToFront(signUp)
////        videoLayer.bringSubviewToFront(stack)
//       
//    
//    }
//
//    
//}
