import SwiftUI

struct ContentView: View {
    
    @State var buttonColors: [Color] = Array(repeating: .clear, count: 16)
    @State var changedColors: [Color] = Array(repeating: .blue, count: 16)
    @State var isFirstButtonPressed = false
    @State var isSecondButtonPressed = false
    @State var firstButtonIndex = 0
    @State var secondButtonIndex = 0
    @State var highscore = 0
    @State var score = 0
    
    let colors: [Color] = [.red, .orange, .green, .yellow, .purple, .black, .gray, .brown]
    var current_color : Color = .blue
    var body: some View {
        VStack{
            Text("Highscore: \(highscore)")
                .padding(20)
                .font(.largeTitle)
            Text("Point: \(score)")
                .padding(.bottom ,30)
                .font(.largeTitle)
            VStack(spacing: 10) {
                ForEach((0..<4), id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach((0..<4), id: \.self) { col in
                            let index = row * 4 + col
                            Button("\(index + 1)") {
                                print("\(buttonColors[index])")
                                changedColors[index] = buttonColors[index]
                                if (isFirstButtonPressed == false)
                                {
                                    isFirstButtonPressed = true
                                    firstButtonIndex = index
                                    
                                }else if(isSecondButtonPressed == false)
                                {
                                    secondButtonIndex = index
                                    isSecondButtonPressed = true
                                    sendButtonIndex(index1: firstButtonIndex, index2: secondButtonIndex)
                                }
                            }
                            .frame(width: 80, height: 80)
                            .background(changedColors[index])
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                }
            }
            .onAppear {
                let numberOfColors = colors.count
                let repetitions = buttonColors.count / numberOfColors
                let colorArray = Array(repeating: colors, count: repetitions).flatMap { $0 }.shuffled()
                buttonColors = colorArray
            }
        }
        
    }
    
    func sendButtonIndex(index1: Int, index2: Int)
    {
        print("\(index1) && \(index2) pressed")
        if(buttonColors[index1] == buttonColors[index2])
        {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                changedColors[index1] = .white
                changedColors[index2] = .white
                score += 10
            }
        }
        else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                changedColors[index1] = .blue
                changedColors[index2] = .blue
                score -= -2
            }
        }
        isFirstButtonPressed = false
        isSecondButtonPressed = false
    }
}

#Preview {
    ContentView()
}
