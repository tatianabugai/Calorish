//
//  ProgressBarView.swift
//  Calorish
//
//  Created by admin on 18.05.2022.
//  Copyright © 2022 Tatiana Bugai. All rights reserved.
//

import UIKit

struct ProgressBarViewModel {
    var color: UIColor
    var progress: Double
    //var frame: CGRect
}

@IBDesignable
class ProgressBarView: UIView {
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        return view
    }()
    
    let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.662745098, blue: 0.9137254902, alpha: 1)
        return view
    }()
    
    var progress: Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(backgroundView)
        backgroundView.addSubview(progressView)
    }
    
    override func layoutSubviews() {
        backgroundView.frame = bounds
        backgroundView.layer.cornerRadius = backgroundView.bounds.height / 2
        progressView.frame = progressViewFrame(for: progress)
    }
    
    func setup(with viewModel: ProgressBarViewModel) {
        progressView.backgroundColor = viewModel.color
        progress = viewModel.progress
        progressView.frame = progressViewFrame(for: progress)
        layoutIfNeeded()
    }
    
    private func progressViewFrame(for progress: Double) -> CGRect {
        let multiplier = (progress > 1) ? 1 : progress
        let width = multiplier * backgroundView.bounds.width
        let height = backgroundView.bounds.height
        let size = CGSize(width: width, height: height)
        let frame = CGRect(origin: CGPoint.zero, size: size)
        return frame
    }
}
