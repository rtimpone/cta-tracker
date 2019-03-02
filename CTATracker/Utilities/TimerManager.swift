//
//  TimerManager.swift
//  CTATracker
//
//  Created by Rob Timpone on 2/27/19.
//  Copyright © 2019 Rob Timpone. All rights reserved.
//

import Foundation

protocol TimerManagerDelegate: class {
    func timerDidFire()
}

class TimerManager {
    
    private var timer: Timer?
    weak var delegate: TimerManagerDelegate?
    let timeInterval: TimeInterval = 1
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] timer in
            self?.delegate?.timerDidFire()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
