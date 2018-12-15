//
//  ViewHandler.swift
//  CTATracker
//
//  Created by Rob Timpone on 12/15/18.
//  Copyright © 2018 Rob Timpone. All rights reserved.
//

import UIKit

class ViewHandler {
    
    enum State {
        case loading
        case display
        case error
    }
    
    weak var displayView: UIView?
    weak var errorView: UIView?
    weak var loadingView: UIView?
    weak var loadingIndicator: UIActivityIndicatorView?
    
    init(displayView: UIView, errorView: UIView, loadingView: UIView, loadingIndicator: UIActivityIndicatorView) {
        self.displayView = displayView
        self.errorView = errorView
        self.loadingView = loadingView
        self.loadingIndicator = loadingIndicator
    }
    
    func showLoadingState() {
        updateViews(forState: .loading)
    }
    
    func showErrorState() {
        updateViews(forState: .error)
    }
    
    func showDisplayState() {
        updateViews(forState: .display)
    }
}

private extension ViewHandler {
    
    func updateViews(forState state: State) {
        
        displayView?.isHidden = state != .display
        errorView?.isHidden = state != .error
        loadingView?.isHidden = state != .loading
        
        if state == .loading {
            loadingIndicator?.startAnimating()
        }
        else {
            loadingIndicator?.stopAnimating()
        }
    }
}

