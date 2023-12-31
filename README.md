# Expert-System
This Prolog code defines a simple expert system for mental health diagnosis and advice. The system is implemented using the PCE (Prolog Constraint Extension) library for creating graphical user interfaces.
# Usage Instructions:
## 1-Symptoms and Diseases:
The code defines a set of symptoms (symptomes/1) and their association with various mental health disorders (maladies/1).

## 2-Diagnosis Interface:
interface_symptomes1/0: Opens a diagnostic interface where you can select a disease, input the patient's name, and view associated symptoms.

## 3-Symptom Search Interface:
interface_maladies/0: Opens an interface to search for diseases based on selected symptoms. Input the patient's name, select symptoms, and view the associated diseases.

## 4-Advice Interface:
creer_interface_Conseil/0: Opens an interface to select a mental health disorder and view associated advice.

## 5-Main Interface:
interface_boutons/0: Launches the main interface containing buttons for symptom search, advice, and disease search.

# How To RUN:
- Load the Prolog code in an environment that supports the PCE library(ex.Swi-Prolog)
- Run the interface_boutons/0 predicate to launch the main interface.
- Use the buttons to navigate through symptom search, disease search, and advice functionalities.
