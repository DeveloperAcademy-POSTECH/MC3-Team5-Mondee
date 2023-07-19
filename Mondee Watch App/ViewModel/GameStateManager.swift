//
//  GameStateManager.swift
//  Mondee Watch App
//
//  Created by Seokmin on 2023/07/15.
//

import WatchKit

class GameStateManager: ObservableObject {
    private var movingDetector = MovingDetector()
    private var motionlessSeconds = 0
    private var movingSeconds = 0
    private var timer: Timer?
    private var isPaused = false
    
    // MARK: Published Properties
    
    @Published var heartCount = Constants.initialHeartCount
    @Published var remainingSeconds = Constants.initialSeconds
    @Published var isCharacterClean = true
    @Published var isCharacterBubbling = false
    @Published var isGameFinished = false
    @Published var isGameSuccessful = false
    @Published var isPreWarning = false
    @Published var isWarning = false
    @Published var isEarlyTerminationPossible = false
    
    // MARK: Game Control Methods
    
    func playGame() {
        SessionExtend.shared.startSession()
        movingDetector.startMotionUpdates()
        startGameTimer()
    }
    
    func pauseGame() {
        isPaused = true
        movingDetector.stopMotionUpdates()
        stopGameTimer()
    }
    
    func resumeGame() {
        isPaused = false
        movingDetector.startMotionUpdates()
        startGameTimer()
    }
    
    func successGameEarly() {
        successGame()
    }
    
    func giveUpGame() {
        failGame()
    }
    
    // MARK: Private Utility Methods
    
    private func startGameTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateGame()
        }
    }
    
    private func stopGameTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateGame() {
        if isGameFinished {
            stopGame()
            return
        }
        
        if isPaused {
            return
        }
        
        setIsEarlyTerminationPossible()
        
        if movingDetector.isMoving {
            handleCharacterBubbling()
            motionlessSeconds = 0
            movingSeconds += 1
        } else {
            isCharacterBubbling = false
            motionlessSeconds += 1
            movingSeconds = 0
        }
        
        isPreWarning = checkIsPreWarning()
        
        if checkIsWarning() {
            isWarning = true
            WKInterfaceDevice.current().play(.notification)
        } else {
            isWarning = false
        }
        
        if checkHeartDecrease() {
            isCharacterClean = false
            heartCount -= 1
            motionlessSeconds = 0
            if heartCount == 0 {
                failGame()
            }
        }
        
        if checkIsCharacterCleanAgain() {
            isCharacterClean = true
        }
        
        if remainingSeconds > 0 {
            remainingSeconds -= 1
        } else {
            successGame()
        }
    }
    
    private func setIsEarlyTerminationPossible() {
        isEarlyTerminationPossible = remainingSeconds <= (Constants.initialSeconds - Constants.terminationPossibleSeconds)
    }
    
    private func handleCharacterBubbling() {
        isCharacterBubbling = true
    }
    
    private func checkIsPreWarning() -> Bool {
        return motionlessSeconds >= Constants.semiWarningThreshold && motionlessSeconds < Constants.warningThreshold
    }
    
    private func checkIsWarning() -> Bool {
        return motionlessSeconds >= Constants.warningThreshold && motionlessSeconds < Constants.dirtThreshold
    }
    
    private func checkHeartDecrease() -> Bool {
        return motionlessSeconds >= Constants.dirtThreshold
    }
    
    private func checkIsCharacterCleanAgain() -> Bool {
        return movingSeconds >= Constants.cleanThreshold
    }
    
    private func successGame() {
        isGameSuccessful = true
        stopGame()
    }
    
    private func failGame() {
        isGameSuccessful = false
        stopGame()
    }
    
    private func stopGame() {
        SessionExtend.shared.stopSession()
        movingDetector.stopMotionUpdates()
        isGameFinished = true
        remainingSeconds = Constants.initialSeconds
    }
}
