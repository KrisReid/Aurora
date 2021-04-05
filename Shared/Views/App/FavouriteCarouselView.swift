//
//  FavouriteCarouselView.swift
//  Aurora
//
//  Created by Kris Reid on 30/03/2021.
//

import SwiftUI

struct FavouriteCarouselView: View {
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let x = proxy.frame(in: .global).minX
        
        let diff = abs(x)
        if diff < 100 {
            scale = 1 + (100 - diff) / 600
        }
        
        
        return scale
    }
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Text("Favourites")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .padding(.horizontal)
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack (spacing: 40) {
                    ForEach(0..<20, id: \.self)  { num in
                        GeometryReader { proxy in
                            NavigationLink(
                                destination: Image("Sandra"),
                                label: {
                                    VStack {
                                        let scale = getScale(proxy: proxy)
                                        
                                        Image("Sandra")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 64, height: 64, alignment: .center)
                                            .overlay(Circle().stroke(lineWidth: 0.5))
                                            .clipped()
                                            .cornerRadius(32)
                                            .shadow(radius: 5)
                                            .scaleEffect(CGSize(width: scale, height: scale))
                                            .animation(.easeOut(duration: 0.5))
                                    }
                                }
                            )
                        }
                        .frame(width: 50, height: 70)
                    }
                }
                .padding(20)
            }
        }
    }
}

struct FavouriteCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteCarouselView()
    }
}
