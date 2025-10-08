//
//  GitView.swift
//  PythonPad
//
//  Created by iOS-python
//

import SwiftUI

struct GitView: View {
    @EnvironmentObject var gitManager: GitManager
    @EnvironmentObject var fileManager: FileManagerModel
    
    var body: some View {
        VStack {
            // Toolbar
            HStack {
                Text("Git Repositories")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    gitManager.loadRepositories()
                }) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
                
                Button(action: {
                    gitManager.showCloneDialog = true
                }) {
                    Label("Clone", systemImage: "plus")
                }
            }
            .padding()
            
            Divider()
            
            // Status message
            if !gitManager.operationStatus.isEmpty {
                HStack {
                    if gitManager.isOperating {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                    Text(gitManager.operationStatus)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                Divider()
            }
            
            // Repository list
            if gitManager.repositories.isEmpty {
                VStack {
                    Image(systemName: "arrow.triangle.branch")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)
                        .padding()
                    Text("No Git Repositories")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text("Clone a repository to get started")
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
                .frame(maxHeight: .infinity)
            } else {
                List {
                    ForEach(gitManager.repositories) { repo in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "folder.fill")
                                    .foregroundColor(.blue)
                                Text(repo.name)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Button(action: {
                                    gitManager.currentRepository = repo
                                    gitManager.pullRepository(repo)
                                }) {
                                    Label("Pull", systemImage: "arrow.down.circle")
                                }
                                .buttonStyle(BorderedButtonStyle())
                                .disabled(gitManager.isOperating)
                            }
                            
                            Text(repo.path)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Git")
        .onAppear {
            gitManager.loadRepositories()
        }
    }
}

struct GitCloneView: View {
    @EnvironmentObject var gitManager: GitManager
    @Environment(\.dismiss) var dismiss
    @State private var repositoryURL: String = ""
    @State private var isCloning: Bool = false
    @State private var cloneOutput: String = ""
    @State private var showOutput: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Repository Information")) {
                        TextField("Repository URL", text: $repositoryURL)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .keyboardType(.URL)
                        
                        Text("Example: https://github.com/user/repo.git")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    if showOutput {
                        Section(header: Text("Clone Output")) {
                            ScrollView {
                                Text(cloneOutput)
                                    .font(.system(.caption, design: .monospaced))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(height: 200)
                        }
                    }
                }
                
                if isCloning {
                    ProgressView("Cloning repository...")
                        .padding()
                }
            }
            .navigationTitle("Clone Repository")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .disabled(isCloning)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Clone") {
                        cloneRepository()
                    }
                    .disabled(repositoryURL.isEmpty || isCloning)
                }
            }
        }
    }
    
    private func cloneRepository() {
        isCloning = true
        showOutput = true
        cloneOutput = "Cloning \(repositoryURL)...\n"
        
        gitManager.cloneRepository(url: repositoryURL) { success, output in
            isCloning = false
            cloneOutput += output
            
            if success {
                cloneOutput += "\n✅ Repository cloned successfully"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    dismiss()
                }
            } else {
                cloneOutput += "\n❌ Failed to clone repository"
            }
        }
    }
}

struct GitView_Previews: PreviewProvider {
    static var previews: some View {
        GitView()
            .environmentObject(GitManager())
            .environmentObject(FileManagerModel())
    }
}
