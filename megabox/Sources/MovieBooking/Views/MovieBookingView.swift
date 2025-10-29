import SwiftUI

struct MovieBookingView: View {
    @StateObject private var viewModel = MovieBookingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                movieSection
                    .padding(.bottom, 10)
                theaterSection
                Spacer()
            }
            .padding(16)
            .background(Color.white)
            //navBar 설정
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("영화별 예매")
                        .font(.bold22)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                }
            }
            .toolbarBackground(Color("purple03"), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    private var movieSection: some View {
        VStack {
            HStack {
                Text(viewModel.getAgeRatingText(for: viewModel.selectedMovie))
                    .font(.bold18)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(viewModel.getAgeRatingColor(for: viewModel.selectedMovie))
                    .cornerRadius(4)
                
                Text(viewModel.selectedMovie?.title ?? "영화를 선택하세요")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.leading, 37)
                
                Spacer()
                
                Button {
                    // 버튼 클릭 시 동작
                } label: {
                    Text("전체영화")
                        .font(.semiBold14)
                        .foregroundColor(.black)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 10)
                        .frame( alignment: .center)
                        .background(.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(Color("gray02"), lineWidth: 1)
                        )
                }
            }
            
            ScrollView(.horizontal, content: {
                LazyHStack( content: {
                    ForEach(viewModel.movies) { movie in
                        VStack {
                            Button {
                                viewModel.selectedMovie = movie
                            } label: {
                                Image(movie.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 62, height: 89)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                viewModel.selectedMovie?.id == movie.id
                                                ? Color("purple03")
                                                : Color.clear,
                                                lineWidth: 3
                                            )
                                    )
                            }
                        }
                    }
                })
            })
            //왜 여기 지정해줘야 위로 올라붙는지 모르겟음..,
            .frame(height: 89)
        }
    }

    private var theaterSection: some View {
        HStack(spacing: 12) {
            ForEach(viewModel.theaters, id: \.self) { theater in
                Button {
                    viewModel.toggleTheater(theater)
                } label: {
                    Text(theater)
                        .font(.semiBold16)
                        .foregroundStyle(
                            viewModel.selectedTheaters.contains(theater)
                            ? Color.white   // 선택됨
                            : Color("gray05")
                        )
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(
                            viewModel.selectedTheaters.contains(theater)
                            ? Color("purple03")   // 선택됨
                            : Color("gray01")
                        )
                        .foregroundColor(
                            viewModel.selectedTheaters.contains(theater)
                            ? .white : .black
                        )
                        .cornerRadius(15)
                }
                .disabled(!viewModel.canSelectTheater)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MovieBookingView()
}


#Preview("iPhone 11") {
    HomeView()
}

#Preview("iPhone 16 Pro Max") {
    HomeView()
}
