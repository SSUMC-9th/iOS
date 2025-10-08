//
//  ContentView.swift
//  megabox
//
//  Created by 문인성 on 10/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = LoginViewModel()

    var body: some View {
        if viewModel.isLoggedIn {
            Home()
                .environment(viewModel)
        } else {
            LoginView(viewModel: LoginViewModel())
                .environment(viewModel)
        }
    }
}
