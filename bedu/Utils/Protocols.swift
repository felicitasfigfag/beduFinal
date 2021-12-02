//
//  Protocolos.swift
//  bedu
//
//  Created by Felicitas Figuero Fagalde on 04/11/2021.
//
import Foundation
import UIKit

protocol ButtonOnCellDelegate {
    
    func buttonTouchedOnCell(aCell:UITableViewCell)
    
}
protocol TableViewControllerDelegate {
    func sendData(track: String)
}

protocol TracksPickerDelegate {
    func addTrack(track: Track)
}

//dos protocols son necesarios: delegate y

