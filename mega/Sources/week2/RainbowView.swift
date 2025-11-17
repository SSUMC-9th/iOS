//
//  RainbowView.swift
//  mega
//
//  Created by 이경민 on 9/28/25.
//

import SwiftUI

struct RainbowView: View {
    var viewModel:RainbowViewModel = .init()
    @State private var navigationTrue:Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                colorCardGroup
                Spacer()
                bottomSelectColorGroup
            }
            .safeAreaPadding(EdgeInsets(top:47, leading:15, bottom:43, trailing:15))
            .navigationDestination(isPresented: $navigationTrue, destination: {
                ColorNavigationView(viewModel:viewModel)
            })
        }
    }
    
    private func makeColorCard(_ model:RainbowModel) -> some View{
        VStack(spacing:6, content:{
            Rectangle()
                .fill(model.returnColor())
            Text(model.returnColorName())
                .foregroundStyle(Color.black)
                .font(.title)
        })
        .frame(maxWidth:.infinity, minHeight: 110)
    }
    
    private var bottomSelectColorGroup:some View{
        VStack(spacing:70, content:{
//            Image(.appleWeek3)
//                .renderingMode(.template)
//                .fixedSize()
//                .foregroundStyle(viewModel.appleLogoColor ?? Color.black)
            
            Text("현재 선택된 색상: \(selectedColorName())")
                .font(.title)
                .foregroundStyle(Color.black)
        })
    }
    
    private func selectedColorName()->String{
        if let name = viewModel.selectedRainbowModel{
            return name.returnColorName()
        }else{
            return "아무것도 없음"
        }
    }
    
    private var colorCardGroup:some View{
        LazyVGrid(columns:Array(repeating:GridItem(.flexible(), spacing:40), count:3), spacing:26, content:{
            ForEach(RainbowModel.allCases, id:\.self, content:{rainbow in
                makeColorCard(rainbow)
                    .onTapGesture {
                        viewModel.selectedRainbowModel=rainbow
                        self.navigationTrue.toggle()
                    }
            })
        })
    }
    
}

#Preview {
    RainbowView()
}
