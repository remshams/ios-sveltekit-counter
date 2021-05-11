//
//  SvelteCounter.swift
//  swiftui-playground
//
//  Created by Mathias Remshardt on 09.05.21.
//

import SwiftUI

struct SvelteKitCounter: View {
  
  @State var nextCount = 0
  @State var count = 0
  @State var offset = 0
  
  var body: some View {
    HStack {
      Button(action: {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
          nextCount -= 1
          offset -= 120
        }
      }) {
        Image(systemName: "minus").font(.system(size: 40))
      }
      VStack(spacing: 0) {
        Rectangle()
          .fill(Color.white)
          .frame(width: 120)
          .ignoresSafeArea()
          .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        ZStack {
          ForEach(1..<12) { index in
            Text("\(count + index)").font(.system(size: 120)).offset(y: CGFloat(-120 * index))
          }
          
          Text("\(count)").font(.system(size: 120))
          ForEach(1..<12) { index in
            Text("\(count - index)").font(.system(size: 120)).offset(y: CGFloat(120 * index))
          }
        }.offset(y: CGFloat(offset))
        Rectangle()
          .fill(Color.white)
          .frame(width: 120)
          .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
          .ignoresSafeArea()
      }
      
      Button(action: {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
          nextCount += 1
          offset += 120
        }
        
      }) {
        Image(systemName: "plus").font(.system(size: 40))
      }
    }.onAnimationCompleted(for: CGFloat(offset)) {
      count = nextCount
      offset = 0
    }
  }
}

#if DEBUG
struct SvelteKitCounter_Previews: PreviewProvider {
  static var previews: some View {
    SvelteKitCounter()
  }
}
#endif
