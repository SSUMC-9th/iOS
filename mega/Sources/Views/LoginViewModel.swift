//
//  LoginViewModel.swift
//  mega
//
//  Created by 이경민 on 9/21/25.
//

import Foundation
import SwiftUI
import Observation

@Observable
class LoginViewModel{
    var loginModel:LoginModel
    
    // LoginViewModel 생성시 LoginModel 초기화
    init(loginModel:LoginModel){
        self.loginModel = loginModel
    }
    
}
