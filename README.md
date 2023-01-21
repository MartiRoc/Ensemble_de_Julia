# Présentation

## Contexte

Dans le cadre des UEs _Logiciel R_ et _Outils de présentation et de recherche reproductible_ du M1 SSD de l'Université Grenoble Alpes, j'ai choisi de travailler autour des fractales et plus particulièrement autour des ensembles de Julia.\
Cette curiosité mathématique, en plus d'être relativement accessible d'un point de vue théorique, possède de très belles propriétés visuelles que je propose ici de représenter à l'aide de différents algorithmes. 

## Objectifs

1. Définir concrètement les ensembles de Julia.
2. Représenter ces ensembles à l'aide de différents algorithmes et langages de programmation (R, julia, ... etc).
3. Mettre en forme et présenter ce travail au moyen d'outils de présentation et plateformes tels que Rmarkdown, Pluto notebooks et github.
4. Elaborer un package Julia avec les fonctions génératrices de fractales implémentées. 

## Contenu & descriptions

Ce dépôt contient les fichiers et dossiers suivants,

- _Rapport.pdf_ : présente la théorie autour des ensembles de Julia, des réflexions autour des algorithmes utilisés pour représenter les fractales ainsi que des premiers essais d'implémentation. Il a été généré à partir du fichier _Rapport.rmd_. 

- _Julia_fonctions.jl_ : est le "corps" de ce projet. C'est un script auto-suffisant (peut être exécuté tel quel) en langage de programmation julia exhaustivement commenté de tout mon parcours jusqu'à l'élaboration d'une fonction finale (**JFractalMR**) "optimisée" à la représentation des ensembles de Julia. Cette fonction et toutes celles de ce script sont disponibles via le package **Fractal.jl** présenté ci-dessous. 

- _JFractalMR_notebook_ : est un dossier qui contient un Pluto notebook interactif (et sa version HTML statique) présentant en détail la fonction **JFractalMR()** ainsi que toutes ses fonctionnalités. En haut à droite de la version HTML statique est expliqué comment faire marcher la version intéractive (**Edit** or **run** this notebook).

- _Galerie_ : est un dossier qui contient quelques unes de mes créations, dont mon fond d'écran actuel :). 

## Package Fractal.jl

https://github.com/MartiRoc/Fractal.jl
