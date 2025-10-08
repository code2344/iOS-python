//
//  GitManager.swift
//  PythonPad
//
//  Created by iOS-python
//

import Foundation
import Combine

class GitManager: ObservableObject {
    @Published var showCloneDialog: Bool = false
    @Published var repositories: [GitRepository] = []
    @Published var currentRepository: GitRepository?
    @Published var operationStatus: String = ""
    @Published var isOperating: Bool = false
    
    private let documentsPath: String
    
    init() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        documentsPath = paths[0].path
        loadRepositories()
    }
    
    func cloneRepository(url: String, completion: @escaping (Bool, String) -> Void) {
        isOperating = true
        operationStatus = "Cloning repository..."
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let process = Process()
            let pipe = Pipe()
            let errorPipe = Pipe()
            
            // Extract repo name from URL
            let repoName = url.components(separatedBy: "/").last?.replacingOccurrences(of: ".git", with: "") ?? "repo"
            let targetPath = (self.documentsPath as NSString).appendingPathComponent(repoName)
            
            process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
            process.arguments = ["clone", url, targetPath]
            process.standardOutput = pipe
            process.standardError = errorPipe
            
            do {
                try process.run()
                
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
                
                process.waitUntilExit()
                
                let output = String(data: data, encoding: .utf8) ?? ""
                let errorOutput = String(data: errorData, encoding: .utf8) ?? ""
                let success = process.terminationStatus == 0
                
                DispatchQueue.main.async {
                    self.isOperating = false
                    if success {
                        self.operationStatus = "Repository cloned successfully"
                        self.loadRepositories()
                    } else {
                        self.operationStatus = "Failed to clone repository"
                    }
                    completion(success, output + errorOutput)
                }
            } catch {
                DispatchQueue.main.async {
                    self.isOperating = false
                    self.operationStatus = "Error: \(error.localizedDescription)"
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func pullCurrentRepository() {
        guard let repo = currentRepository else { return }
        pullRepository(repo)
    }
    
    func pullRepository(_ repository: GitRepository) {
        isOperating = true
        operationStatus = "Pulling updates..."
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let process = Process()
            let pipe = Pipe()
            let errorPipe = Pipe()
            
            process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
            process.arguments = ["pull"]
            process.currentDirectoryURL = URL(fileURLWithPath: repository.path)
            process.standardOutput = pipe
            process.standardError = errorPipe
            
            do {
                try process.run()
                
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
                
                process.waitUntilExit()
                
                let output = String(data: data, encoding: .utf8) ?? ""
                let errorOutput = String(data: errorData, encoding: .utf8) ?? ""
                
                DispatchQueue.main.async {
                    self.isOperating = false
                    if process.terminationStatus == 0 {
                        self.operationStatus = "Pull successful: \(output)"
                    } else {
                        self.operationStatus = "Pull failed: \(errorOutput)"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isOperating = false
                    self.operationStatus = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func loadRepositories() {
        repositories = []
        
        guard let contents = try? FileManager.default.contentsOfDirectory(atPath: documentsPath) else { return }
        
        for item in contents {
            let itemPath = (documentsPath as NSString).appendingPathComponent(item)
            let gitPath = (itemPath as NSString).appendingPathComponent(".git")
            
            var isDir: ObjCBool = false
            if FileManager.default.fileExists(atPath: gitPath, isDirectory: &isDir), isDir.boolValue {
                repositories.append(GitRepository(name: item, path: itemPath))
            }
        }
    }
}

struct GitRepository: Identifiable {
    let id = UUID()
    let name: String
    let path: String
}
