//
//  ContentView.swift
//  DesignCode
//
//  Created by Tochi on 03/05/2020.
//  Copyright © 2020 martins. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    @State var showCard = false
    @State var viewState = CGSize.zero
    @State var bottomCardState = CGSize.zero
    @State var showFullBottomCard = false
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
            )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0: 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeOut(duration: 0.5))
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y:show ? -200 : -20 )
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1: 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0.0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeOut(duration: 0.3))
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color(.black))
                //.cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20 , style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showCard.toggle()
            }.gesture(
                DragGesture().onChanged{ value in
                    self.viewState = value.translation
                    self.show = true
                }
                .onEnded{ _ in
                    self.viewState = CGSize.zero
                    self.show = false
                }
            )
            
            BottomCardView()
                .offset(x: 0.0, y: showCard ? 360 : 1000.0)
                .offset(y: self.bottomCardState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(DragGesture()
                    .onChanged{value in
                        self.bottomCardState = value.translation
                        if self.showFullBottomCard{
                            self.bottomCardState.height += -300
                        }
                        
                        if self.bottomCardState.height < -300{
                            self.bottomCardState.height = -300
                        }
                }
                .onEnded{ value in
                    if(self.bottomCardState.height > 50){
                        self.showCard = false
                    }
                    
                    if(self.bottomCardState.height < -100 && !self.showFullBottomCard) || (self.bottomCardState.height < -250 && self.showFullBottomCard){
                        self.bottomCardState.height = -300
                        self.showFullBottomCard = true
                    }else{
                        self.bottomCardState = .zero
                        self.showFullBottomCard = false
                    }
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }.padding(.horizontal, 20)
                .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
        
    }
}

struct BackCardView: View {
    var body: some View {
        VStack{
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }.padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3.0)
                .opacity(0.1)
            Text("This certificate is proof that Martins has achieved the UI Design course with approval from a Design+Code from Instructor")
                .font(.subheadline)
                .lineSpacing(4)
                .multilineTextAlignment(.center)
            Spacer()
        }.padding()
            .padding(.top, 8)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 20)
    }
}
