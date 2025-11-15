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
    
    private let documentsPath: String
    private var pythonInterpreter: PythonInterpreter?
    
    init() {
        // Get documents directory
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        documentsPath = paths[0].path
        
        // Initialize Python interpreter
        pythonInterpreter = PythonInterpreter()
        
        loadInstalledPackages()
        
        // Show startup message
        output = """
        Welcome to PythonPad for iPadOS!
        
        Note: This is a demonstration app. Full Python runtime requires:
        - Embedding Python framework in the app bundle
        - Or using a WebAssembly Python interpreter
        - Process API is not available on iOS/iPadOS
        
        For now, the app demonstrates the UI and workflow.
        To make this fully functional, integrate Python.framework or use PythonKit.
        
        """
    }
    
    func runScript(_ script: String) {
        isRunning = true
        output += "\n--- Running Script ---\n"
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            // Simulate Python execution since Process API is not available on iOS
            let result = self.pythonInterpreter?.execute(script) ?? "Error: Python interpreter not initialized"
            
            DispatchQueue.main.async {
                self.output += result
                self.output += "\n--- Execution Complete ---\n"
                self.isRunning = false
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
            
            // Simulate package installation
            let simulatedOutput = """
            Collecting \(packageName)
            Note: Process API is not available on iOS/iPadOS.
            To enable package installation, integrate pip with embedded Python framework.
            
            Package '\(packageName)' has been added to the simulated package list.
            """
            
            DispatchQueue.main.async {
                // Add to simulated packages list
                if !self.installedPackages.contains(packageName) {
                    self.installedPackages.append(packageName)
                }
                completion(true, simulatedOutput)
            }
        }
    }
    
    func loadInstalledPackages() {
        DispatchQueue.main.async { [weak self] in
            // Simulate some common packages
            self?.installedPackages = [
                "pip",
                "setuptools",
                "wheel"
            ]
        }
    }
    
    func interruptExecution() {
        isRunning = false
        output += "\n--- Execution Interrupted ---\n"
    }
    
    func clearOutput() {
        output = ""
    }
}

// MARK: - Python Interpreter Simulator
// This simulates Python execution. For a real implementation:
// 1. Bundle Python.framework with the app
// 2. Use PythonKit or similar library
// 3. Or use WebAssembly-based Python (Pyodide)
private class PythonInterpreter {
    func execute(_ code: String) -> String {
        // Simple simulation of common Python commands
        let trimmedCode = code.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Handle print statements
        if trimmedCode.starts(with: "print(") {
            let startIndex = trimmedCode.index(trimmedCode.startIndex, offsetBy: 6)
            let endIndex = trimmedCode.index(before: trimmedCode.endIndex)
            let content = String(trimmedCode[startIndex..<endIndex])
            
            // Remove quotes if present
            let cleaned = content.trimmingCharacters(in: CharacterSet(charactersIn: "\"'"))
            return cleaned + "\n"
        }
        
        // Handle simple math
        if let result = evaluateSimpleMath(trimmedCode) {
            return "\(result)\n"
        }
        
        // Handle import statements
        if trimmedCode.starts(with: "import ") || trimmedCode.starts(with: "from ") {
            return "" // Silent success for imports
        }
        
        // Handle for loops with print (very basic)
        if trimmedCode.contains("for ") && trimmedCode.contains("print(") {
            return simulateForLoop(trimmedCode)
        }
        
        // Default response for unhandled code
        return """
        [Simulated Output]
        Note: Full Python execution requires embedding Python framework.
        
        Your code:
        \(trimmedCode)
        
        To enable real Python execution:
        1. Integrate Python.framework or PythonKit
        2. Bundle Python runtime with the app
        3. Configure proper iOS entitlements
        
        """
    }
    
    private func evaluateSimpleMath(_ expression: String) -> Double? {
        let mathExpression = NSExpression(format: expression)
        return mathExpression.expressionValue(with: nil, context: nil) as? Double
    }
    
    private func simulateForLoop(_ code: String) -> String {
        // Very basic simulation of "for i in range(n): print(i)"
        if code.contains("range(") {
            if let rangeStart = code.range(of: "range("),
               let rangeEnd = code.range(of: ")", range: rangeStart.upperBound..<code.endIndex),
               let count = Int(code[rangeStart.upperBound..<rangeEnd.lowerBound]) {
                var output = ""
                for i in 0..<count {
                    output += "\(i)\n"
                }
                return output
            }
        }
        return "[Loop output would appear here with real Python interpreter]\n"
    }
}
