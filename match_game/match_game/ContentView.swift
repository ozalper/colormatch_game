import SwiftUI

struct ContentView: View {
    
    @State var buttonColors: [Color] = Array(repeating: .clear, count: 16)
    @State var changedColors: [Color] = Array(repeating: .blue, count: 16)
    @State var isFirstButtonPressed = false
    @State var isSecondButtonPressed = false
    @State var firstButtonIndex = 0
    @State var secondButtonIndex = 0
    @State var score = 0
    @State var whiteColorCounter = 0
    
    @State var highscore = UserDefaults.standard.integer(forKey: "highscore")
    
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
                                if changedColors[index] != .white {
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
                                checkButtons(colorlist: changedColors)
                            }
                            .frame(width: 80 ,height: 80)
                            .background(changedColors[index])
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            
                            
                        }
                    }
                }
            }
            Button("Restart")
            {
                if score >= highscore
                {
                    highscore = score
                    UserDefaults.standard.set(highscore, forKey: "highscore")
                }
                randomColorGenerator()
                changedColors = Array(repeating: .blue, count: 16)
                score = 0
                
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: 80)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
            
        }
        .onAppear {
            randomColorGenerator()
            
        }
        
    }
    
    func randomColorGenerator()
    {
        let numberOfColors = colors.count
        let repetitions = buttonColors.count / numberOfColors
        let colorArray = Array(repeating: colors, count: repetitions).flatMap { $0 }.shuffled()
        buttonColors = colorArray
    }
    
    func checkButtons(colorlist: [Color?]) {
        whiteColorCounter = 0
        let number = colorlist.count
        
        for index in 0..<number {
            if colorlist[index] == .white {
                whiteColorCounter += 1
            }
        }
        
        
        print(whiteColorCounter)
        
    }
    
    func sendButtonIndex(index1: Int, index2: Int)
    {
        print("\(index1) && \(index2) pressed")
        if(buttonColors[index1] == buttonColors[index2])
        {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                changedColors[index1] = .white
                changedColors[index2] = .white
                score = score + 10
                
            }
        }
        else
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                changedColors[index1] = .blue
                changedColors[index2] = .blue
                score = score - 2
            }
        }
        isFirstButtonPressed = false
        isSecondButtonPressed = false
        if score >= highscore
        {
            highscore = score
            UserDefaults.standard.set(highscore, forKey: "highscore")
        }
    }
}

#Preview {
    ContentView()
}
