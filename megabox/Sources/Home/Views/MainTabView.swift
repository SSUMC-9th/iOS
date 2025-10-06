import SwiftUI

struct MainTabView: View {

    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            Tab("홈", systemImage: "house.fill", value: 0) {
                HomeView()
            }


            Tab("바로 예매", systemImage: "magnifyingglass", value: 1) {
                HomeView()
            }
            
            
            Tab("모바일 오더", systemImage: "ticket.fill", value: 2) {
                HomeView()
            }
            
            
            Tab("마이 페이지", systemImage: "person.fill", value: 3) {
                ProfileView()
            }
        }
    }
}


#Preview {
    MainTabView()
}

