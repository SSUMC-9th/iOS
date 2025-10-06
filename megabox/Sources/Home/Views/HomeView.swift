import SwiftUI


struct HomeView: View {
    let headerTabItems: [String] = ["홈", "이벤트", "스토어", "선호극장"]
    @State private var selectedMovieTab = "무비차트"
    @State private var selectedTab: String = "홈"   // 현재 선택된 탭
    @State private var movieCardViewModel = MovieCardViewModel()
    @State private var movieFeedCardViewModel = MovieFeedCardViewModel()

    var body: some View {
        
        ZStack {
            Color.white
                .ignoresSafeArea()   // 안전 영역(노치, 홈바 영역)까지 채우기
            VStack{
                headerImage
                hearderTabGroup
                ScrollView {
                    movieTabGroup
                    movieCardGroup
                    movieFeedHeader
                        .padding(.top, 38.5)
                    movieFeedImage
                    movieFeedCardGroup
                        .padding(.top, 44)
                }
            }
            .padding(.horizontal, 16)     // 좌우 여백
        }
    }
    
    private var headerImage: some View {
        HStack{
            Image("homeMegaboxLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 25)
            Spacer()
        }
    }
    
    private var hearderTabGroup: some View {
        HStack{
            ForEach(headerTabItems, id: \.self) { title in
                Button {
                    selectedTab = title
                } label: {
                    Text(title)
                        .font(.semiBold24)
                        .foregroundColor(selectedTab == title ? .black : .gray)
                }
                .padding(.trailing)
            }
            Spacer()
        }
    }
    
    private var movieTabGroup: some View {// 탭 버튼
        HStack(spacing: 10) {
            Button(action: { selectedMovieTab = "무비차트" }) {
                Text("무비차트")
                    .font(.medium14)
                    .foregroundColor(selectedMovieTab == "무비차트" ? .white : Color("gray04"))
                    .padding(.horizontal, 18.5)
                    .padding(.vertical, 10.5)
                    .background(selectedMovieTab == "무비차트" ? Color("gray08") : Color("gray02"))
                    .cornerRadius(100)
            }
            
            Button(action: { selectedMovieTab = "상영예정" }) {
                Text("상영예정")
                    .font(.medium14)
                    .foregroundColor(selectedMovieTab == "상영예정" ? .white : Color("gray04"))
                    .padding(.horizontal, 18.5)
                    .padding(.vertical, 10.5)
                    .background(selectedMovieTab == "상영예정" ? Color("gray08") : Color("gray02"))
                    .cornerRadius(100)
            }
            Spacer()
        }
    }
    
    private var movieFeedHeader: some View {
        HStack {
            Text("알고 보면 더 재밌는 무비피드")
                .font(.bold24)
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Button(action: {
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
            }
        }
    }
    
    private var movieFeedImage: some View {
        Image("feed_main")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
    }
    
    private var movieCardGroup: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: 15, content: {
                ForEach(movieCardViewModel.movies) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie) // 상세 화면으로 이동
                    } label: {
                        MovieCardView(movie: movie)
                    }
                }
            })
        })
    }
    
    private var movieFeedCardGroup: some View {
        LazyVStack(spacing: 18, pinnedViews: []) {
            ForEach(movieFeedCardViewModel.feeds) { feed in
                MovieFeedCardView(feed: feed)
            }
        }
    }

}

#Preview {
    HomeView()
}


#Preview("iPhone 11") {
    HomeView()
}

#Preview("iPhone 16 Pro Max") {
    HomeView()
}
