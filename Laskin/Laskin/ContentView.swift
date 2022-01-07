//
//  ContentView.swift
//  Laskin
//
//  Created by Kimmortal on 24.12.2021.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return Color.orange
        case .clear, .negative, .percent:
            return Color.orange
        default:
            return Color.black
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    
    @State var calc = "0"
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black, .gray, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            VStack{
                Spacer()
                // Text Display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .italic()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                //Our buttons
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 15){
                        ForEach(row, id: \.self) {item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label:{ Text(item.rawValue)
                                    .font(.system(size: 45))
                                    .frame(width: self.buttonWidth(item: item), height: self.buttoonHeight())
                                    .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(self.buttonWidth(item: item))
                            })
                        }}
                        .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(currentValue + runningValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(currentValue * runningValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            break
        case .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
                calc = number
            }
            else {
                self.value = "\(self.value)\(number)"
                self.calc = "\(self.calc)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat{
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttoonHeight () -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
