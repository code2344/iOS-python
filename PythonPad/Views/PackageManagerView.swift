//
//  PackageManagerView.swift
//  PythonPad
//
//  Created by iOS-python
//

import SwiftUI

struct PackageManagerView: View {
    @EnvironmentObject var pythonEnvironment: PythonEnvironment
    @State private var searchText: String = ""
    
    var filteredPackages: [String] {
        if searchText.isEmpty {
            return pythonEnvironment.installedPackages
        } else {
            return pythonEnvironment.installedPackages.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack {
            // Toolbar
            HStack {
                Text("Package Manager")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    pythonEnvironment.loadInstalledPackages()
                }) {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
                
                Button(action: {
                    pythonEnvironment.showPackageManager = true
                }) {
                    Label("Install", systemImage: "plus")
                }
            }
            .padding()
            
            Divider()
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search packages", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.horizontal)
            
            // Package list
            List {
                Section(header: Text("Installed Packages (\(filteredPackages.count))")) {
                    ForEach(filteredPackages, id: \.self) { package in
                        HStack {
                            Image(systemName: "shippingbox.fill")
                                .foregroundColor(.blue)
                            Text(package)
                                .font(.system(.body, design: .monospaced))
                        }
                    }
                }
            }
        }
        .navigationTitle("Packages")
        .onAppear {
            pythonEnvironment.loadInstalledPackages()
        }
    }
}

struct PackageInstallView: View {
    @EnvironmentObject var pythonEnvironment: PythonEnvironment
    @Environment(\.dismiss) var dismiss
    @State private var packageName: String = ""
    @State private var isInstalling: Bool = false
    @State private var installOutput: String = ""
    @State private var showOutput: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Package Information")) {
                        TextField("Package Name", text: $packageName)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        Text("Examples: numpy, pandas, requests, matplotlib")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    if showOutput {
                        Section(header: Text("Installation Output")) {
                            ScrollView {
                                Text(installOutput)
                                    .font(.system(.caption, design: .monospaced))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(height: 200)
                        }
                    }
                }
                
                if isInstalling {
                    ProgressView("Installing \(packageName)...")
                        .padding()
                }
            }
            .navigationTitle("Install Package")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .disabled(isInstalling)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Install") {
                        installPackage()
                    }
                    .disabled(packageName.isEmpty || isInstalling)
                }
            }
        }
    }
    
    private func installPackage() {
        isInstalling = true
        showOutput = true
        installOutput = "Installing \(packageName)...\n"
        
        pythonEnvironment.installPackage(packageName) { success, output in
            isInstalling = false
            installOutput += output
            
            if success {
                installOutput += "\n✅ Successfully installed \(packageName)"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    dismiss()
                }
            } else {
                installOutput += "\n❌ Failed to install \(packageName)"
            }
        }
    }
}

struct PackageManagerView_Previews: PreviewProvider {
    static var previews: some View {
        PackageManagerView()
            .environmentObject(PythonEnvironment())
    }
}
