/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

extension UIView{
  
  func addBackGroundColor(color: UIColor = .xlightWidget){
    self.layer.backgroundColor = color.cgColor
  }
  func addCornerRadius(_ radius: CGFloat = 6){
    self.layer.cornerRadius = radius
  }
  func addAccentBorder(width: CGFloat = 1.5 , color: UIColor = .rayGreen){
    self.layer.borderWidth = width
    self.layer.borderColor = color.cgColor
  }
  func addDropShawdow(width: Int = 0, height: Int = 3, color: UIColor = .xDarkBG, radius: CGFloat = 4, opacity: Float = 0.9){
    self.layer.shadowOffset = CGSize(width: width, height: height)
    self.layer.shadowColor = color.withAlphaComponent(0.9).cgColor
    self.layer.shadowRadius = radius
    self.layer.shadowOpacity = opacity
  }
}

extension UIColor {
  static let xLightBG = UIColor(named: "x-blueLightBG")!
  static let xDarkBG = UIColor(named: "x-blueDarkBG")!
  static let xdarkWidget = UIColor(named: "x-greendusk")!
  static let xlightWidget = UIColor(named: "x-pastelgreen")!
  static let rayDark = UIColor(named: "rw-dark")!
  static let rayLight = UIColor(named: "rw-light")!
  static let rayGreen = UIColor(named: "rw-green")!
  static let hotPink = UIColor(named: "hotPink")!
}
