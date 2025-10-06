import SwiftUI

@Observable
class MovieFeedCardViewModel {
    var feeds: [MovieFeedCard] = [
        MovieFeedCard(title: "9월, 메가박스의 영화들(1) - 명작들의 재개봉", subTitle: "<모노노케 히메>,<퍼펙트 블루>", imageName: "feed_princess"),
        MovieFeedCard(title: "메가박스 오리지널 티켓 Re.37 <얼굴>", subTitle: "영화 속 양극적인 감정의 대비", imageName: "feed_face"),
    ]
}
