//
//  ConsoleView.swift
//  PythonPad
//
//  Created by iOS-python
//

import SwiftUI

struct ConsoleView: View {
    @EnvironmentObject var pythonEnvironment: PythonEnvironment
    
    var body: some View {
        VStack {
            // Toolbar
            HStack {
                Text("Console Output")
                    .font(.headline)
                
                Spacer()
                
                if pythonEnvironment.isRunning {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.trailing)
                    
                    Button(action: {
                        pythonEnvironment.interruptExecution()
                    }) {
                        Label("Stop", systemImage: "stop.fill")
                            .foregroundColor(.red)
                    }
                }
                
                Button(action: {
                    pythonEnvironment.clearOutput()
                }) {
                    Label("Clear", systemImage: "trash")
                }
            }
            .padding()
            
            Divider()
            
            // Console output
            ScrollView {
                ScrollViewReader { proxy in
                    Text(pythonEnvironment.output)
                        .font(.system(.body, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .id("bottom")
                        .onChange(of: pythonEnvironment.output) { _ in
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                }
            }
            .background(Color(UIColor.systemGray6))
        }
        .navigationTitle("Console")
    }
}

struct ConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleView()
            .environmentObject(PythonEnvironment())
    }
}
