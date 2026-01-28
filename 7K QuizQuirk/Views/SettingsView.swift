//
//  SettingsView.swift
//  7K QuizQuirk
//
//  Created on 2026
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showDeleteAlert = false
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color("BackgroundDark"), Color("BackgroundRed"), Color("BackgroundDark")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // App Icon
                    VStack(spacing: 16) {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 80))
                            .foregroundColor(Color("AccentYellow"))
                            .padding(30)
                            .background(
                                Circle()
                                    .fill(Color.white.opacity(0.1))
                                    .overlay(
                                        Circle()
                                            .stroke(Color("AccentYellow").opacity(0.3), lineWidth: 2)
                                    )
                            )
                        
                        Text("7K QuizQuirk")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Version \(viewModel.getAppVersion()) (\(viewModel.getBuildNumber()))")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.top, 20)
                    
                    // Preferences Section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Preferences")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white.opacity(0.6))
                            .textCase(.uppercase)
                            .tracking(1)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 12)
                        
                        VStack(spacing: 1) {
                            SettingsToggle(
                                title: "Sound Effects",
                                icon: "speaker.wave.2.fill",
                                isOn: $viewModel.soundEnabled
                            )
                            
                            Divider()
                                .background(Color.white.opacity(0.1))
                                .padding(.leading, 60)
                            
                            SettingsToggle(
                                title: "Vibration",
                                icon: "iphone.radiowaves.left.and.right",
                                isOn: $viewModel.vibrationEnabled
                            )
                        }
                        .padding(16)
                        .glassmorphism(cornerRadius: 16)
                        .padding(.horizontal, 20)
                    }
                    
                    // About Section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("About")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white.opacity(0.6))
                            .textCase(.uppercase)
                            .tracking(1)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 12)
                        
                        VStack(spacing: 1) {
                            SettingsRow(
                                title: "Rate App",
                                icon: "star.fill",
                                iconColor: Color("AccentYellow")
                            )
                            
                            Divider()
                                .background(Color.white.opacity(0.1))
                                .padding(.leading, 60)
                            
                            SettingsRow(
                                title: "Share with Friends",
                                icon: "square.and.arrow.up.fill",
                                iconColor: .blue
                            )
                            
                            Divider()
                                .background(Color.white.opacity(0.1))
                                .padding(.leading, 60)
                            
                            SettingsRow(
                                title: "Privacy Policy",
                                icon: "hand.raised.fill",
                                iconColor: .green
                            )
                            
                            Divider()
                                .background(Color.white.opacity(0.1))
                                .padding(.leading, 60)
                            
                            SettingsRow(
                                title: "Terms of Service",
                                icon: "doc.text.fill",
                                iconColor: .orange
                            )
                        }
                        .padding(16)
                        .glassmorphism(cornerRadius: 16)
                        .padding(.horizontal, 20)
                    }
                    
                    // Danger Zone
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Danger Zone")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.red.opacity(0.8))
                            .textCase(.uppercase)
                            .tracking(1)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 12)
                        
                        Button(action: {
                            showDeleteAlert = true
                        }) {
                            HStack {
                                Image(systemName: "trash.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.red)
                                    .frame(width: 28)
                                
                                Text("Delete All Data")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.red)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.red.opacity(0.5))
                            }
                            .padding(16)
                            .glassmorphism(cornerRadius: 16)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Footer
                    Text("Made with ❤️ for quiz enthusiasts")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.4))
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete All Data?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteAccount()
                showDeleteConfirmation = true
            }
        } message: {
            Text("This will delete all your quiz results, statistics, and reset the app. This action cannot be undone.")
        }
        .alert("Data Deleted", isPresented: $showDeleteConfirmation) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("All your data has been successfully deleted.")
        }
    }
}

struct SettingsToggle: View {
    let title: String
    let icon: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(Color("AccentYellow"))
                .frame(width: 28)
            
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(.white)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Color("AccentYellow"))
        }
    }
}

struct SettingsRow: View {
    let title: String
    let icon: String
    let iconColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(iconColor)
                .frame(width: 28)
            
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white.opacity(0.3))
        }
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}

