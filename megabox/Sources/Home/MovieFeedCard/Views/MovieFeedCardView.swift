import SwiftUI

struct MovieFeedCardView: View {
    let feed: MovieFeedCard
    
    var body: some View {
        HStack(alignment: .top) {
            // 썸네일
            Image(feed.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                
            Spacer().frame(width: 20)
            
            // 텍스트
            VStack(alignment: .leading) {
                Text(feed.title)
                    .font(.semiBold18)
                    .foregroundStyle(Color.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(feed.subTitle)
                    .font(.semiBold13)
                    .foregroundStyle(Color("gray03"))
                    .lineLimit(1)
                    .padding(.bottom, 12)     //
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 0)
    }
}

#Preview {
    MovieFeedCardView(feed: .init(title: "가나다라마바사아자차카타파하동해물과백두산이", subTitle:"subTitle", imageName: "feed_princess"))
}
