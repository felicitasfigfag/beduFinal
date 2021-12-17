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

protocol TracksPickerProtocol {
    func addTrack(track: Track)
}
protocol AudioPlayerViewControllerProtocol {
    func deleteTrack(trackLocation: Int)
}
protocol TracksDelegate {
    func addTrackto (track:Track)

}
//dos protocols son necesarios: delegate y

