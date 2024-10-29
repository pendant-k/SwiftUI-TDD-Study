import SwiftUI

struct ContentView: View {
    @State private var total: String = ""
    @State private var tipPercentage: Double = 0.2
    @State private var tip: String?
    @State private var message: String = ""
    
    let tipCalculator = TipCalculator()
    
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

                // error catch -> UI에서 캐치해서 message 업데이트
                // 각 네트워크가 필요한 컴포넌트마다 컴포넌트 status를 두는 것도 좋을듯
                // 공용 component status enum ?
                Button("Calculate Tip") {
                    message = ""
                    tip = ""
                    
                    do {
                        guard let total = Double(self.total) else {
                            throw TipCalculatorError.invalidInput
                        }
                        
                        let result = try tipCalculator.calculate(total: total, tipPercentage: tipPercentage)
                        
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .currency
                        tip = formatter.string(from: NSNumber(value: result))
                        
                    } catch TipCalculatorError.invalidInput {
                        message = "Invalid Input"
                    } catch {
                        message = error.localizedDescription
                    }
                    
                }.padding(.top, 20)
                
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
