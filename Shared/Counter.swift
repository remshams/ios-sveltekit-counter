//
//  Counter.swift
//  sveltekit-counter
//
//  Created by Mathias Remshardt on 13.05.21.
//

import Foundation
import SwiftUI

struct Counter: View {
  @State var count = 0
  @State var offset = 0
  @State var nextCount = 0
  private let fontsize = 120
  
  var body: some View {
    VStack {
      CounterSepator()
      HStack {
        Spacer()
        CounterButton(count: $nextCount, offset: $offset, sfImage: Image(systemName: "minus"), offsetChange: -fontsize, countChange: -1)
        Spacer()
        CounterDisplay(count: count, offset: offset, fontsize: fontsize)
        Spacer()
        CounterButton(count: $nextCount, offset: $offset, sfImage: Image(systemName: "plus"), offsetChange: fontsize, countChange: 1)
        Spacer()
      }.onAnimationCompleted(for: CGFloat(offset)) {
        count = nextCount
        offset = 0
      }
      CounterSepator()
    }
    .padding(.leading)
    .padding(.trailing)
  }
}

private struct CounterButton: View {
  @Binding var count: Int
  @Binding var offset: Int
  let sfImage: Image
  let offsetChange: Int
  let countChange: Int
  
  var body: some View {
    Button(action: {
      withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
        count += countChange
        offset += offsetChange
      }
    }) {
      sfImage.font(.system(size: 40)).foregroundColor(.black)
    }
  }
}

private struct CounterDisplay: View {
  let count: Int
  let offset: Int
  let fontsize: Int
  
  var body: some View {
    ZStack {
      ForEach(1..<20) { index in
        CounterText(count: count + index, offset: -fontsize * index, fontsize: fontsize)
      }
      CounterText(count: count, offset: 0, fontsize: fontsize)
      ForEach(1..<20) { index in
        CounterText(count: count - index, offset: fontsize * index, fontsize: fontsize)
      }
    }
    .frame(minWidth: CGFloat(fontsize + 80))
    .offset(y: CGFloat(offset))
  }
}

private struct CounterText: View {
  let count: Int
  let offset: Int
  let fontsize: Int
  
  var body: some View {
    Text("\(count)")
      .font(.system(size: CGFloat(fontsize)))
      .foregroundColor(.red)
      .offset(y: CGFloat(offset))
  }
}

private struct CounterSepator: View {
  
  var body: some View {
    Rectangle()
      .fill(Color.gray)
      .opacity(0.5)
      .frame(height: 1)
  }
}

#if DEBUG
struct Counter_Previews: PreviewProvider {
  static var previews: some View {
    Counter()
  }
}
#endif
