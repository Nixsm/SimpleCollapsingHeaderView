//
//  SimpleCollapsingHeaderView.swift
//  SimpleCollapsingHeaderView
//
//  Created by Nicholas Meschke on 01/13/2018.
//  Copyright (c) 2018 Nicholas Meschke. All rights reserved.
//

import UIKit

@IBDesignable
public class SimpleCollapsingHeaderView: UIView {
    
    // MARK: Properties
    
    var previousScrollOffset: CGFloat = -1
    
    // MARK: Outlets
    
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!

    // MARK: IBInspectables
    
    @IBInspectable
    var minHeight: CGFloat = 44

    @IBInspectable
    var maxHeight: CGFloat = 44

    // MARK: Delegate
    
    public var delegate: SimpleCollapsingHeaderViewDelegate?

    // MARK: Overrides

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard headerHeightConstraint != nil else {
            headerHeightConstraint = heightAnchor.constraint(equalToConstant: maxHeight)
            headerHeightConstraint.isActive = true
            return
        }
        headerHeightConstraint?.constant = maxHeight
    }
}

public extension SimpleCollapsingHeaderView {
    func collapseHeaderView(using scrollView: UIScrollView, and previousScrollOffset: CGFloat? = nil) {
        
        guard canAnimateHeader(scrollView) else { return }
        
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        
        if var newHeight = headerHeightConstraint?.constant {
            if isScrollingDown {
                newHeight = max(minHeight, newHeight - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeight, newHeight + abs(scrollDiff))
            }
            
            if newHeight != headerHeightConstraint?.constant {
                headerHeightConstraint?.constant = newHeight
                set(position: self.previousScrollOffset, for: scrollView)
            }
        }

        self.previousScrollOffset = scrollView.contentOffset.y
        updateHeader()
    }
}

private extension SimpleCollapsingHeaderView {
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        guard let heightConstraint = headerHeightConstraint?.constant else {
            return false
        }
        let scrollViewMaxHeight = scrollView.frame.height + heightConstraint - minHeight
        
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func set(position: CGFloat, for scrollView: UIScrollView) {
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: position)
    }
    
    func updateHeader() {
        guard let heightConstraint = headerHeightConstraint?.constant else { return }
        let range = maxHeight - minHeight
        let openAmount = heightConstraint - minHeight
        let percentage = openAmount / range
        
        delegate?.onHeaderDidAnimate(with: percentage)
    }
}
