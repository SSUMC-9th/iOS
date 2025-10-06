//
//  LoginViewModel.swift
//  megabox
//
//  Created by 김세은 on 9/27/25.
//
import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginModel: LoginModel
    
    init(loginModel: LoginModel) {
        self.loginModel = loginModel
    }

}
