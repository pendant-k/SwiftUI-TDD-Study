import SwiftUI

struct ContentView: View {
    @State private var total: String = ""
    @State private var tipPercentage: Double = 0.2
    @State private var tip: String?
    @State private var message: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter total", text: $total)
                    .textFieldStyle(.roundedBorder)
                
                Picker(selection: $tipPercentage) {
                    Text("10%").tag(0.1)
                    Text("20%").tag(0.2)
                    Text("30%").tag(0.3)
                } label: {
                    EmptyView()
                }.pickerStyle(.segmented)

                Button("Calculate Tip") {}.padding(.top, 20)
                
                Text(message)
                    .padding(.top, 50)
                
                Spacer()
                
                Text(tip ?? "")
                    .font(.system(size: 54))
                
                Spacer()
                    .navigationTitle("Tip Calculator")
            }.padding()
        }
    }
}

#Preview {
    ContentView()
}
