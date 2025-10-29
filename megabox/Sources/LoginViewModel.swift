//
//  LoginViewModel.swift
//  megabox
//
//  Created by 문인성 on 9/25/25.
//

import Foundation

@Observable
class LoginViewModel: ObservableObject {
    var loginInfo = LoginModel()
    var isLoggedIn: Bool = false
}
