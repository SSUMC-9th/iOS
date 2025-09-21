//
//  UserInfoManage.swift
//  mega
//
//  Created by 이경민 on 9/21/25.
//

import Foundation
import SwiftUI

struct UserInfoManage: View {
    @AppStorage("userId") private var userId: String = "kmin817"
    @AppStorage("userName") private var storedUserName: String = ""
    @State private var tempName: String = ""
    
    var body: some View {
        VStack{
            
            topNav
                .padding(.horizontal, 14)
            
            Spacer().frame(height:53)
            
            mainContent
                .padding(.horizontal, 14)
            
        }
        .onAppear {
                tempName = storedUserName
            }
        Spacer()
        
    }
    
    private var topNav: some View {
        HStack{
            Button(action:{
                //  뒤로 가는 액션 구현
            }){
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width:26, height:22)
                    .foregroundColor(Color.black)
            }.frame(width: 30, height: 44, alignment: .center)
            
            Spacer()
            
            Text("회원정보 관리")
                .font(.system(size:16, weight:.medium))
                .foregroundColor(.black)
            
            Spacer()
            
            Color.clear.frame(width: 30, height: 44)
        }
        .padding(.horizontal)
        .frame(height:44)
        
    }
    
    private var mainContent: some View {
        VStack(alignment: .leading){
            Text("기본정보")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 4)
            
            // 아이디
            Text(userId)
                .font(.system(size: 14))
                .foregroundColor(Color.black)
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
            
            Divider().padding(.bottom, 24)
            
            HStack{
                TextField("이곳에 입력하세요", text: $tempName)
                    .font(.system(size:14))
                    .padding(.top, 8)
                
                Button(action:{
                    storedUserName = tempName
                }){
                    Text("변경")
                        .frame(width:38, height:20)
                        .font(.system(size:12, weight:.bold))
                        .foregroundColor(Color("gray03"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("gray03"), lineWidth: 1)
                        )
                }
            }
            
            Divider()
        }
    }
    
}



#Preview {
    UserInfoManage()
}
