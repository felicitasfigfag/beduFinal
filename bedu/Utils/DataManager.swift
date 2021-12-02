//
//  DataManager.swift
//  bedu
//
// //  Created by Felicitas Figuero Fagalde on 09/11/2021.
//

import Foundation

class DataManager {
    static func cancionesPorGenero(canciones:[Track]) -> [Track] {
        return canciones.filter { $0.genre != nil }
    }
}
