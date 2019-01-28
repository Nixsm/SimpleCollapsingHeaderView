//
//  SimpleCollapsingHeaderView.swift
//  SimpleCollapsingHeaderView
//
//  Created by Nicholas Meschke on 01/13/2018.
//  Copyright (c) 2018 Nicholas Meschke. All rights reserved.
//

import UIKit

public protocol SimpleCollapsingHeaderViewDelegate: class {
	func onHeaderDidAnimate(with percentage: CGFloat)
	func onHeaderDidAnimate(with currentValue: (_ min: CGFloat, _ max: CGFloat) -> CGFloat)
}

extension SimpleCollapsingHeaderViewDelegate {
	
	func onHeaderDidAnimate(with percentage: CGFloat) {
		
	}
	
}

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
		
		let currentHeight = self.headerHeightConstraint?.constant ?? 0
		var newHeight: CGFloat = self.headerHeightConstraint?.constant ?? 0
		
		let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
		
		let absoluteTop: CGFloat = 0
//		let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
		
		let isScrollingUp = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
		let isScrollingDown = scrollDiff < 0
		
		if isScrollingUp {
			newHeight = max(minHeight, newHeight - abs(scrollDiff))
		} else if isScrollingDown {
			newHeight = min(maxHeight, newHeight + abs(scrollDiff))
		}
		
		if newHeight != currentHeight {
			headerHeightConstraint?.constant = newHeight
		}
		
		if currentHeight != minHeight, isScrollingUp {
			set(position: self.previousScrollOffset, for: scrollView)
			self.previousScrollOffset = scrollView.contentOffset.y
		}

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
		
		func currentValue(min: CGFloat, max: CGFloat) -> CGFloat {
			let diff = (max - min)*percentage
			return min + diff
		}
		
        delegate?.onHeaderDidAnimate(with: percentage)
		delegate?.onHeaderDidAnimate(with: currentValue)
    }
	
}

