//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
var post = PostViewModel()
struct PostListView: View {
  static let taskDateFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMM, HH:mm"
    return formatter
  }()
  let masscotImageSize: CGFloat = 50
  let postImageSize: CGFloat = 100
  
  var body: some View {
    // TODO: This should look exactly like the Birdie table view,
    // but with only one button.
    List(post.posts.indices){index in
      VStack(alignment: .center){
      VStack(alignment: .leading, spacing: 0.0){
        HStack(alignment: .center){
          Image("mascot_swift-badge")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: self.masscotImageSize, height: self.masscotImageSize)
          VStack(alignment: .leading){
            Text(post.posts[index].userName)
            Text("\(post.posts[index].timestamp, formatter: PostListView.taskDateFormat)")
          }
        }
        Text("\(post.posts[index].textBody ?? "")")
          .multilineTextAlignment(.leading)
      }
      
      post.posts[index].uiImage.map{
        Image(uiImage: $0)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: self.postImageSize, height: self.postImageSize)
          
      }
      }
      
    }
  }
}

struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}
