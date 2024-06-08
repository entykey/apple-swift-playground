// STATUS: failed
/*
import AppKit

func playTriToneNotificationSound() {
    do {
        // Create an NSSound object with the "Tink" system sound
        // "Funk"
        let sound = NSSound(named: "Basso")
        
        // Play the sound
        sound?.play()
    } catch {
        print("Error playing Tri-Tone notification sound: \(error)")
    }
}

// Call the function to play the Tri-Tone notification sound
playTriToneNotificationSound()

let nc = NotificationCenter.default
nc.post(name: Notification.Name("UserLoggedIn"), object: nil)

nc.addObserver(self, selector: #selector(userLoggedIn), name: Notification.Name("UserLoggedIn"), object: nil)

// Keep the program running to allow the sound to play
RunLoop.main.run()
*/


import Foundation
import UserNotifications

// Request authorization to display notifications
UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
    guard granted else {
        if let error = error {
            print("Error requesting authorization: \(error)")
        } else {
            print("Authorization denied")
        }
        return
    }
    
    // Authorization granted, send the notification
    sendNotification()
    
    // Keep the program running to allow the notification sound to play
    RunLoop.main.run()
}

func sendNotification() {
    let content = UNMutableNotificationContent()
    content.title = "Notification Title"
    content.body = "Notification message goes here"
    content.sound = UNNotificationSound.default
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
    let center = UNUserNotificationCenter.current()
    center.add(request) { error in
        if let error = error {
            print("Error sending notification: \(error)")
        } else {
            print("Notification sent successfully")
        }
    }
}





// $ swiftc play-notification-sound.swift
// $ ./play-notification-sound