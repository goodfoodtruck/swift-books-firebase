import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var model: ViewModel
    @State var mail = ""
    @State var password = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Email")
            TextField("Email", text: $mail)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            Text("Password")
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("OK", action: {
                model.login(mail: mail, password: password)
            })
            .padding()
        }
        .padding()
    }
}
