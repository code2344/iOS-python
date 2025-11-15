//
//  EditorView.swift
//  PythonPad
//
//  Created by iOS-python
//

import SwiftUI

struct EditorView: View {
    @EnvironmentObject var fileManager: FileManagerModel
    @EnvironmentObject var pythonEnvironment: PythonEnvironment
    @State private var editedContent: String = ""
    
    var body: some View {
        VStack {
            if let currentFile = fileManager.currentFile {
                // Editor toolbar
                HStack {
                    Text(currentFile.name.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "📄 ", with: ""))
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        fileManager.saveFile(currentFile, content: editedContent)
                    }) {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    .keyboardShortcut("s", modifiers: .command)
                    
                    Button(action: {
                        pythonEnvironment.runScript(editedContent)
                    }) {
                        Label("Run", systemImage: "play.fill")
                    }
                    .keyboardShortcut("r", modifiers: .command)
                    .disabled(pythonEnvironment.isRunning)
                }
                .padding()
                
                Divider()
                
                // Code editor with line numbers
                HStack(alignment: .top, spacing: 0) {
                    // Line numbers
                    ScrollView {
                        VStack(alignment: .trailing, spacing: 0) {
                            ForEach(Array(editedContent.components(separatedBy: "\n").enumerated()), id: \.offset) { index, _ in
                                Text("\(index + 1)")
                                    .font(.system(.body, design: .monospaced))
                                    .foregroundColor(.secondary)
                                    .frame(width: 40, alignment: .trailing)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                    .frame(width: 50)
                    .background(Color(UIColor.systemGray6))
                    
                    // Text editor
                    TextEditor(text: $editedContent)
                        .font(.system(.body, design: .monospaced))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.leading, 8)
                }
                .onAppear {
                    editedContent = currentFile.content
                }
                .onChange(of: fileManager.currentFile?.id) { _ in
                    if let newFile = fileManager.currentFile {
                        editedContent = newFile.content
                    }
                }
            } else {
                // Empty state
                VStack {
                    Image(systemName: "doc.text")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)
                    Text("No File Selected")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text("Select a file from the sidebar or create a new one")
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
            }
        }
        .navigationTitle("Editor")
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
            .environmentObject(FileManagerModel())
            .environmentObject(PythonEnvironment())
    }
}
