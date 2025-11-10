import Foundation
import Combine

final class UserSession: ObservableObject {
    static let shared = UserSession()
    private init() {}

    @Published var isLoggedIn: Bool = false
    @Published var displayName: String = ""
}
