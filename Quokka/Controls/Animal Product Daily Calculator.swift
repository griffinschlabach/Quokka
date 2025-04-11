//
//  Animal Product Daily Calculator.swift
//  Quokka
//
//  Created by Allison Tan (student LM) on 4/10/25.
//

import Foundation
struct AnimalProductLandCalculator {
    // Baseline values (yearly consumption from the diagnostic quiz)
    var baselinePorkYearly: Double
    var baselineBeefYearly: Double
    var baselinePoultryYearly: Double
    var baselineFishYearly: Double
    var baselineEggsYearly: Double
    var baselineCheeseYearly: Double
    var baselineDairyYearly: Double

    // Daily consumption values entered in the daily quiz (units per day)
    var dailyPork: Double
    var dailyBeef: Double
    var dailyPoultry: Double
    var dailyFish: Double
    var dailyEggs: Double
    var dailyCheese: Double
    var dailyDairy: Double
    
    /// Calculate the daily CO₂ savings in kilograms.
    func dailyCO2Saving() -> Double {
        // Convert yearly baseline to daily baseline
        let baselineDailyPork    = baselinePorkYearly / 365.0
        let baselineDailyBeef    = baselineBeefYearly / 365.0
        let baselineDailyPoultry = baselinePoultryYearly / 365.0
        let baselineDailyFish    = baselineFishYearly / 365.0
        let baselineDailyEggs    = baselineEggsYearly / 365.0
        let baselineDailyCheese  = baselineCheeseYearly / 365.0
        let baselineDailyDairy   = baselineDairyYearly / 365.0
        
        // Emission factors (kg CO₂e per unit)
        let porkFactor    = 12.0
        let beefFactor    = 27.0
        let poultryFactor = 6.0
        let fishFactor    = 5.0
        let eggsFactor    = 4.5
        let cheeseFactor  = 13.5
        let dairyFactor   = 3.2
        
        let porkSaving    = max(0, baselineDailyPork    - dailyPork)    * porkFactor
        let beefSaving    = max(0, baselineDailyBeef    - dailyBeef)    * beefFactor
        let poultrySaving = max(0, baselineDailyPoultry - dailyPoultry) * poultryFactor
        let fishSaving    = max(0, baselineDailyFish    - dailyFish)    * fishFactor
        let eggsSaving    = max(0, baselineDailyEggs    - dailyEggs)    * eggsFactor
        let cheeseSaving  = max(0, baselineDailyCheese  - dailyCheese)  * cheeseFactor
        let dairySaving   = max(0, baselineDailyDairy   - dailyDairy)   * dairyFactor
        
        return porkSaving + beefSaving + poultrySaving + fishSaving + eggsSaving + cheeseSaving + dairySaving
    }
    
    /// Convert the daily CO₂ saving into land saved in hectares.
    /// 1 ton (1000 kg) of CO₂ offset is equivalent to 0.73 hectares.
    func dailyLandSavedHectares() -> Double {
        let totalCO2SavedKg = dailyCO2Saving()
        return (totalCO2SavedKg / 1000.0) * 0.73
    }
}
