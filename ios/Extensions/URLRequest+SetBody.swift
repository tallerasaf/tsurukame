// Copyright 2020 David Sansome
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

extension URLRequest {
  mutating func setJSONBody<T: Codable>(method: String, body: T) throws {
    let data = try JSONEncoder().encode(body)

    setValue("application/json", forHTTPHeaderField: "Content-Type")
    setValue(String(data.count), forHTTPHeaderField: "Content-Length")
    httpBody = data
    httpMethod = method
  }

  mutating func setFormBody(method: String, queryItems: [URLQueryItem]) throws {
    var components = URLComponents()
    components.queryItems = queryItems
    let data = components.query!.data(using: .utf8)!

    setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    setValue(String(data.count), forHTTPHeaderField: "Content-Length")
    httpBody = data
    httpMethod = method
  }
}
