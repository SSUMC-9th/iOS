//
//  MemberInfoView.swift
//  megabox
//
//  Created by 김세은 on 9/28/25.
//

import SwiftUI

struct MemberInfoView: View {
    // AppStorage: 로그인 시 저장된 ID와 이름 불러오기
    @AppStorage("savedId") private var savedId: String = ""
    @AppStorage("savedName") private var savedName: String = ""
    
    @State private var tempName: String = ""   // TextField 임시 값
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()   // 안전 영역(노치, 홈바 영역)까지 채우기
            
            VStack {
                navigatorView
                
                infoTextView
                    .padding(.top, 53)
                
                infoView
                    .padding(.top, 26)
                Spacer()   // 아래는 남는 공간 차지
            }
            .padding(.horizontal, 16)
        }.onAppear {
            savedId = KeychainHelper.shared.read(forKey: "savedId") ?? ""
            savedName = KeychainHelper.shared.read(forKey: "savedName") ?? ""
            tempName = savedName
        }
    }
    
    private var navigatorView:some View {
        HStack {
            Button(action: {
                //뒤로가기
            }) {
                Image("left-Button")
            }
            .frame(width: 26, height: 22)
            Spacer()
            
            Text("회원정보 관리")
                .font(.system(size: 16, weight: .semibold))
            
            Spacer()
        }
    }
    
    
    private var infoTextView:some View {
        Text("기본정보")
            .font(.bold18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
    }
    
    private var infoView: some View{
        VStack{
            HStack {
                Text(savedId) // AppStorage에서 불러온 값
                    .font(.medium18)
                Spacer()
            }
            Divider()
            HStack {
                TextField("이름 입력", text: $tempName)
                    .font(.medium18)
                
                Button("변경") {
                    savedName = tempName   // AppStorage에 저장
                }
                .foregroundStyle(Color("gray03"))
                .font(.medium10)
                .padding(.horizontal, 11)
                .padding(.vertical, 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            .padding(.top, 24)
            
            Divider()
        }
    }
}

#Preview {
    MemberInfoView()
}

#Preview("iPhone 11") {
    MemberInfoView()
}

#Preview("iPhone 16 Pro Max") {
    MemberInfoView()
}
