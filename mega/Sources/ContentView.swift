//
//  ContentView.swift
//  mega
//
//  Created by 이경민 on 9/28/25.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some View {
        if isLoggedIn {
            MegaNavigation()
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}
