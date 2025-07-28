//
//  NavigatioViewType.swift
//  Emozionauti
//
//  Created by Studente on 10/07/25.
//

import Foundation

enum NavigationViewType {
    case splash
    case home
    case parentalControl
    case angerAnimation
    case happinessAnimation
    case fearAnimation
    case boredomAnimation
    case sadnessAnimation
    case angerGame
    case happinessGame
    case fearGame
    case boredomGame
    case sadnessGame
    case diary
    case parentDashboard
    case canvas(text: String, emotion: String)
    case animationManager
    case gallery
    case skipAngerAnimation
    case skipHappinessAnimation
    case skipSadnessAnimation
    case skipBoredomAnimation
    case skipFearAnimation
    case notificationSettings
}
