//
//  MessagesViewController.swift
//
//  Created by Ahmet Ardal on 12/10/2017.
//  Copyright © 2017 svtek. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {

  @IBOutlet weak var logsTextView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - IBActions

  @IBAction func sendButtonTapped(_ sender: Any) {

    let layout = MSMessageTemplateLayout()
    layout.caption = "A message with attached data."
    layout.image = UIImage(named: "github_cat")

    let message: MSMessage = MSMessage()
    message.layout = layout

    message.md.set(value: Int(arc4random()), forKey: "message_id")
    message.md.set(value: Int(NSDate().timeIntervalSince1970), forKey: "timestamp")
    message.md.set(value: true, forKey: "is_okay")
    message.md.set(value: "john", forKey: "username")
    message.md.set(values: ["happy", "joy", "smile"], forKey: "tags")
    message.md.set(values: [7.3, 5.2], forKey: "dimensions")

    if #available(iOSApplicationExtension 11.0, *) {
      activeConversation?.send(message, completionHandler: nil)
    }
    else {
      activeConversation?.insert(message, completionHandler: nil)
    }
  }

  // MARK: - Conversation Handling

  override func didSelect(_ message: MSMessage, conversation: MSConversation) {

    logsTextView.text = "Data from selected message:\n---------------------------\n"

    // get previously attached data from message
    displayValue(message.md.integer(forKey: "message_id"), key: "message_id")
    displayValue(message.md.integer(forKey: "timestamp"),  key: "timestamp")
    displayValue(message.md.bool(forKey: "is_okay"),       key: "is_okay")
    displayValue(message.md.string(forKey: "username"),    key: "username")
    displayValue(message.md.values(forKey: "tags"),        key: "tags")
    displayValue(message.md.values(forKey: "dimensions"),  key: "dimensions")
  }

  private func displayValue(_ value: Any?, key: String) {
    if let v = value {
      print("\(key): \(v)")
      if var logText = logsTextView.text {
        logText += "\(key): \(v)\n"
        logsTextView.text = logText
      }
    }
    else {
      print("No value found for key: \(key)")
    }
  }

  override func willBecomeActive(with conversation: MSConversation) {
  }

  override func didResignActive(with conversation: MSConversation) {
  }

  override func didReceive(_ message: MSMessage, conversation: MSConversation) {
  }

  override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
  }

  override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
  }

  override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
  }

  override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
  }

}
