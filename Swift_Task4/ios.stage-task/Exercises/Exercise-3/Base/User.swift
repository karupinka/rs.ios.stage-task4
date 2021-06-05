import Foundation

struct User: Equatable, Hashable {
    let id: UUID
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}
