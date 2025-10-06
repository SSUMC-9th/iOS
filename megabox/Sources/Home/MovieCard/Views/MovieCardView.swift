import SwiftUI

struct MovieCardView: View {
    let movie: MovieCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(movie.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 148, height: 212)
                .cornerRadius(10)
            
            Button("바로 예매") {
                // 예매 액션 연결할 자리
            }
            .frame(width: 148)
            .font(.medium16)
            .foregroundStyle(Color("purple03"))
            .padding(.vertical, 8.5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("purple03"), lineWidth: 1)
            )
            
            Text(movie.title)
                .font(.bold22)
                .foregroundStyle(Color.black)
            
            Text(movie.audience)
                .font(.medium18)
                .foregroundStyle(Color.black)
        }
        .frame(width: 148)
    }
}

#Preview {
    MovieCardView(movie: .init(title: "제목", audience: "누적관객수", imageName: "void"))
}
