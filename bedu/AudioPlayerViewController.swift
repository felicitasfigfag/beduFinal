//
//  AudioPlayerViewController.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 05/11/2021.
//

import UIKit
import AudioPlayer

class AudioPlayerViewController: UIViewController {
    
    
    var isPlaying = true
    var song: AudioPlayer?
    var timer = Timer()
    var slider = UISlider()
    
    
    var buttonPlay: UIButton = {
    let button1=UIButton(type: .system)
        button1.setTitle("Play", for: .normal)
        button1.autoresizingMask = .flexibleWidth
        button1.translatesAutoresizingMaskIntoConstraints=true
//        button1.backgroundColor = UIColor(named: "Color2")
        button1.tintColor = UIColor(named: "Color2")
        button1.layer.cornerRadius = 10
        button1.autoresizingMask = .flexibleWidth
        button1.frame=CGRect(x: 40, y: 300, width: 40, height: 40)
        return button1
    }()
    


    var buttonPause : UIButton = {
    let button2=UIButton(type: .system)
        button2.setTitle("Stop", for: .normal)
//        button2.backgroundColor = UIColor(named: "Color2")
        button2.tintColor = UIColor(named: "Color2")
        button2.layer.cornerRadius = 10
        button2.autoresizingMask = .flexibleWidth
        button2.translatesAutoresizingMaskIntoConstraints=true
        button2.frame=CGRect(x: -40, y: 300, width: 40, height: 40)

        return button2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cancion = Bundle.main.url(forResource: "traicion2", withExtension: ".mp3")
        else {return}
        
        do{
            song =  try AudioPlayer(contentsOf: cancion)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                         selector: #selector(update), userInfo: nil, repeats: true)
           // song?.play()
        }catch{
            print("Ocurrio un error")
        }
        
      


        self.view.backgroundColor = UIColor(named: "Color1")
    
        let label1 = UILabel()
            label1.text = "TEMITAS player"
            label1.font = UIFont.systemFont(ofSize: 30)
            label1.textColor = UIColor(named: "Color2" )
            //label1.backgroundColor = UIColor(red:0.0, green: 1.0, blue: 0.5, alpha:0.75)
            label1.autoresizingMask = .flexibleWidth
            label1.translatesAutoresizingMaskIntoConstraints=true
            label1.frame=CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
            label1.textAlignment = .center
            self.view.addSubview(label1)
        
        
        
        
        buttonPlay.frame = CGRect(x: 20, y:100, width: 100, height: 40)
        buttonPlay.addTarget(self, action: #selector(play), for: .touchUpInside)
        self.view.addSubview(buttonPlay)


        buttonPause.frame=CGRect(x: 250, y: 100, width: 100, height: 40)
        buttonPause.addTarget(self, action: #selector(pause), for: .touchUpInside)
        self.view.addSubview(buttonPause)

        
        
        slider.autoresizingMask = .flexibleWidth
        slider.tintColor = .purple
        slider.translatesAutoresizingMaskIntoConstraints = true
        slider.frame=CGRect(x:20, y:150, width: self.view.frame.width-40, height: 50)
        guard let duration = song?.duration else {return}
        slider.maximumValue = Float(duration)
    
        self.view.addSubview(slider)
        slider.addTarget(self, action: #selector(timeSound), for: .touchUpInside)
        
        
        let label2=UILabel()
        label2.text="Volumen"
        label2.textColor = UIColor(named: "Color2")
        label2.autoresizingMask = .flexibleWidth
        label2.translatesAutoresizingMaskIntoConstraints=true
        label2.frame=CGRect(x: 40, y: 200, width: 100, height: 40)
        self.view.addSubview(label2)


        let slider2 = UISlider ()
        slider2.autoresizingMask = .flexibleWidth
        slider2.translatesAutoresizingMaskIntoConstraints=true
        slider2.frame=CGRect(x: 40, y:250, width: self.view.frame.width-60, height: 50)
        slider2.value = 1.0
        self.view.addSubview(slider2)
        slider2.addTarget(self, action: #selector(volumen), for: .valueChanged)
        
        
        if let laURL = Bundle.main.url(forResource: "stegosaurus-studio", withExtension: ".gif") {
            let elGIF = UIImage.animatedImage(withAnimatedGIFURL: laURL)
            let imgContainer = UIImageView(image: elGIF)
            imgContainer.autoresizingMask = .flexibleWidth
            imgContainer.translatesAutoresizingMaskIntoConstraints=true
            imgContainer.frame=CGRect(x: 0, y: 400, width: self.view.frame.width, height: 150)
            self.view.addSubview(imgContainer)
        }
        
    } ///if let laURL = Bundle.main.url(forResource: "stegosaurus-studio", withExtension: ".gif") {

    
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
        print("esta haciendo update")
        guard let tiempo = song?.currentTime else {return}
        slider.value = Float(tiempo)
    }
    @objc func pause(){
        song?.stop()
        timer.invalidate()
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
//    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        isPlaying = !(isPlaying)
//        if isPlaying {
//            print ("Reproduciendo")
//        }
//        else {
//            print ("NO se está Reproduciendo")
//        }
//    }
}
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo.png"))
