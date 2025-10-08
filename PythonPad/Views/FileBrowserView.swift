//
//  FileBrowserView.swift
//  PythonPad
//
//  Created by iOS-python
//

import SwiftUI

struct FileBrowserView: View {
    @EnvironmentObject var fileManager: FileManagerModel
    
    var body: some View {
        List {
            Section(header: Text("Python Files")) {
                ForEach(fileManager.files) { file in
                    Button(action: {
                        fileManager.openFile(file)
                    }) {
                        HStack {
                            Text(file.name)
                                .foregroundColor(fileManager.currentFile?.id == file.id ? .blue : .primary)
                            Spacer()
                            if fileManager.currentFile?.id == file.id {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .contextMenu {
                        if !file.isDirectory {
                            Button(role: .destructive) {
                                fileManager.deleteFile(file)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    fileManager.createNewFile()
                }) {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    fileManager.loadFiles()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
}

struct FileBrowserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FileBrowserView()
                .environmentObject(FileManagerModel())
        }
    }
}
