import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack{
            Button("Log out", action: {
                model.logout()
            })
        }
        .padding()
    }
}
