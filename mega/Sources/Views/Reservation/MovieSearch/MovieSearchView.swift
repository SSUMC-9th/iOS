//
//  MovieSearchView.swift
//  mega
//
//  Created by 이경민 on 10/7/25.
//
import SwiftUI

struct MovieSearchView: View {
    @StateObject private var viewModel = MovieSearchViewModel()
    @Binding var selectedMovie: ReservModel?
    @Environment(\.dismiss) var dismiss
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack(spacing: 0) {
            Text("영화 선택")
                .font(.headline)
                .padding(.vertical, 20)
            
            ZStack {
                Color(.white).ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(Color("gray03"))
                } else if viewModel.results.isEmpty {
                    Text("검색 결과가 없습니다.")
                        .foregroundStyle(Color("gray03"))
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.results) { movie in
                                MoviePosterCard(movie: movie)
                                    .onTapGesture {
                                        self.selectedMovie = movie
                                        dismiss()
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            SearchBar(searchText: $viewModel.query)
                .padding()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

private struct MoviePosterCard: View {
    let movie: ReservModel

    var body: some View {
        VStack {
            movie.movieImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(movie.movieName)
                .font(.semiBold14)
                .lineLimit(1)
        }.frame(width:95, height:163)
    }
}
private struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            
            TextField("영화명을 입력해주세요", text: $searchText)
            
            if !searchText.isEmpty {
                Button(action: { self.searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    MovieSearchView(selectedMovie: .constant(nil))
}
