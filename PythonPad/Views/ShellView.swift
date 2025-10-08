//
//  ShellView.swift
//  PythonPad
//
//  Created by iOS-python
//

import SwiftUI

struct ShellView: View {
    @EnvironmentObject var pythonEnvironment: PythonEnvironment
    @State private var inputCommand: String = ""
    @State private var commandHistory: [String] = []
    @State private var historyIndex: Int = 0
    
    var body: some View {
        VStack {
            // Toolbar
            HStack {
                Text("Python Shell (REPL)")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    pythonEnvironment.clearOutput()
                    commandHistory.removeAll()
                }) {
                    Label("Clear", systemImage: "trash")
                }
            }
            .padding()
            
            Divider()
            
            // Shell output
            ScrollView {
                ScrollViewReader { proxy in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(pythonEnvironment.output)
                            .font(.system(.body, design: .monospaced))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Current prompt
                        HStack(alignment: .top, spacing: 4) {
                            Text(">>>")
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.green)
                            
                            Text(inputCommand)
                                .font(.system(.body, design: .monospaced))
                        }
                        .id("bottom")
                    }
                    .padding()
                    .onChange(of: pythonEnvironment.output) { _ in
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                    .onChange(of: inputCommand) { _ in
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
            }
            .background(Color(UIColor.systemGray6))
            
            Divider()
            
            // Input field
            HStack {
                Text(">>>")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.green)
                    .padding(.leading)
                
                TextField("Enter Python command", text: $inputCommand)
                    .font(.system(.body, design: .monospaced))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        executeCommand()
                    }
                
                Button(action: executeCommand) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title2)
                }
                .disabled(inputCommand.isEmpty || pythonEnvironment.isRunning)
                .padding(.trailing)
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("Shell")
    }
    
    private func executeCommand() {
        guard !inputCommand.isEmpty else { return }
        
        commandHistory.append(inputCommand)
        historyIndex = commandHistory.count
        
        pythonEnvironment.runCommand(inputCommand)
        inputCommand = ""
    }
}

struct ShellView_Previews: PreviewProvider {
    static var previews: some View {
        ShellView()
            .environmentObject(PythonEnvironment())
    }
}
