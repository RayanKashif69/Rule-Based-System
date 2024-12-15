/*
 *
The system diagnoses cancer types based on observed symptoms and
calculates the confidence level for each diagnosis. It identifies the
most likely cancer type for a patient by evaluating various symptoms and
their associated probabilities. The current system is limited in scope,
supporting only a small set of cancer types and symptoms, and it assumes
symptom independence in the calculation of confidence. Additionally, it
provides a single most likely diagnosis without considering the
possibility of multiple diagnoses or offering any explanations of how
the conclusions are reached. To improve the system, it could be extended
to include a broader range of symptoms and cancer types, allow for
multiple diagnoses with confidence scores, and implement an explanation
mechanism to increase transparency *
 */


%Facts: Observed signs in patients with severity levels and probabilities
observed_sign(tim, wheezing, critical, 0.9).
observed_sign(tim, chest_pain, critical, 0.8).
observed_sign(tim, coughing_up_blood, moderate, 0.5).

observed_sign(bob, skin_sores, critical, 0.9).
observed_sign(bob, red_patches, critical, 0.78).
observed_sign(bob, low_appetite, moderate, 0.6).

observed_sign(alex, lump_in_breast, critical, 0.7).
observed_sign(alex, redness_and_pain, critical, 0.8).
observed_sign(alex,chest_pain,moderate,0.6).

observed_sign(brian, blood_in_urine, moderate, 0.6).
observed_sign(brian, low_appetite, critical, 0.8).
observed_sign(brian, anemia, moderate, 0.5).

observed_sign(rayan,belly_pain,critical,0.9).
observed_sign(rayan,tiredness,moderate,0.6).


% Lung Cancer: Symptoms include wheezing, chest pain, coughing up blood.
cancer_type(Patient, lung_cancer, Confidence) :-
    observed_sign(Patient, wheezing, critical, WProb),
    observed_sign(Patient, chest_pain, critical, CPProb),
    observed_sign(Patient, coughing_up_blood, moderate, CBProb),
    calculate_confidence([WProb, CPProb, CBProb], Confidence).

% Skin Cancer: Symptoms include skin sores, red patches.
cancer_type(Patient, skin_cancer, Confidence) :-
    observed_sign(Patient, skin_sores, critical, SSProb),
    observed_sign(Patient, red_patches, critical, RPProb),
    observed_sign(Patient, low_appetite, moderate,LAProb),
    calculate_confidence([SSProb, RPProb,LAProb], Confidence).

% Breast Cancer: Symptoms include lump in breast, redness and pain.
cancer_type(Patient, breast_cancer, Confidence) :-
    observed_sign(Patient, lump_in_breast, critical, LBProb),
    observed_sign(Patient, redness_and_pain, critical, RPProb),
    observed_sign(Patient,chest_pain,moderate,CPProb),
    calculate_confidence([LBProb, RPProb,CPProb], Confidence).

% Bladder Cancer: Symptoms include blood in urine, low appetite, anemia.
cancer_type(Patient, bladder_cancer, Confidence) :-
    observed_sign(Patient, blood_in_urine, moderate, BUProb),
    observed_sign(Patient, low_appetite, critical, LAPProb),
    observed_sign(Patient, anemia, moderate, AProb),
    calculate_confidence([BUProb, LAPProb, AProb], Confidence).

% Head and Neck Cancer: Symptoms include wheezing, chest pain, skin sores.
cancer_type(Patient, head_and_neck_cancer, Confidence) :-
    observed_sign(Patient, wheezing, critical, WProb),
    observed_sign(Patient, chest_pain, critical, CPProb),
    observed_sign(Patient, skin_sores, critical, SSProb),
    calculate_confidence([WProb, CPProb, SSProb], Confidence).

% Pancreatic Cancer: Symptoms include blood in urine, low appetite, lump in breast.
cancer_type(Patient, pancreatic_cancer, Confidence) :-
    observed_sign(Patient, blood_in_urine, moderate, BUProb),
    observed_sign(Patient, low_appetite, critical, LAPProb),
    observed_sign(Patient, lump_in_breast, critical, LBProb),
    observed_sign(Patient, tiredness, moderate, TDProb),
    observed_sign(Patient, belly_pain, critical, BPProb),
    calculate_confidence([BUProb, LAPProb, LBProb,TDProb,BPProb], Confidence).

% Base case: if there's only one probability, return it.
calculate_confidence([H], H).
% Recursive case: multiply the head of the list with the result of the rest of the list.
calculate_confidence([H|T], Confidence) :-
    calculate_confidence(T, RemainingConfidence),
    Confidence is H * RemainingConfidence.



% Get the likelihood of all cancer types for a given patient
diagnose(Patient, [CancerType, Confidence]) :-
    cancer_type(Patient, CancerType, Confidence),
    Confidence > 0.  % Only including diagnoses with confidence > 0.



% Find the most likely cancer type for a patient
most_likely_cancer(Patient, MostLikely) :-
    findall([CancerType, Confidence], diagnose(Patient, [CancerType, Confidence]), Diagnoses),
    Diagnoses \= [], % Ensure there are some diagnoses
    find_highest_confidence(Diagnoses, MostLikely).



% Helper to find the highest confidence from a list of diagnoses
find_highest_confidence([[CancerType, Confidence]], [CancerType, Confidence]). % Base case: single item.
find_highest_confidence([[CT1, C1], [CT2, C2] | T], Max) :-
    (C1 >= C2 -> find_highest_confidence([[CT1, C1] | T], Max);
    find_highest_confidence([[CT2, C2] | T], Max)).


/*

    TESTS!


?- diagnose(bob, [CancerType, Confidence]).
CancerType = skin_cancer,
Confidence = 0.42119999999999996 ;
false.


rayan most likely doesnt have cancer thats why the result i false
?- diagnose(rayan, [CancerType, Confidence]).
false.

?- diagnose(alex, [CancerType, Confidence]).
CancerType = breast_cancer,
Confidence = 0.33599999999999997 .

?- most_likely_cancer(bob, MostLikely).
MostLikely = [skin_cancer, 0.42119999999999996].

?- most_likely_cancer(brian, MostLikely).
MostLikely = [bladder_cancer, 0.24].

?- most_likely_cancer(alex, MostLikely).
MostLikely = [breast_cancer, 0.33599999999999997].

rayan most likely doesnt have cancer thats why the result i false
?- most_likely_cancer(rayan, MostLikely).
false


3 tests to show that the following rule calculates confidence ccorrectly
?- calculate_confidence([0.5, 0.4, 0.3], Result).
Result = 0.06 .


?- calculate_confidence([0.9,0.8,0.9], Result).
Result = 0.6480000000000001 ;
false.


?- calculate_confidence([0.9], Result).
Result = 0.9 ;
false.


skin cancer has the highest confidence of cancers
?- most_likely_cancer(X, MostLikely).
MostLikely = [skin_cancer, 0.42119999999999996].



*/
