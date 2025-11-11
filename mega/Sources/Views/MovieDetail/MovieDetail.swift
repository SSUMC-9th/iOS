//
//  MovieDetail.swift
//  mega
//
//  Created by 이경민 on 9/30/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct MovieDetail: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab: MovieDetailTab = .info

    let card: MovieCardModel

    @State private var vm = MovieDetailViewModel()

    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar
                .padding(.horizontal, 16)

            movieSummarize
                .padding(.bottom, 35)

            movieTabHeader
                .padding(.bottom, 17)

            if selectedTab == .info {
                movieSubInfo
                    .padding(.horizontal, 16)
            } else {
                reviewSection
                    .padding(.horizontal, 16)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(card.title)
        .toolbar(.hidden, for: .navigationBar)
        .animation(.easeInOut, value: selectedTab)
        .task { await vm.load(movieId: card.id) }
    }

    private var topNavigationBar: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.black)
            }
            Spacer()
            Text(card.title)
                .font(.PretendardRegular16)
                .foregroundColor(.black)
            Spacer()
                .frame(width: 150)
        }
        .frame(maxWidth: .infinity, minHeight: 54)
    }

    private var movieSummarize: some View {
        VStack(alignment: .leading, spacing: 8) {
            KFImage(vm.detail?.backdropURL)
                .placeholder {
                    ZStack {
                        Rectangle().fill(Color.gray.opacity(0.1))
                        ProgressView()
                    }
                }
                .retry(maxCount: 2, interval: .seconds(1))
                .cancelOnDisappear(true)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)


            VStack(alignment: .leading, spacing: 2) {
                Text(card.title)
                    .font(.bold24)

                HStack(spacing: 6) {
                    Text(vm.detail?.title ?? "")
                        .font(.semiBold14)
                        .foregroundStyle(Color("gray03"))
                    if let date = vm.detail?.releaseDate {
                        Text("· \(date)")
                            .font(.semiBold14)
                            .foregroundStyle(Color("gray03"))
                    }
                }
            }
            .padding(.horizontal, 16)

            Text(vm.detail?.overview ?? "")
                .font(.PretendardRegular16)
                .foregroundStyle(Color("gray03"))
                .lineSpacing(4)
                .padding(.top, 10)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 16)
        }
    }

    private var movieTabHeader: some View {
        HStack(spacing: 0) {
            Button {
                withAnimation(.easeInOut) { selectedTab = .info }
            } label: {
                VStack(spacing: 4) {
                    Text("상세 정보").font(.bold22)
                        .foregroundStyle(selectedTab == .info ? Color.black : Color("gray03"))
                    Rectangle().fill(selectedTab == .info ? Color.black : .clear).frame(height: 2)
                }
                .frame(maxWidth: .infinity, minHeight: 35)
            }
            Button {
                withAnimation(.easeInOut) { selectedTab = .reviews }
            } label: {
                VStack(spacing: 4) {
                    Text("실관람평").font(.bold22)
                        .foregroundStyle(selectedTab == .reviews ? Color.black : Color("gray03"))
                    Rectangle().fill(selectedTab == .reviews ? Color.black : .clear).frame(height: 2)
                }
                .frame(maxWidth: .infinity, minHeight: 35)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 35)
    }

    private var movieSubInfo: some View {
        HStack(spacing: 0) {
            KFImage(card.posterURL)
                .placeholder { ProgressView() }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .cornerRadius(6)

            VStack(alignment: .leading) {
                Text("\(vm.detail?.ageRating ?? 12)세 이상 관람")
                    .font(.semiBold13)
                    .padding(.bottom, 9)

                Text("평점 \(vm.detail?.voteAverage ?? 0, specifier: "%.1f")")
                    .font(.semiBold13)
                Spacer()
            }
            .padding(.leading, 13)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
    }

    private var reviewSection: some View {
        VStack { Text("등록된 관람평이 없어요")
            .font(.semiBold18) }
            .frame(maxWidth: .infinity, minHeight: 141)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color("purple02"), lineWidth: 1))
    }
}
