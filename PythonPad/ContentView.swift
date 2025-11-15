//
//  ContentView.swift
//  PythonPad
//
//  Created by iOS-python
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pythonEnvironment: PythonEnvironment
    @EnvironmentObject var fileManager: FileManagerModel
    @EnvironmentObject var gitManager: GitManager
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationSplitView {
            // Sidebar - File Browser
            FileBrowserView()
                .navigationTitle("Files")
        } detail: {
            // Main content area
            TabView(selection: $selectedTab) {
                // Editor Tab
                EditorView()
                    .tabItem {
                        Label("Editor", systemImage: "doc.text")
                    }
                    .tag(0)
                
                // Console Tab
                ConsoleView()
                    .tabItem {
                        Label("Console", systemImage: "terminal")
                    }
                    .tag(1)
                
                // Shell Tab
                ShellView()
                    .tabItem {
                        Label("Shell", systemImage: "chevron.right.square")
                    }
                    .tag(2)
                
                // Package Manager Tab
                PackageManagerView()
                    .tabItem {
                        Label("Packages", systemImage: "shippingbox")
                    }
                    .tag(3)
                
                // Git Tab
                GitView()
                    .tabItem {
                        Label("Git", systemImage: "arrow.triangle.branch")
                    }
                    .tag(4)
            }
        }
        .sheet(isPresented: $pythonEnvironment.showPackageManager) {
            PackageInstallView()
        }
        .sheet(isPresented: $gitManager.showCloneDialog) {
            GitCloneView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PythonEnvironment())
            .environmentObject(FileManagerModel())
            .environmentObject(GitManager())
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
