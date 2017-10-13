//
//  MSMessageDataDSL.swift
//
//  Created by Ahmet Ardal on 12/10/2017.
//
//  Copyright © 2017 svtek. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit
import Messages

public struct MSMessageDataDSL {

  // MARK: - Public API

  public func set(value: Bool, forKey key: String) {
    add(value: value, forKey: key)
  }

  public func set(value: Int, forKey key: String) {
    add(value: value, forKey: key)
  }

  public func set(value: Float, forKey key: String) {
    add(value: value, forKey: key)
  }

  public func set(value: Double, forKey key: String) {
    add(value: value, forKey: key)
  }

  public func set(value: String, forKey key: String) {
    add(value: value, forKey: key)
  }

  public func set<T: LosslessStringConvertible>(values: [T], forKey key:String) {
    serialize(data: [key: values])
  }

  public func value<T: LosslessStringConvertible>(forKey key: String) -> T? {
    if let data = currentData(), let value = data[key] as? T {
      return value
    }
    return nil
  }

  public func bool(forKey key: String) -> Bool? {
    return value(forKey: key)
  }

  public func integer(forKey key: String) -> Int? {
    return value(forKey: key)
  }

  public func float(forKey key: String) -> Float? {
    return value(forKey: key)
  }

  public func double(forKey key: String) -> Double? {
    return value(forKey: key)
  }

  public func string(forKey key: String) -> String? {
    return value(forKey: key)
  }

  public func values(forKey key: String) -> [Any]? {
    if let data = currentData(), let value = data[key] as? [Any] {
      return value
    }
    return nil
  }

  public func clear() {
    message.url = nil
  }

  public func remove(forKey key: String) {
    if var data = currentData() {
      if data.removeValue(forKey: key) != nil {
        message.url = nil
        serialize(data: data)
      }
    }
  }

  // MARK: - Private Properties & Methods

  private let message: MSMessage

  internal init(message: MSMessage) {
    self.message = message
  }

  private func currentData() -> [String : Any]? {

    guard let url = message.url,
          let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
          let queryItems = urlComponents.queryItems,
          (queryItems.count > 0),
          let data = deserialize(jsonText: (queryItems.first?.value)!) else {

      return nil
    }

    return data
  }

  private func serialize(data: [String : Any]) {

    var mergedData = data

    if var currentData = currentData() {
      data.forEach { (arg) in let (k, v) = arg; currentData[k] = v }
      mergedData = currentData
    }

    if let json = try? JSONSerialization.data(withJSONObject: mergedData, options: []),
       let jsonText = String(data: json, encoding: .utf8) {

      var urlComponents = URLComponents()
      urlComponents.scheme = "http"
      urlComponents.host = "msmessagedata"
      urlComponents.path = "/"
      urlComponents.queryItems = [URLQueryItem(name: "data", value: jsonText)]

      if let url = urlComponents.url {
        message.url = url
      }
    }
  }

  private func deserialize(jsonText: String) -> [String : Any]? {
    let jsonData = jsonText.data(using: .utf8)!
    if let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : AnyObject] {
      return jsonResult
    }
    return nil
  }

  private func add(value: Any, forKey key: String) {
    serialize(data: [key: value])
  }

}
