import SwiftUI

struct MovieDetailView: View {
    let movie: MovieCard
    @State private var viewModel = MovieDetailViewModel()
    @State private var selectedTab = "상세정보"
    
    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()   // 안전 영역(노치, 홈바 영역)까지 채우기
            ScrollView {
                if let detail = viewModel.getDetail(for: movie) {
                    VStack(spacing: 20) {
                        Image(detail.detailImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                        
                        // 영화 정보
                        VStack {
                            Text(detail.title)
                                .font(.bold24)
                            Text(detail.englishTitle)
                                .font(.semiBold14)
                                .foregroundStyle(Color("gray03"))
                                .padding(.bottom, 9)
                            Text(detail.description)
                                .font(.semiBold18)
                                .foregroundStyle(Color("gray03"))
                        }
                        .padding(.horizontal, 16)
                        
                        
                        // 세그먼트 버튼
                        HStack(spacing: 0) {
                            segmentButton("상세정보")
                            segmentButton("실관람평")
                        }
                        
                        // 세그먼트 내용
                        VStack {
                            if selectedTab == "상세정보" {
                                detailInfoView(detail)
                            } else {
                                reviewEmptyView
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                } else {
                    Text("상세 정보를 찾을 수 없습니다 😢")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func segmentButton(_ title: String) -> some View {
        Button {
            selectedTab = title
        } label: {
            VStack(spacing: 4) {
                Text(title)
                    .font(.bold22)
                    .foregroundColor(selectedTab == title ? .black : Color("gray02"))
                Rectangle()
                    .fill(selectedTab == title ? .black : Color("gray02"))
                    .frame(height: 2)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private func detailInfoView(_ detail: MovieDetail) -> some View {
        HStack {
            Image(movie.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 120)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(detail.ageRating)
                    .font(.semiBold13)
                    .foregroundStyle(Color.black)
                Text(detail.releaseDate)
                    .font(.semiBold13)
                    .foregroundStyle(Color.black)
                    .padding(.top, 9)
                Spacer()
            }
            Spacer()
        }
    }
    
    private var reviewEmptyView: some View {
        HStack(alignment: .center, spacing: 10) {
            Text("등록된 관람평이 없어요 😢")
                .font(.semiBold18)
                .foregroundStyle(Color("gray08"))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 60)
        }
        .cornerRadius(10)
        .overlay(
          RoundedRectangle(cornerRadius: 10)
            .inset(by: 0.5)
            .stroke(Color("purple02"), lineWidth: 1)
        )
    }
}

#Preview("예시 - f1") {
    let sampleCard = MovieCard(
        title: "F1 더 무비",
        audience: "누적관객수 250만명",
        imageName: "poster_f1"
    )
    
    return NavigationStack {
        MovieDetailView(movie: sampleCard)
    }
}
