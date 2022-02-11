import Foundation
import Combine
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase
import simd

class ViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    @Published var books = [Book]()
    
    var db: Firestore!
    let settings = FirestoreSettings()
    
    
    
    init() {
        
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        db.collection("Books")
            .getDocuments() { (QuerySnapshot, err) in
                if let documents = QuerySnapshot?.documents {
                    print("Documents: \(documents)")
                    do {
                        self.books = try documents.compactMap({ document in
                            let book = try document.data(as: Book.self)
                            return book
                       })
                    } catch {
                        print("Something went wrong")
                    }
                }
            }
    }
}


// Firebase management
extension ViewModel {
    @MainActor
    func login(mail: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: mail, password: password)
                errorMessage = .none
                user = authResult.user
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            errorMessage = .none
            user = .none
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func addBook(title: String) {
        db.collection("Books").addDocument(data: ["title": "\(title)"]) { err in
            if let err = err {
                print("Something went wrong : \(err)")
            }
        }
        let book = Book(title: "\(title)")
        self.books.append(book)
    }
    
    func removeBook(at offsets: IndexSet) {
        offsets.forEach({ index in
            let book = books[index]
            db.collection("Books").document(book.id!).delete()
        })
        books.remove(atOffsets: offsets)
    }
}
