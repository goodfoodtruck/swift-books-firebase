import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ViewModel
    @State var title = ""
    
    var body: some View {
        VStack {
            if let user = model.user {
                VStack {
                    Text("Hello, \(user.email ?? "")")
                    
                    NavigationView {
                        List {
                            ForEach(model.books, id: \.id) { book in
                                NavigationLink(destination: BookView(book: book)) {
                                    Text(book.title)
                                }
                            }.onDelete(perform: model.removeBook)
                        }
                    }
                    
                    TextField("Entrer le titre du livre à ajouter", text: $title)
                    Button("Ajouter", action: { model.addBook(title: title) })
                }
            } else {
                LoginView()
            }
            
            if let errorMessage = model.errorMessage{
                Text(errorMessage)
                    .padding()
                    .foregroundColor(.red)
            }
            
        }.padding()
    }
}
