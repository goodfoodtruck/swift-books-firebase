import Foundation
import FirebaseFirestoreSwift

struct Book: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
}
