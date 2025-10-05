//
//  ReservModel.swift
//  mega
//
//  Created by 이경민 on 10/5/25.
//

import SwiftUI
import Foundation

struct ReservModel:Identifiable{
    let id: UUID = UUID()
    let movieImage: Image
    let movieName: String
    let movieEngName: String
    let movieReserCount: String
}
