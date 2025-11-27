import SwiftUI

struct MovieBookingView: View {
    @StateObject private var viewModel = MovieBookingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                movieSection
                    .padding(.bottom, 10)
                theaterSection
                
                if viewModel.canShowDates {
                    dateWeekSection
                }
                
                if viewModel.canShowTimes {
                    showtimeSection
                }

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

    private var dateWeekSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("날짜 선택")
                .font(.semiBold16)
                .foregroundColor(.black)

            // 7열 고정 (한 줄)
            let cols = Array(repeating: GridItem(.flexible(), spacing: 6), count: 7)

            LazyVGrid(columns: cols, spacing: 0) {
                ForEach(Array(viewModel.availableDates.enumerated()), id: \.offset) { idx, date in
                    let selected = viewModel.isSameDay(viewModel.selectedDate, date)

                    Button {
                        viewModel.selectedDate = date
                        
                        Task {
                            if let movie = viewModel.selectedMovie,
                               !viewModel.selectedTheaters.isEmpty,
                               let date = viewModel.selectedDate {
                                await viewModel.fetchShowtimes(for: movie, theaters: viewModel.selectedTheaters, date: date)
                            }
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Text(viewModel.day(date))
                                .font(.semiBold16)
                                .foregroundColor(selected ? .white
                                                         : viewModel.weekendColor(for: date, selected: false))
                            Text(viewModel.dayCaption(date))   // "오늘/내일/요일"
                                .font(.medium13)
                                .foregroundColor(selected ? .white : Color("gray05"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(selected ? Color("purple03") : .clear)
                        .cornerRadius(12)
                    }
                    .disabled(!viewModel.canShowDates)
                }
            }
        }
    }
    
    private var showtimeSection: some View {
        let groups: [TheaterShowtimes] = viewModel.showtimeGroups

        return VStack(alignment: .leading, spacing: 12) {
            ForEach(groups, id: \.id) { theater in
                TheaterBlock(theater: theater)
            }
        }
    }

    private struct TheaterBlock: View {
        let theater: TheaterShowtimes

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                // 극장명: 항상 왼쪽 정렬
                Text(theater.branch)
                    .font(.bold18)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                
                // 상영관/시간 유무에 따른 분기
                if theater.rooms.isEmpty {
                    Text("상영 정보가 없습니다")
                        .font(.medium14)
                        .foregroundColor(Color("gray05"))
                        .padding(.leading, 8)
                } else {
                    ForEach(theater.rooms, id: \.id) { room in
                        RoomRow(room: room)
                    }
                }
            }
            .padding(.bottom, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private struct RoomRow: View {
        let room: RoomShowtimes

        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(room.name)
                        .font(.semiBold14)

                    if let format = room.format {
                        Text(format)
                            .font(.medium08)
                            .foregroundColor(.gray)
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(room.times, id: \.id) { time in
                            Text(time.start)
                                .font(.semiBold14)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                                .background(Color("gray01"))
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }


}

#Preview {
    MovieBookingView()
}


#Preview("iPhone 11") {
    MovieBookingView()
}

#Preview("iPhone 16 Pro Max") {
    MovieBookingView()
}
