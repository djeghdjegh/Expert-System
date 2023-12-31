# Expert-System
This Prolog code defines a simple expert system for mental health diagnosis and advice. The system is implemented using the PCE (Prolog Constraint Extension) library for creating graphical user interfaces.

# Important Predicates and Rules:
### Disease and Symptom Association:
Diseases are associated with symptoms using the maladies/1 predicate.

### Information Display:
afficher_symptomes_associes/3: Displays information about selected disease and associated symptome.

afficher_maladies_associes/3: Displays information about selected symptoms and associated disease.

### Advice:
The conseil/2 predicate provides advice for specific mental health disorders.

# How To RUN:
- Load the Prolog code in an environment that supports the PCE library(ex.Swi-Prolog)
- Run the interface_boutons/0 predicate to launch the main interface.
- Use the buttons to navigate through symptom search, disease search, and advice functionalities.
