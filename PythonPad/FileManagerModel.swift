//
//  FileManagerModel.swift
//  PythonPad
//
//  Created by iOS-python
//

import Foundation
import Combine

struct PythonFile: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var content: String
    var path: String
    var isDirectory: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PythonFile, rhs: PythonFile) -> Bool {
        lhs.id == rhs.id
    }
}

class FileManagerModel: ObservableObject {
    @Published var files: [PythonFile] = []
    @Published var currentFile: PythonFile?
    
    private let documentsPath: String
    private let fileManager = FileManager.default
    
    init() {
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        documentsPath = paths[0].path
        loadFiles()
    }
    
    func loadFiles() {
        files = []
        loadFilesRecursively(at: documentsPath)
    }
    
    private func loadFilesRecursively(at path: String, level: Int = 0) {
        guard let contents = try? fileManager.contentsOfDirectory(atPath: path) else { return }
        
        for item in contents.sorted() {
            let itemPath = (path as NSString).appendingPathComponent(item)
            var isDir: ObjCBool = false
            
            if fileManager.fileExists(atPath: itemPath, isDirectory: &isDir) {
                if isDir.boolValue {
                    files.append(PythonFile(
                        name: String(repeating: "  ", count: level) + "📁 " + item,
                        content: "",
                        path: itemPath,
                        isDirectory: true
                    ))
                    loadFilesRecursively(at: itemPath, level: level + 1)
                } else if item.hasSuffix(".py") || item.hasSuffix(".txt") || item.hasSuffix(".md") {
                    let content = (try? String(contentsOfFile: itemPath, encoding: .utf8)) ?? ""
                    files.append(PythonFile(
                        name: String(repeating: "  ", count: level) + "📄 " + item,
                        content: content,
                        path: itemPath,
                        isDirectory: false
                    ))
                }
            }
        }
    }
    
    func createNewFile() {
        let fileName = "untitled_\(Date().timeIntervalSince1970).py"
        let filePath = (documentsPath as NSString).appendingPathComponent(fileName)
        
        let defaultContent = """
        # New Python File
        print("Hello, World!")
        """
        
        do {
            try defaultContent.write(toFile: filePath, atomically: true, encoding: .utf8)
            loadFiles()
            
            if let newFile = files.first(where: { $0.path == filePath }) {
                currentFile = newFile
            }
        } catch {
            print("Failed to create file: \(error)")
        }
    }
    
    func saveFile(_ file: PythonFile, content: String) {
        do {
            try content.write(toFile: file.path, atomically: true, encoding: .utf8)
            if let index = files.firstIndex(where: { $0.id == file.id }) {
                files[index].content = content
            }
        } catch {
            print("Failed to save file: \(error)")
        }
    }
    
    func deleteFile(_ file: PythonFile) {
        do {
            try fileManager.removeItem(atPath: file.path)
            loadFiles()
            if currentFile?.id == file.id {
                currentFile = nil
            }
        } catch {
            print("Failed to delete file: \(error)")
        }
    }
    
    func openFile(_ file: PythonFile) {
        if !file.isDirectory {
            currentFile = file
        }
    }
}
