//
//  PawCamKZWidgetLiveActivity.swift
//  PawCamKZWidget
//
//  Created by toompieilya on 17.03.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PawCamKZWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PawCamKZWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PawCamKZWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PawCamKZWidgetAttributes {
    fileprivate static var preview: PawCamKZWidgetAttributes {
        PawCamKZWidgetAttributes(name: "World")
    }
}

extension PawCamKZWidgetAttributes.ContentState {
    fileprivate static var smiley: PawCamKZWidgetAttributes.ContentState {
        PawCamKZWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: PawCamKZWidgetAttributes.ContentState {
         PawCamKZWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: PawCamKZWidgetAttributes.preview) {
   PawCamKZWidgetLiveActivity()
} contentStates: {
    PawCamKZWidgetAttributes.ContentState.smiley
    PawCamKZWidgetAttributes.ContentState.starEyes
}
