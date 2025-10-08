//
//  PythonEnvironment.swift
//  PythonPad
//
//  Created by iOS-python
//

import Foundation
import Combine

class PythonEnvironment: ObservableObject {
    @Published var output: String = ""
    @Published var isRunning: Bool = false
    @Published var showPackageManager: Bool = false
    @Published var showShell: Bool = false
    @Published var installedPackages: [String] = []
    
    private var process: Process?
    private let pythonPath: String
    private let pipPath: String
    private let documentsPath: String
    
    init() {
        // Get documents directory
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        documentsPath = paths[0].path
        
        // Set up Python paths (using system Python for now)
        // In a real implementation, you would bundle Python with the app
        pythonPath = "/usr/bin/python3"
        pipPath = "/usr/bin/pip3"
        
        loadInstalledPackages()
    }
    
    func runScript(_ script: String) {
        isRunning = true
        output += "\n--- Running Script ---\n"
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let process = Process()
            let pipe = Pipe()
            let errorPipe = Pipe()
            
            process.executableURL = URL(fileURLWithPath: self.pythonPath)
            process.arguments = ["-c", script]
            process.standardOutput = pipe
            process.standardError = errorPipe
            process.currentDirectoryURL = URL(fileURLWithPath: self.documentsPath)
            
            self.process = process
            
            do {
                try process.run()
                
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
                
                process.waitUntilExit()
                
                DispatchQueue.main.async {
                    if let output = String(data: data, encoding: .utf8), !output.isEmpty {
                        self.output += output
                    }
                    if let errorOutput = String(data: errorData, encoding: .utf8), !errorOutput.isEmpty {
                        self.output += "Error: \(errorOutput)"
                    }
                    self.output += "\n--- Exit Code: \(process.terminationStatus) ---\n"
                    self.isRunning = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.output += "Failed to run: \(error.localizedDescription)\n"
                    self.isRunning = false
                }
            }
        }
    }
    
    func runCommand(_ command: String) {
        output += "> \(command)\n"
        runScript(command)
    }
    
    func installPackage(_ packageName: String, completion: @escaping (Bool, String) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            let process = Process()
            let pipe = Pipe()
            let errorPipe = Pipe()
            
            process.executableURL = URL(fileURLWithPath: self.pipPath)
            process.arguments = ["install", packageName, "--user"]
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
                    if success {
                        self.loadInstalledPackages()
                    }
                    completion(success, output + errorOutput)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func loadInstalledPackages() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            
            let process = Process()
            let pipe = Pipe()
            
            process.executableURL = URL(fileURLWithPath: self.pipPath)
            process.arguments = ["list", "--format=freeze"]
            process.standardOutput = pipe
            
            do {
                try process.run()
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                process.waitUntilExit()
                
                if let output = String(data: data, encoding: .utf8) {
                    let packages = output.components(separatedBy: "\n")
                        .filter { !$0.isEmpty }
                        .map { $0.components(separatedBy: "==").first ?? $0 }
                    
                    DispatchQueue.main.async {
                        self.installedPackages = packages
                    }
                }
            } catch {
                print("Failed to load packages: \(error)")
            }
        }
    }
    
    func interruptExecution() {
        process?.terminate()
        isRunning = false
        output += "\n--- Execution Interrupted ---\n"
    }
    
    func clearOutput() {
        output = ""
    }
}
