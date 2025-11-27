import SwiftUI

struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let moviegoer: String
    let imageName: String
    let imageName2: String
}

struct MovieChartView: View {
    let movies: [Movie] = [
        Movie(title: "어쩔수가 없다", moviegoer: "누적관객수 20만", imageName: "어쩔수가 없다", imageName2: "f1 2"),
        Movie(title: "극장판 귀멸의 ...", moviegoer: "누적관객수 10만", imageName: "무한성", imageName2: "f1 2"),
            Movie(title: "F1 더 무비", moviegoer: "누적관객수 10만", imageName: "f1", imageName2: "f1 2"),
            Movie(title: "얼굴", moviegoer: "누적관객수 10만", imageName: "얼굴", imageName2: "f1 2"),
            Movie(title: "모노노케 히메", moviegoer: "누적관객수 10만", imageName: "모노노케 히메", imageName2: "f1 2")
        ]
        
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(movies) { movie in
                    
                    NavigationLink(destination: Text("\(movie.title) 상세 페이지")) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Image(movie.imageName)
                                .resizable().scaledToFit().frame(width: 140, height: 210)
                                
                            // MARK: - UI를 새 데이터에 맞게 수정
                            Text(movie.title)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.black)
                                .lineLimit(1)
                                
                            Text(movie.moviegoer)
                                .font(.system(size: 13))
                                .foregroundStyle(.gray)
                        }
                        .frame(width: 140)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        }
    }
    
}

struct ComingSoonView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("상영예정 영화 목록입니다.").font(.headline)
            Spacer()
        }
    }
}

// MARK: - '홈' 탭이 선택되었을 때 보여줄 콘텐츠 뷰
struct HomeContentView: View {
    @State private var selectedMenu: String = "무비차트"
    let menus = ["무비차트", "상영예정"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                ForEach(menus, id: \.self) { menu in
                    Button(action: {
                        self.selectedMenu = menu
                    }) {
                        Text(menu)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(selectedMenu == menu ? .black : .gray.opacity(0.5))
                    }
                }
            }
            .padding(.horizontal)
            
            if selectedMenu == "무비차트" {
                MovieChartView() // (가로 스크롤 뷰가 여기에 포함되어 있습니다)
            } else {
                ComingSoonView()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
    }
}


struct Home: View {
    @State private var selectedTab = "홈"
    let tabs = ["홈", "이벤트", "스토어", "선호극장"]
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                
                HStack {
                    Image("megaboxLogo2")
                        .resizable().scaledToFit().frame(height: 30)
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.vertical, 8)

                HStack(spacing: 25) {
                    ForEach(tabs, id: \.self) { tab in
                        Text(tab)
                            .font(.system(size: 17))
                            .fontWeight(selectedTab == tab ? .bold : .regular)
                            .foregroundStyle(selectedTab == tab ? .black : .gray)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    self.selectedTab = tab
                                }
                            }
                    }
                    Spacer()
                }
                .padding(.bottom, 15)
                .padding(.leading, 16)

                ZStack {
                    switch selectedTab {
                        
                    case "홈":
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            VStack(spacing: 0) {
                                
                                HomeContentView()
                                
                                VStack {
                                    HStack {
                                        Text("알고보면 더 재밌는 무비피드")
                                            .padding(.leading, 16)
                                            .padding(.trailing, 109)
                                        
                                        Button(action: {
                                            print("오른쪽 화살표 버튼 클릭됨")
                                        }) {
                                            Image(systemName: "arrow.right")
                                                .font(.system(size: 20, weight: .bold))
                                                .padding()
                                                .foregroundStyle(.black)
                                        }
                                        Spacer()
                                    }
                                     
                                    Image("무비피드")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 408, height: 221)
                                }
                                .padding(.bottom, 44)
                                
                                VStack {
                                    HStack {
                                        Image("모노노케 히메 2")
                                            .padding(.leading, 16)
                                        VStack {
                                            Text("9월, 메가박스의 영화들(1) - 명작들의 재개봉’")
                                            Text("<모노노케 히메>,<퍼펙트 블루>")
                                        }
                                        Spacer()
                                    }
                                    .padding(.bottom, 39)
                                     
                                    HStack {
                                        Image("얼굴 2")
                                            .padding(.leading, 16)
                                        VStack {
                                            Text("메가박스 오리지널 티켓 Re.37 <얼굴>")
                                            Text("영화 속 양극적인 감정의 대비")
                                        }
                                        Spacer()
                                    }
                                }
                                .padding(.bottom, 50)
                            }
                        }
                        
                    case "이벤트":
                        Text("이벤트 목록").font(.largeTitle)
                    case "스토어":
                        Text("스토어 상품들").font(.largeTitle)
                    case "선호극장":
                        Text("선호극장 정보").font(.largeTitle)
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    Home()
}
