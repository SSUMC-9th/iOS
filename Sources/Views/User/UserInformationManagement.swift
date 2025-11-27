//
//  UserInformationMangement.swift
//  megabox
//
//  Created by 문인성 on 9/28/25.
//

import SwiftUI

struct UserInformationManagement: View {
    
    @AppStorage("saved_id") private var savedId: String = ""
    @AppStorage("saved_name") private var savedName: String = ""
    @State private var currentName: String = ""

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 26, height: 22)
                    
                    Spacer()
                }
                
                Text("회원정보 관리")
                    .font(.medium16)
            }
            .padding(.horizontal, 18)
            .padding(.top, 44)
            .padding(.bottom, 53)
            
            
            
            Text("기본정보")
                .font(.bold18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.bottom, 26)
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text(savedId)
                        .font(.medium18)
                        .padding(.horizontal, 16)
                }
                
                
                Divider()
                
                HStack {
                    TextField(savedName, text: $currentName)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 16)
                    
                    Button(action: {
                        savedName = currentName
                    }) {
                        Text("변경")
                            .foregroundStyle(Color("gray03"))
                            .frame(width: 38, height: 20)
                            .padding(.horizontal, 11)
                            .padding(.vertical, 5)
                            .background(.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(Color("gray02")), lineWidth: 1)
                            )
                    }
                }
                Divider()
                Spacer()
            }
        }
        
            
    }
}
        

#Preview {
    UserInformationManagement()
}
