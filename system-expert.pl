:- use_module(library(pce)).

%BASE DE Faits : Sympt�mes
symptomes(agitation).
symptomes(preoccupnation_excessive).
symptomes(tristesse).
symptomes(perte_d_interet).
symptomes(hallucinations).
symptomes(delires).
symptomes(sautes_humeur).
symptomes(impulsivite).
%BADE DE REGLE
maladies(depression) :-symptomes(tristesse).
maladies(depression) :-symptomes(perte_d_interet).
maladies(schizophrenie) :-symptomes(hallucinations).
maladies(schizophrenie) :-symptomes(delires).
maladies(trouble_bipolaire) :-symptomes(sautes_humeur).
maladies(trouble_bipolaire) :-symptomes(impulsivite).
maladies(anxiete):- symptomes(agitation).
maladies(anxiete):- symptomes(preoccupation_excessive).
% Interface qui contient les maladie et quand en clique le boutton il
% nous donne les syptomes
interface_symptomes1 :-
    new(D, dialog('Interface de Diagnostic')),
    send(D, append, new(Name, text_item(name, ''))),
    send(D, append, new(Menu, menu('S�lectionnez une maladie', marked))),
    send(Menu, append, anxiete),
    send(Menu, append, depression),
    send(Menu, append, schizophrenie),
    send(Menu, append, trouble_bipolaire),
    send(D, append, button('Afficher Informations', message(@prolog, afficher_informations1, D, Name, Menu))),

    send(D, open).

% R�gle : Affichage des informations
afficher_informations1(Dialog, NameItem, Menu) :-
    get(NameItem, selection, Name),
    get(Menu, selection, Diagnosis),
    afficher_symptomes_associes(Diagnosis, Name, Dialog).

% R�gle : Affichage des sympt�mes associ�s
afficher_symptomes_associes(Diagnosis, Name, Dialog) :-
    extraire_symptomes(Diagnosis, SymptomesAssocies),
    afficher_interface_symptomes(Dialog, Name, Diagnosis, SymptomesAssocies).

% R�gle : Extraire les sympt�mes d'une maladie
extraire_symptomes(Maladie, Symptomes) :-
    (  maladies(anxiete), Maladie = 'anxiete'
    -> Symptomes=[agitation, preoccupation_excessive]
     ;  writeln('')
    ),
    ( maladies(depression),  Maladie = 'depression'
    -> Symptomes=[tristesse, perte_d_interet]
    ;  writeln('')
    ),

     ( maladies(schizophrenie),  Maladie = 'schizophrenie'
    -> Symptomes=[hallucinations, delires]
     ;  writeln('')
    ),
     ( maladies(trouble_bipolaire),  Maladie = 'trouble_bipolaire'
    -> Symptomes=[sautes_humeur, impulsivite]
     ;  writeln('')
    ).




% R�gle utilitaire pour afficher l'interface des sympt�mes
afficher_interface_symptomes(Dialog,Name, Diagnosis, SymptomesAssocies) :-
    (   ground(SymptomesAssocies)  % V�rifiez si la liste est instanci�e
    ->  atomic_list_concat(SymptomesAssocies, ', ', SymptomesString)  % Convertir la liste en une cha�ne de caract�res
    ;   SymptomesString = 'Liste de sympt�mes non disponible'  % Si la liste n'est pas instanci�e, afficher un message par d�faut
    ),
    new(DialogSymptomes, dialog('Informations du Diagnostic')),
    % Utiliser le pr�dicat send_list pour simplifier l'ajout de plusieurs �l�ments � la fois
    send_list(DialogSymptomes, append,
              [new(NomLabel, label(nom, 'Nom du patient:')),
               new(NomValue, label(nom_value, Name)),
               new(DiagnosticLabel, label(diagnostic, 'Maladie diagnostiqu�e:')),
               new(DiagnosticValue, label(diagnostic_value, Diagnosis)),
               new(SymptomesLabel, label(symptomes, 'Sympt�mes associ�s:')),
               new(SymptomesValue, label(symptomes_value, SymptomesString)),
               button(fermer, message(DialogSymptomes, destroy))]),

    send(DialogSymptomes, open).

% Interface qui affiche les symtomes est nous permettre de trouver la
% maladie qui concerne ces symptomes
interface_maladies :-
    new(D, dialog('Interface de Diagnostic')),
    send(D, append, new(Name, text_item(name, ''))),
    send(D, append, new(Menu, menu('S�lectionnez les symptomes', marked))),
    send(Menu, append, agitation),
    send(Menu, append, tristesse),
    send(Menu, append, perte_d_interet),
    send(Menu, append, delires),
    send(Menu, append, sautes_humeur),
    send(D, append, button('Afficher Informations', message(@prolog, afficher_informations, D, Name, Menu))),

    send(D, open).



afficher_informations(Dialog, NameItem, Menu) :-
    get(NameItem, selection, Name),
    get(Menu, selection, Symptome),
    afficher_maladies_associes(Symptome, Name, Dialog).

% R�gle : Affichage des sympt�mes associ�s
afficher_maladies_associes(Symptomes, Name, Dialog) :-
    extraire_maladies(Diagnosis, Symptomes),
    afficher_interface_maladies(Dialog, Name, Diagnosis, Symptomes).


% R�gle : Extraire les sympt�mes d'une maladie
extraire_maladies(Maladie, Symptomes) :-
   ( symptomes(agitation),  Symptomes='agitation'
    -> Maladie =[anxiete]
     ;  writeln('')
    ),
       ( symptomes(preoccupnation_excessive),  Symptomes='preoccupnation_excessive'
    -> Maladie =[anxiete]
     ;  writeln('')
    ), ( symptomes(tristesse),  Symptomes='tristesse'
    -> Maladie =[depression]
     ;  writeln('')
    ), ( symptomes(perte_d_interet),  Symptomes='perte_d_interet'
    -> Maladie =[depression]
     ;  writeln('')
    ), (symptomes(hallucinations),   Symptomes='hallucinations'
    -> Maladie =[schizophrenie]
     ;  writeln('')
    ), (symptomes(delires),   Symptomes='delires'
    -> Maladie =[schizophrenie]
     ;  writeln('')
    ), (symptomes(sautes_humeur),   Symptomes='sautes_humeur'
    -> Maladie =[trouble_bipolaire]
     ;  writeln('')
    ), ( symptomes(impulsivite),  Symptomes='impulsivite'
    -> Maladie =[trouble_bipolaire]
     ;  writeln('')
    ).

        afficher_interface_maladies(Dialog, Name, Diagnosis, SymptomesAssocies) :-
    (ground(Diagnosis) ->
        atomic_list_concat(Diagnosis, ', ', SymptomesString)
    ; SymptomesString = 'Liste de sympt�mes non disponible'
    ),
    new(DialogSymptomes, dialog('Informations du Diagnostic')),
    send_list(DialogSymptomes, append,
              [new(NomLabel, label(nom, 'Nom du patient:')),
               new(NomValue, label(nom_value, Name)),
               new(DiagnosticLabel, label(diagnostic, 'Maladie diagnostiqu�e:')),
               new(DiagnosticValue, label(diagnostic_value, SymptomesString)),  % Change here
               new(SymptomesLabel, label(symptomes, 'Sympt�mes associ�s:')),
               new(SymptomesValue, label(symptomes_value, SymptomesAssocies)),
               button(fermer, message(DialogSymptomes, destroy))]),

    send(DialogSymptomes, open).
%les conseil qui concerne chaque maladie
conseil(anxiete, [
    "Pratiquez la pleine conscience pour r�duire le stress et l'anxi�t�.",
    "�tablissez une routine quotidienne pour favoriser la stabilit� �motionnelle.",
    "Consid�rez la th�rapie cognitivo-comportementale (TCC) pour g�rer les pens�es anxieuses."
]).

conseil(depression, [
    "Engagez-vous dans des activit�s que vous aimez pour retrouver du plaisir.",
    "Entourez-vous de soutien social, partagez vos sentiments avec des proches.",
    "Consultez un professionnel de la sant� pour discuter des options de traitement."
]).

conseil(schizophrenie, [
    "Consultez imm�diatement un professionnel de la sant� mentale pour �valuation.",
    "Adh�rez strictement � toute prescription m�dicale.",
    "Participez � des groupes de soutien pour partager vos exp�riences et obtenir un soutien."
]).

conseil(trouble_bipolaire, [
    "�tablissez une routine quotidienne pour stabiliser votre humeur.",
    "�vitez les substances qui pourraient d�clencher des �pisodes.",
    "Suivez r�guli�rement avec votre professionnel de la sant� pour ajuster le traitement."
]).

% Cr�ation de la fenetres des conseil
creer_interface_Conseil :-
    new(@main, dialog('Conseils pour les maladies mentales')),
    send(@main, append, new(Menu, menu('S�lectionnez une maladie'))),
    send_list(Menu, append, [anxiete, depression, schizophrenie, trouble_bipolaire]),
    send(@main, append, button('Afficher les conseils', message(@prolog, afficher_conseils, Menu))),
    send(@main, open).

% Afficher les conseils
afficher_conseils(Menu) :-
    get(Menu, selection, Maladie),
    conseil(Maladie, Conseils),
    afficher_conseils_dialog(Conseils).

% Afficher les conseils dans une nouvelle fen�tre
afficher_conseils_dialog(Conseils) :-
    new(Dialog, dialog('Conseils pour la maladie')),
    forall(member(Conseil, Conseils), send(Dialog, append, new(_, text(Conseil)))),
    send(Dialog, append, button('OK', message(Dialog, destroy))),
    send(Dialog, open).
%interface qui contient tous les bouttons
interface_boutons :-
    new(D, dialog('Mental health system Expert')),
    send(D, append, button('Recherche des Symptomes', message(@prolog, interface_symptomes1))),
    send(D, append, button('Donner Conseil pour trouble mentale ', message(@prolog, creer_interface_Conseil))),
    send(D, append, button('Rechercher de la maladie', message(@prolog, interface_maladies))),
    send(D, open).

% Lancer l'interface des boutons
:- interface_boutons.
:- use_module(library(pce)).


