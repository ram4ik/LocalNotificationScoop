//
//  ContentView.swift
//  LocalNotificationScoop
//
//  Created by ramil on 07.09.2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var localNotification = LocalNotification()
    
    var body: some View {
        VStack {
            Button(action: {
                localNotification.setNotification(title: "Notification", subTitle: "Sub Title", body: "Fire in the hole!", lunchTime: 10)
            }, label: {
                Text("Lunch Notification")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class LocalNotification: ObservableObject {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (isAllow, error) in
            if isAllow {
                print("Allow")
            } else {
                print("Not allow")
            }
        }
    }
    
    func setNotification(title: String, subTitle: String, body: String, lunchTime: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.body = body
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: lunchTime, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
