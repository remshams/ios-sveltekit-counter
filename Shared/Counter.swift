//
//  Counter.swift
//  sveltekit-counter
//
//  Created by Mathias Remshardt on 13.05.21.
//

import Foundation
import SwiftUI

struct Counter: View {
  @State var offset = 0
  @State var countChange = 0
  let fontsize = 120
  let offsetStep = 120

  var body: some View {
    HStack {
      Spacer()
      CounterButton(
        countChange: $countChange,
        offset: $offset,
        sfImage: Image(systemName: "minus"),
        offsetStep: -offsetStep,
        countStep: -1
      )
      Spacer()
      CounterDisplay(fontsize: fontsize, offsetStep: offsetStep, offset: $offset, countChange: $countChange)
      Spacer()
      CounterButton(
        countChange: $countChange,
        offset: $offset,
        sfImage: Image(systemName: "plus"),
        offsetStep: offsetStep,
        countStep: 1
      )
      Spacer()
    }
  }
}

private struct CounterButton: View {
  @Binding var countChange: Int
  @Binding var offset: Int
  let sfImage: Image
  let offsetStep: Int
  let countStep: Int

  var body: some View {
    Button(action: {
      withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
        countChange += countStep
        offset += offsetStep
      }
    }, label: {
      sfImage.font(.system(size: 40)).foregroundColor(.black)
    })
  }
}

private struct CounterDisplay: View {
  let fontsize: Int
  let offsetStep: Int

  @Binding var offset: Int
  @Binding var countChange: Int

  @State var count: Int = 0
  @State var offsetOnAnimationStart = 0

  var body: some View {
    ZStack {
      ForEach(1 ..< 20) { index in
        CounterText(count: count + index, offset: -offsetStep * index, fontsize: fontsize)
      }
      CounterText(count: count, offset: 0, fontsize: fontsize)
      ForEach(1 ..< 20) { index in
        CounterText(count: count - index, offset: offsetStep * index, fontsize: fontsize)
      }
    }
    .frame(minWidth: CGFloat(fontsize + 80))
    .offset(y: CGFloat(offset))
    .gesture(DragGesture()
      .onChanged {
        offset = offsetOnAnimationStart + Int($0.translation.height)
      }.onEnded { _ in
        withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
          // "abs" as difference can be positive or negative depending on the drag direction
          let distanceFromLastFullStep = abs(offset % offsetStep)
          offset = self.nomalizeToOffsetStep(distanceFromLastFullStep: distanceFromLastFullStep)
          
          // The count is equivalent to the number of complete steps
          countChange = offset / offsetStep
        }

      })
    /**
     * Is re required as count can also be increased by buttons (not just the drag gesture)
     * With the help of "onAnimationCompleted" the same logic both for the count change by button or drag animation can be used
     */
    .onAnimationCompleted(for: CGFloat(offset)) {
      // Increase/Descrease count by the number of complete steps
      count += countChange
      
      // Reset animation state variables
      countChange = 0
      offset = 0
      offsetOnAnimationStart = 0
    }
  }

  private func nomalizeToOffsetStep(distanceFromLastFullStep distance: Int) -> Int {
    // Go up if closes to next full step, otherwise go down
    let difference = distance > offsetStep / 2 ? offsetStep - distance : distance * -1
    return offset > 0 ? offset + difference : offset - difference
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

#if DEBUG
  struct Counter_Previews: PreviewProvider {
    static var previews: some View {
      Counter()
    }
  }
#endif
