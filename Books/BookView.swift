import SwiftUI

struct BookView: View {
    
    @State var book: Book
    
    var body: some View {
        Text(book.title)
    }
}
