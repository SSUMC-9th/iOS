//
//  MobileOrderView.swift
//  mega
//
//  Created by 이경민 on 11/17/25.
//

import Foundation
import SwiftUI

struct MobileOrderView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing:0){
                    megaLogo
                        .padding(.bottom, 17)
                        .padding(.leading, 16)
                    theaterChange
                        .padding(.bottom, 26)
                    
                    quickOrderSection
                    
                    recommendedMenuSection
                        .padding(.bottom, 25)
                    bestMenuSection
                        
                    
                }
                
            }.frame(maxWidth: .infinity, maxHeight:.infinity)
                .background(Color.white)
                
        }
    }
    
    
    private var megaLogo: some View {
        HStack{
            Image("megaLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 149, height: 30, alignment: .leading)
            Spacer()
        }.frame(maxWidth: .infinity)
    }
    
    private var theaterChange: some View {
            HStack {
                HStack(spacing: 8) {
                    Image("map-pin")
                        .foregroundColor(.white)
                    Text("강남")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                }

                Spacer()

                Button {

                } label: {
                    Text("극장 변경")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color("purple03"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.white)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color("purple03"))
        }
    
    private var quickOrderSection: some View {
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    OrderCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("바로 주문")
                                .font(.system(size: 22, weight: .bold))

                            Text("이제 줄서지 말고\n모바일로 주문하고 픽업!")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)

                            Spacer()

                            Image(systemName: "popcorn")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .frame(height: 278)

                    VStack(spacing: 10) {
                        OrderCard {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("스토어 교환권")
                                        .font(.system(size: 18, weight: .bold))
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        
                                        Image(systemName: "ticket")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .foregroundStyle(Color.black)
                                    }
                                }
                            }
                        }
                        .frame(height: 130)

                        // 선물하기
                        OrderCard {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("선물하기")
                                        .font(.system(size: 18, weight: .bold))
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        Image(systemName: "gift")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .foregroundStyle(Color.black)
                                    }
                                }
                            }
                        }
                        .frame(height: 130)
                    }
                }

                OrderCard {
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("어디서든 팝콘 만나기")
                                .font(.system(size: 20, weight: .bold))

                            Text("팝콘 콜라 스낵 모든 메뉴 배달 가능!")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.gray)
                        }

                        Spacer()

                        Image(systemName: "motorcycle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(Color.black)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 25)
        }

        var recommendedMenus: [MenuItemModel] {
            [
                .init(title: "러브 콤보",  price: 10900, imageName: "loveCombo"),
                .init(title: "더블 콤보",  price: 24900, imageName: "doubleCombo"),
                .init(title: "디즈니 픽사 패키지", price: 15900, imageName: "pixarCombo")
            ]
        }

        private var recommendedMenuSection: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text("추천 메뉴")
                    .font(.system(size: 24, weight: .bold))

                Text("영화 볼때 뭐먹지 고민될 땐 추천 메뉴!")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.gray)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(recommendedMenus) { item in
                            RecommendedMenuCard(item: item)
                        }
                    }
                    .padding(.vertical, 4)
                    .padding(.trailing, 16)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
    
    
    var bestMenus: [MenuItemModel] {
        [
            .init(title: "싱글 콤보",  price: 10900, imageName: "loveCombo"),
            .init(title: "더블 콤보",  price: 24900, imageName: "doubleCombo"),
            .init(title: "러브 콤보 패키지", price: 15900, imageName: "loveCombo")
        ]
    }
    private var bestMenuSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("베스트 메뉴")
                .font(.system(size: 24, weight: .bold))

            Text("영화 볼때 뭐먹지 고민될 땐 추천 메뉴!")
                .font(.system(size: 13))
                .foregroundStyle(Color.gray)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(bestMenus) { item in
                        RecommendedMenuCard(item: item)
                    }
                }
                .padding(.vertical, 4)
                .padding(.trailing, 16)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .padding(.bottom, 10)
    }
}


#Preview("iPhone 11") {
    MobileOrderView()

}

#Preview("iPhone 16 Pro") {
    MobileOrderView()
}

