////
////  ProgressBarViewLayout.swift
////  Calorish
////
////  Created by admin on 18.05.2022.
////  Copyright © 2022 Tatiana Bugai. All rights reserved.
////
//
//import UIKit
//
//class ProgressBarViewLayout {
//    
//    private let screenWidth: CGFloat
//    
//    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
//        self.screenWidth = screenWidth
//    }
//    
//    private func frame(for progress: Double) -> CGRect {
//        let multiplier = (progress > 1) ? 1 : progress
//        let width = multiplier * backgroundView.bounds.width
//        let height = backgroundView.bounds.height
//        let size = CGSize(width: width, height: height)
//        let frame = CGRect(origin: CGPoint.zero, size: size)
//        return frame
//    }
//}
//
//struct Constants {
//    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
//    static let topViewHeight: CGFloat = 45
//    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 7, left: 8, bottom: 8, right: 8)
//    static let postLabelFont = UIFont.systemFont(ofSize: 15)
//}
//
//protocol FeedCellLayoutCalculatorProtocol {
//    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
//}
//
//final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
//    
//    private let screenWidth: CGFloat
//    
//    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
//        self.screenWidth = screenWidth
//    }
//    
//    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
//        
//        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
//        
//        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
//                                    size: CGSize.zero)
//        
//        if let postText = postText, !postText.isEmpty {
//            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
//            let height = postText.height(width: width, font: Constants.postLabelFont)
//            postLabelFrame.size = CGSize(width: width, height: height)
//        }
//        
//        return Sizes(postLabelFrame: postLabelFrame,
//                     attachmentFrame: CGRect.zero,
//                     bottomView: CGRect.zero,
//                     totalHeight: 300)
//    }
//}
