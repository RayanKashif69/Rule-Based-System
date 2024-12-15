# Cancer Diagnosis System

## Project Overview
This project implements a very basic knowledge-based system for diagnosing various types of cancer based on observed symptoms and their associated probabilities. 
The system evaluates the likelihood of different cancer types for a patient by calculating confidence scores based on symptom severity and probability. 
It aims to provide a foundation for automated medical diagnosis systems.

---

## Features

- **Symptom-Based Diagnosis**: Identifies the type of cancer most likely affecting a patient by analyzing observed symptoms.
- **Confidence Calculation**: Computes confidence scores for each diagnosis using the probabilities of symptoms.
- **Diagnosis Capabilities**: Supports multiple types of cancer, including lung, skin, breast, bladder, head and neck, and pancreatic cancers.
- **Most Likely Diagnosis**: Determines the cancer type with the highest confidence score for a patient.
- **Extensible Architecture**: Designed to allow the addition of more cancer types and symptoms.

---

## System Limitations

- **Basic Rule-Based System**: This is a very basic implementation with significant room for improvement.
- **Limited Scope**: Supports a small set of predefined cancer types and symptoms.
- **Symptom Independence**: Assumes symptoms are independent, which may not always reflect real-world scenarios.
- **Single Diagnosis**: Provides only the most likely diagnosis without considering multiple possibilities.
- **Transparency**: Does not currently explain how conclusions are reached for a diagnosis.

---

## Technical Details

### **Knowledge Representation**
- **Facts**: Represent observed symptoms for patients with severity levels and associated probabilities.
- **Rules**: Define cancer types and their associated symptoms.
- **Confidence Calculation**: Uses a recursive function to calculate the overall confidence of a diagnosis based on symptom probabilities.

### **Cancer Types Supported**
1. Lung Cancer
   - Symptoms: Wheezing, Chest Pain, Coughing up Blood
2. Skin Cancer
   - Symptoms: Skin Sores, Red Patches, Low Appetite
3. Breast Cancer
   - Symptoms: Lump in Breast, Redness and Pain, Chest Pain
4. Bladder Cancer
   - Symptoms: Blood in Urine, Low Appetite, Anemia
5. Head and Neck Cancer
   - Symptoms: Wheezing, Chest Pain, Skin Sores
6. Pancreatic Cancer
   - Symptoms: Blood in Urine, Low Appetite, Lump in Breast, Tiredness, Belly Pain

### **Confidence Calculation**
Confidence scores are calculated as the product of symptom probabilities:

- Base Case: If there is only one symptom, its probability is the confidence.
- Recursive Case: Multiply probabilities for all symptoms.

---

## Sample Usage

### **Diagnosing a Patient**
To determine all possible cancer diagnoses for a patient:
```prolog
?- diagnose(bob, [CancerType, Confidence]).
CancerType = skin_cancer,
Confidence = 0.42119999999999996.
```

### **Finding the Most Likely Cancer Type**
To find the most probable cancer type for a patient:
```prolog
?- most_likely_cancer(bob, MostLikely).
MostLikely = [skin_cancer, 0.42119999999999996].
```

### **Confidence Calculation**
To verify the confidence calculation for a list of probabilities:
```prolog
?- calculate_confidence([0.9, 0.8, 0.9], Result).
Result = 0.6480000000000001.
```

---

## Test Cases

1. **Diagnose Patient**:
   ```prolog
   ?- diagnose(alex, [CancerType, Confidence]).
   CancerType = breast_cancer,
   Confidence = 0.33599999999999997.
   ```

2. **Most Likely Cancer**:
   ```prolog
   ?- most_likely_cancer(alex, MostLikely).
   MostLikely = [breast_cancer, 0.33599999999999997].
   ```

3. **Confidence Calculation**:
   ```prolog
   ?- calculate_confidence([0.5, 0.4, 0.3], Result).
   Result = 0.06.
   ```

---

## Future Enhancements

1. **Expanded Symptom and Cancer Database**: Add more cancer types and symptoms.
2. **Multiple Diagnoses**: Allow for multiple potential diagnoses with confidence scores.
3. **Explanation Mechanism**: Implement features to explain how a conclusion was reached.
4. **Dependency Modeling**: Account for dependencies between symptoms.

---

## How to Use
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/YourRepository.git
   ```
2. Open the Prolog file in your preferred Prolog interpreter.
3. Run queries to diagnose patients or calculate confidence scores.

---

## Author
Rayan Kashif
Developed as part of an AI coursework project.

---

