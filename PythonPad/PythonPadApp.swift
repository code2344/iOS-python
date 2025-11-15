//
//  PythonPadApp.swift
//  PythonPad
//
//  Created by iOS-python
//

import SwiftUI

@main
struct PythonPadApp: App {
    @StateObject private var pythonEnvironment = PythonEnvironment()
    @StateObject private var fileManager = FileManagerModel()
    @StateObject private var gitManager = GitManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pythonEnvironment)
                .environmentObject(fileManager)
                .environmentObject(gitManager)
        }
        #if targetEnvironment(macCatalyst) || os(iOS)
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("New Python File") {
                    fileManager.createNewFile()
                }
                .keyboardShortcut("n", modifiers: .command)
            }
            
            CommandGroup(after: .newItem) {
                Button("Run Script") {
                    if let currentFile = fileManager.currentFile {
                        pythonEnvironment.runScript(currentFile.content)
                    }
                }
                .keyboardShortcut("r", modifiers: .command)
                
                Divider()
                
                Button("Clear Console") {
                    pythonEnvironment.clearOutput()
                }
                .keyboardShortcut("k", modifiers: [.command, .shift])
            }
            
            CommandMenu("Python") {
                Button("Install Package...") {
                    pythonEnvironment.showPackageManager = true
                }
                .keyboardShortcut("p", modifiers: [.command, .shift])
                
                Button("Open Shell") {
                    pythonEnvironment.showShell = true
                }
                .keyboardShortcut("t", modifiers: [.command, .shift])
                
                Divider()
                
                Button("Interrupt Execution") {
                    pythonEnvironment.interruptExecution()
                }
                .keyboardShortcut("c", modifiers: [.command, .control])
            }
            
            CommandMenu("Git") {
                Button("Clone Repository...") {
                    gitManager.showCloneDialog = true
                }
                .keyboardShortcut("g", modifiers: [.command, .shift])
                
                Button("Pull") {
                    gitManager.pullCurrentRepository()
                }
                .keyboardShortcut("p", modifiers: [.command, .option])
            }
        }
        #endif
    }
}
