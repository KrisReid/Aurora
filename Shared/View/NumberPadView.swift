//
//  NumberPadView.swift
//  Aurora
//
//  Created by Kris Reid on 27/01/2021.
//

import SwiftUI



struct NumberPadView: View {
    
    @Binding var value: String
    var isVerify: Bool
    var rows = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", "delete.left"]
    
    var body: some View {
        
        VStack {
            GeometryReader { reader in
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), alignment: .center, spacing: 20, content: {
                    
                    ForEach(rows, id: \.self) { value in
                        Button(action: {
                            buttonAction(value: value)
                        }, label: {
                            ZStack{
                                
                                if value == "delete.left"{
                                    
                                    Image(systemName: value)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                                else{
                                    
                                    Text(value)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(width: getWidth(frame: reader.frame(in: .global)), height: getHeight(frame: reader.frame(in: .global)))
                            .background(Color.white)
                            .cornerRadius(10)
                        })
                        .disabled(value == "" ? true : false)
                    }
                    
                })
            }
            .padding()
        }
    }
    
    
    func getWidth(frame: CGRect) -> CGFloat {
        let width = frame.width
        let actualWidth = width - 40
        return actualWidth / 3
    }
    
    func getHeight(frame: CGRect) -> CGFloat {
        let height = frame.height
        let actualHeight = height - 40
        return actualHeight / 4
    }
    
    func buttonAction(value: String){
        if value == "delete.left" && self.value != ""{
            self.value.removeLast()
        }
        if value != "delete.left"{
            if isVerify{
                if self.value.count < 6{
                    self.value.append(value)
                }
            }
            else{
                self.value.append(value)
            }
        }
    }
    
}

struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadView(value: .constant("A"), isVerify: .random())
    }
}
