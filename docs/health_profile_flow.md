# AnyFeast Health Profile Setup Flow

This document summarizes the 12-step Health Profile Setup wizard implemented in `lib/main.dart`, and how it supports AnyFeast’s core value: delivering authentic recipes **plus** rare/exotic ingredients matched to each user.

---

## Brand Context: AnyFeast

AnyFeast is a culinary service that:
- Delivers **recipes + exact ingredients**, including rare, authentic, exotic items.
- Helps users explore diverse cuisines that are often blocked by ingredient availability.
- Sources high-quality, hard-to-find ingredients so recipes can be recreated authentically at home.
- Optimizes for **convenience + authenticity**: users receive everything they need to cook, not just instructions.

The 12-step flow captures the data needed to:
- Compute accurate nutrition (BMR/TDEE, macros).
- Respect safety (allergies) and preferences (dislikes, cuisines, diet types).
- Match recipe difficulty and equipment needs to each user.
- Keep ingredient boxes affordable and realistic to cook.

---

## High-Level Flow

Entry point: `MealPlannerScreen` → "Complete Profile" → 12-step wizard.
Final step: `HealthPlanSummaryScreen` → shows computed metrics & profile summary.

### Step 0: Entry
- **Screen:** `MealPlannerScreen`
- **Role:** Intro to weekly meal planner. Call-to-action: "Complete Profile".
- **Transition:** Navigates to `HealthProfileSetup` (Step 1).

---

## Phase 1 – Physiological Baseline

### Step 1: Gender
- **Screen:** `HealthProfileSetup`
- **Question:** "What is your gender?"
- **State:** `selectedGender` (Male/Female/Other).
- **Purpose:** Affects BMR and calorie calculations.
- **Next:** `BirthDateSetup` (Step 2).

### Step 2: Birth Date
- **Screen:** `BirthDateSetup`
- **Question:** "When were you born?"
- **State:** `selectedDay`, `selectedMonth`, `selectedYear`.
- **Purpose:** Age → used in BMR and long-term planning.
- **Next:** `MeasurementSetup` (Step 3).

### Step 3: Measurements
- **Screen:** `MeasurementSetup`
- **Question:** "What are your measurements?"
- **State:** `isMetric`, height, weight (via text fields).
- **Purpose:** Height + weight → BMI, BMR, macro targets.
- **Next:** `GoalSetupScreen` (Step 4).

### Step 4: Primary Goal
- **Screen:** `GoalSetupScreen`
- **Question:** "What is your primary goal?"
- **State:** `selectedGoal` (Lose / Maintain / Gain Weight).
- **Purpose:** Sets direction for calorie surplus/deficit.
- **Next:** `TargetWeightSetup` (Step 5).

### Step 5: Target Weight
- **Screen:** `TargetWeightSetup`
- **Question:** "What is your target weight?"
- **State:** `isMetric`, `currentWeight`, target weight (input).
- **Purpose:** Defines end-state for weight; used with goal & pace.
- **Next:** `PacingSetupScreen` (Step 6).

### Step 6: Pacing
- **Screen:** `PacingSetupScreen`
- **Question:** "How fast do you want to gain?" (or change weight).
- **State:** `selectedPace` (Slow & Steady / Moderate / Aggressive / Maximum).
- **Purpose:** Controls weekly change rate → adjusts calorie delta.
- **Next:** `ActivitySetupScreen` (Step 7).

---

## Phase 2 – Lifestyle & Activity

### Step 7: Activity Level & Main Activities
- **Screen:** `ActivitySetupScreen`
- **Questions:**
  - "How active are you?" → activity level.
  - "What’s your main activity?" → specific activities.
- **State:**
  - `selectedLevel` (Sedentary / Light / Moderate / Very Active / Extra Active).
  - `selectedActivities` (Running, Swimming, Yoga, etc.).
- **Purpose:**
  - Level → TDEE multiplier.
  - Activities → richer personalization for plans.
- **Next:** `DietPlanSetup` (Step 8).

---

## Phase 3 – Dietary Rules & Safety

### Step 8: Diet Plan
- **Screen:** `DietPlanSetup`
- **Question:** "What is your diet plan?"
- **State:** `selectedDiet` (Vegetarian, Halal, Keto, Jain, etc.).
- **Purpose:** Hard constraints on recipe/ingredient selection.
  - Ensures AnyFeast only ships diet-compliant ingredients (e.g., Halal only, no meat for vegetarian/vegan).
- **Next:** `AllergySetupScreen` (Step 9).

### Step 9: Allergies & Dislikes
- **Screen:** `AllergySetupScreen`
- **Questions:**
  - Critical allergies (Peanuts, Tree Nuts, Shellfish, etc.).
  - Food dislikes (Mushrooms, Cilantro, etc.).
- **State:**
  - `selectedAllergies` (Set<String>).
  - `selectedDislikes` (Set<String>).
- **Purpose:**
  - **Safety layer:** never include allergenic ingredients.
  - **Preference layer:** avoid disliked ingredients in recipes & boxes.
- **Next:** `PreferencesBudgetScreen` (Step 10).

---

## Phase 4 – Culinary Preferences & Logistics

### Step 10: Preferences & Budget
- **Screen:** `PreferencesBudgetScreen`
- **Sections:**
  - Preferred cuisines (Indian, Chinese, Italian, Japanese, etc.).
  - Health goals (Muscle Gain, Heart Health, Brain Health, Skin Health).
  - Cooking time preference (15–30 mins vs 45–60 mins).
  - Kitchen setup (Air Fryer, Rice Cooker, Full Kitchen).
  - Heavy meal timing (Breakfast, Lunch, Dinner).
  - Vegetarian days (per weekday toggle).
  - Weekly budget (slider: ₹1000–₹10000).
- **State:**
  - `selectedCuisines`, `selectedGoals`, `cookTime`, `kitchenSetup`,
    `heavyMeal`, `vegDays`, `budget`.
- **Purpose:**
  - Aligns AnyFeast’s ingredient + recipe bundle with:
    - Authentic cuisines the user actually wants.
    - Time and equipment they truly have.
    - Budget they can sustain.
  - Directly drives recommended recipes and ingredient sourcing.
- **Next:** `CookingLevelScreen` (Step 11).

### Step 11: Cooking Level
- **Screen:** `CookingLevelScreen`
- **Question:** "What’s your cooking level?" (humorous tone).
- **State:** `selectedLevel` (Me No Cooking → Me Gordon Ramsay).
- **Purpose:**
  - Match recipe complexity & techniques to user skill.
  - Ensure rare/exotic ingredients don’t go to waste because recipes are too hard.
- **Next:** `HealthPlanSummaryScreen` (Step 12).

---

## Phase 5 – Summary & Onboarding into Meal Planning

### Step 12: Health Plan Summary
- **Screen:** `HealthPlanSummaryScreen`
- **Content:**
  - Progress header (Step 12 of 12, 100%).
  - Gradient metrics card:
    - BMI
    - BMR (calories/day)
    - TDEE (calories/day)
    - Daily calorie goal
  - Summary cards:
    - Protein target (g/day).
    - Goal description (e.g., Maintain Weight, 1.0 kg/week).
  - Small status boxes:
    - Diet plan (e.g., Halal).
    - Activity level (e.g., Very Active).
  - Detailed info box for cuisines and allergies.
  - Tip box explaining "Complete Setup".
- **Purpose:**
  - Show tangible value immediately (numbers + clear plan).
  - Confirm back to the user that their inputs are understood.
  - Hand-off point to:
    - Meal plan generator.
    - Ingredient box generator.

---

## Navigation Chain Summary

1. `MealPlannerScreen` → `HealthProfileSetup` (Step 1)
2. `HealthProfileSetup` → `BirthDateSetup` (Step 2)
3. `BirthDateSetup` → `MeasurementSetup` (Step 3)
4. `MeasurementSetup` → `GoalSetupScreen` (Step 4)
5. `GoalSetupScreen` → `TargetWeightSetup` (Step 5)
6. `TargetWeightSetup` → `PacingSetupScreen` (Step 6)
7. `PacingSetupScreen` → `ActivitySetupScreen` (Step 7)
8. `ActivitySetupScreen` → `DietPlanSetup` (Step 8)
9. `DietPlanSetup` → `AllergySetupScreen` (Step 9)
10. `AllergySetupScreen` → `PreferencesBudgetScreen` (Step 10)
11. `PreferencesBudgetScreen` → `CookingLevelScreen` (Step 11)
12. `CookingLevelScreen` → `HealthPlanSummaryScreen` (Step 12)

---

## How This Supports AnyFeast’s Value Proposition

- **Authentic ingredients:**
  - Diet type, allergies, dislikes, cuisines → drive which regions & ingredients to source.
- **Exotic, hard-to-find items:**
  - Cuisines + budget + kitchen setup → decide when to propose premium/rare ingredients.
- **Convenience:**
  - Cooking time, skill, equipment → guarantees the box is actually cookable.
- **Health alignment:**
  - Gender, age, measurements, goals, pacing, activity → power the nutrition engine for calorie and macro targets.

This file is intended as a stable reference for how the current UI flow is structured, what data each step collects, and how it should inform AnyFeast’s future backend models, recommendation systems, and ingredient logistics.
