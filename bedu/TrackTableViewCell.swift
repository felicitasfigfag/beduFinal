//
//  TrackTableViewCell.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 20/11/2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    var track:Track?
    var parent:ButtonOnCellDelegate?
    
   
    
    var icono: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "nota")
        imgView.backgroundColor = .white
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var titulo: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "Color2")
        lbl.text = "titulo"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var artista: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.text = "artista"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    //aca tomarlo con un evento y mandarle la funcion
    var botonPlay: PlayButton = {
        let btn = PlayButton()
      //  btn.setImage(UIImage(named:"play"), for: .normal)
        
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .clear
        btn.icon = UIImage(named: "play")
        btn.secondIcon = UIImage(named: "pause")
        btn.performTwoStateSelection()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
//    var botonMenu: MenuButton = {
//        let btn = MenuButton()
//        btn.layer.cornerRadius = 25
//        btn.backgroundColor = .clear
//        //btn.icon = UIImage(systemName: "ellipsis")
//        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.menu = addMenuItems()
//        btn.showsMenuAsPrimaryAction = true
//
//    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(icono)
        NSLayoutConstraint.activate([
            icono.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            icono.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            icono.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            icono.widthAnchor.constraint(equalTo: icono.heightAnchor)
        ])
        addSubview(botonPlay)
        NSLayoutConstraint.activate([
            botonPlay.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            botonPlay.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            botonPlay.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            botonPlay.widthAnchor.constraint(equalTo: botonPlay.heightAnchor)
        ])
        botonPlay.addTarget(self, action: #selector( self.botonPlayTouch(_ :)), for:.touchUpInside)
        
//        addSubview(botonMenu)
//        NSLayoutConstraint.activate([
//            botonMenu.topAnchor.constraint(equalTo: topAnchor, constant: 15),
//            botonMenu.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
//            botonMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
//            botonMenu.widthAnchor.constraint(equalTo: botonMenu.heightAnchor)
//        ])
//        botonMenu.addTarget(self, action: #selector(menuFunc), for:.touchUpInside)
//
        addSubview(titulo)
        NSLayoutConstraint.activate([
            titulo.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titulo.heightAnchor.constraint(equalToConstant: 35),
            titulo.leadingAnchor.constraint(equalTo: icono.trailingAnchor, constant: 5),
            titulo.trailingAnchor.constraint(equalTo: botonPlay.leadingAnchor, constant: -5)
        ])
        addSubview(artista)
        NSLayoutConstraint.activate([
            artista.heightAnchor.constraint(equalToConstant: 35),
            artista.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            artista.leadingAnchor.constraint(equalTo: icono.trailingAnchor, constant: 5),
            artista.trailingAnchor.constraint(equalTo: botonPlay.leadingAnchor, constant: -5)
        ])
        contentView.isUserInteractionEnabled = false
        
        
   
        
        
    }


//
   @objc func botonPlayTouch(_ sender:UIButton!) {
       botonPlay.performTwoStateSelection()
       
       if parent != nil {
           parent?.buttonTouchedOnCell(aCell: self)
           
//           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//               self.botonPlay.performTwoStateSelection()
//           }
       }
        else{
            print("TOUCH")
            }
    }
   
//    el gotoaudio no me lo agarra
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  } 
