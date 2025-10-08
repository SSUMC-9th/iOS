//
//  Home2.swift
//  megabox
//
//  Created by 문인성 on 10/1/25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ScrollView {
            HStack {
                Image("megaboxLogo2")
                    .padding(.leading, 16)
                    .padding(.top)
                Spacer()
            }
            
        }
    }
}

#Preview {
    Home()
}
