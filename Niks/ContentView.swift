//
//  ContentView.swift
//  Niks
//
//  Created by Deka Primatio on 25/04/23.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTIES
    @State var previewStretch = false
    @ObservedObject var viewModel: AnimatorViewModel = AnimatorViewModel()
    let TimerObj = Timer.publish(every: 0.1,
                                 on: .main,
                                 in: .common).autoconnect()
    
    //MARK: - BODY
    var body: some View {
        if !previewStretch {
            HomePageView(previewStretch: $previewStretch)
                .onAppear{
                    viewModel.frame = 0
                    viewModel.curIndex = 0
                    viewModel.stretchView = false
                }
        }else {
            StrechPreview(viewModel: viewModel,
                          previewStretch: $previewStretch)
            .onReceive(TimerObj){ _ in
                if viewModel.currentTime == 0 && viewModel.delay == 10 && !viewModel.changed{
                    viewModel.changed = true
                    viewModel.stretchView = false
                    viewModel.incrementCurIndex()
                }
                viewModel.getOperation()
                viewModel.playAnimation()
                
            }
        }
    
    }//: - BODY
}

//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
