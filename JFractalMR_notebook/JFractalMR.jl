### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 97309d3e-4595-413a-a3f6-dace2611a700
# ╠═╡ show_logs = false
begin
using Pkg
	
Pkg.add(url = "https://github.com/MartiRoc/Fractal.jl.git")
using Fractal
	
Pkg.add("PlutoUI")
using PlutoUI
end

# ╔═╡ d2158060-9855-11ed-1196-1136912e2485
md"# Fonction JFractalMR du package Fractal.jl"

# ╔═╡ 914d7c5a-7db1-42a9-a561-9bfc2de40b8a
md"
Le but de ce notebook est de présenter de manière interactive la fonction principale du package **Fractal.jl** qui permet de représenter des ensembles de Julia. Pour plus d'informations sur le package cliquer [ici](https://github.com/MartiRoc/Fractal.jl).

Si vous ne disposez pas d'un environnement Julia pour éxécuter et rendre interactif ce notebook, cliquer sur - **Edit** or **Run** this notebook- en haut à droite de la page puis cliquer sur binder. Le notebook va être éxécuté sur le web (cela peut prendre quelques minutes).

Tout au long du document vous pouvez observer l'influence des paramètres sur l'image à l'aide du bouton _show_.
"

# ╔═╡ b4325dc1-9fc0-4056-91ad-b49947ca9dc1
md"## Les paramètres de JFractalMR"

# ╔═╡ 7f8eac90-db89-435d-a18c-045099f930e4
md"### Le complexe c

C'est le seul paramètre qui ne possède pas de valeur par défaut. Il caractérise mathématiquement la fractale. Choisir respectivement la partie réelle et la partie imaginaire:

"

# ╔═╡ a9d0ea0c-5a87-4286-be89-f12bb2947dbc
md" **Re(c) =** $(@bind cx NumberField(-1:0.01:1, default=-0.4)) "

# ╔═╡ 4787244c-a865-49ae-8bd9-d3ad1b623d00
md" **Im(c) =** $(@bind cy NumberField(-1:0.01:1, default=0.68)) "

# ╔═╡ 30b807ce-ce64-466e-9bf9-4db0623d792c
md"
**c = $(c = cx + cy*im).**
"

# ╔═╡ c452262d-bf42-48e5-9583-29c0997f303f
md"**show** $(@bind s1 CheckBox(default=false))"

# ╔═╡ c9f0b7c4-8b7e-4cdf-a1aa-d0a9c099f604
md"### L'agoritme utilisé

Deux algorithmes sont disponibles pour approximer la fractale de paramètre **c**, le choix se fait par le paramètre **algo**. 

Par défaut l'algorithme 'Escape Time' ou 'Temps de fuite' est utilisé, il consiste à quadriller la région du plan contenant la fractale puis à tester si chacun des éléments du quadrillage appartient ou non à la fractale. La finesse du quadrillage est définie par le paramètre **len** et la dureté du test que vont subir chacun des points du quadrillage par **I**.

Le second algorithme dit d'Itérations Inverses' est basé sur un résultat mathématique et permet de calculer **BxNxN** points appartenant à la fractale avec **B** et **N** deux entiers pouvant être modifiés. 

Choisir l'algorithme :
"

# ╔═╡ 9b6dbd2e-00c3-469a-bb39-85dd858473ca
@bind algo Select(["ET" => "Temps de fuite","INV" => "Itérations inverses"], default="Temps de fuite")

# ╔═╡ e04ffb0e-19a2-4b63-9c91-e272351536e8
md"""
**algo = '$(algo)'.**
"""

# ╔═╡ 3ac0bd6a-4df5-4d41-8e2f-99b1756d2f0f
if algo == "ET"
	md" **len =** $(@bind len NumberField(0:20000, default=4000)) \
	**I =** $(@bind I NumberField(0:500, default=25))"
else
	md" **B =** $(@bind B NumberField(0:20, default=5)) \
	**N =** $(@bind N NumberField(0:2:1000, default=648)),  nombre de points calculés:"
end

# ╔═╡ 6e7d97ed-bf0b-49c8-95b8-0900431b07c0
if algo == "INV"
	B*N*N
end

# ╔═╡ dc22ef7e-7e28-4897-a9d0-967b1f589af7
md"**show** $(@bind s2 CheckBox(default=false))"

# ╔═╡ abb91812-a451-4127-a59f-4ff3aad764a9
md"### Paramètres de l'image 

#### Format et définition 

Le format de l'image, par défaut un carré, est défini par le rapport entre **fL** (largeur) et **fl** (longueur) 

**fL =** $(@bind fL NumberField(0:30, default=10)) \
**fl =** $(@bind fl NumberField(0:30, default=10))
"

# ╔═╡ 93666b6a-edc6-4fd0-8907-66d6fff943f1
Fractal.Gray.(zeros(Int8,(fL,fl)).+0.2)

# ╔═╡ 3f41608f-711e-4d68-9338-167c9784547c
md"
La définition de l'image est régie par **r**, l'image possèdera une définition de **r x fL x 100** pixels verticaux pour **r x fl x 100** pixels horizontaux,

**r =** $(@bind r NumberField(0:30, default=2)), définition :
"


# ╔═╡ edddd3be-9abf-4ebb-b398-f43b797b318b
md" $(r*fl*100) x $(r*fL*100)"

# ╔═╡ e8ee00b9-d9d4-4048-8652-a8473cb16025
md"**show** $(@bind s3 CheckBox(default=false))"

# ╔═╡ 41be8e02-c72d-441e-8191-b5b94d76a46c
md" #### Déformation / Rognage

Il est possible de déformer la fractale à l'aide des paramètres **xc** et **yc** qui respectivement dilatent la fractale horizontalement et verticalement,

**xc =** $(@bind xc NumberField(0:0.05:20, default=1)) \
**yc =** $(@bind yc NumberField(0:0.05:20, default=1))
"

# ╔═╡ 4183640b-dcd7-4104-b413-545f3e1d7c83
md" 
Le rognage de l'image est régi par les couples **xa** et **ya** qui définissent respectivement l'intervalle des abscisses et celui des ordonnées qui vont être représentés, 

**xa =** ( $(@bind xa1 NumberField(-2:0.05:0, default=-2)) , $(@bind xa2 NumberField(0:0.05:2, default=2)) ) \
**ya =** ( $(@bind ya1 NumberField(-2:0.05:0, default=-2)) , $(@bind ya2 NumberField(0:0.05:2, default=2)) )


"

# ╔═╡ ae7532f7-bcbe-4857-aeb0-51a2c009ef58
md" Rectangle représenté : [ $(xa1) , $(xa2) ] x [ $(ya1) , $(ya2) ]."

# ╔═╡ 323c7e45-a660-459e-98e6-ea5ed6e6987d
md"**show** $(@bind s4 CheckBox(default=false))"

# ╔═╡ 09f9cf0d-1b71-4363-b061-854d0454485d
md" ### La couleur

Les couleurs de l'image suivent le modèle _HSV_ ou _TSV_ en francais, pour plus d'informations cliquer [ici](https://fr.wikipedia.org/wiki/Teinte_Saturation_Valeur). Ce modèle permet à l'aide d'un triplet de valeurs de définir toutes les couleurs,

![](https://upload.wikimedia.org/wikipedia/commons/1/1b/Triangulo_HSV.png)
"

# ╔═╡ a60932dc-697f-4dac-8821-0ad430602e21
md" #### Colorisation simple 

La couleur du fond est donnée par le paramètre **bg** (_background_), celle de la fractale par **fg** (_foreground_).
"

# ╔═╡ 1a49d3e8-1412-4581-b9c9-050dd01a299c
md"
 $(@bind bgh NumberField(0:10:360, default=360)) , $(@bind bgs Slider(0:0.05:1, default=0, show_value=true)), $(@bind bgv Slider(0:0.05:1, default=0.3, show_value=true))
"

# ╔═╡ efee7fe2-5aff-4f97-9ac9-3f5c776c2ff2
md"
**bg = HSV( $(bgh) , $(bgs) , $(bgv) )** 
"

# ╔═╡ c5c24ced-9646-4494-8a52-5ee9d52936c9
md"
 $(@bind fgh NumberField(0:10:360, default=180)) , $(@bind fgs Slider(0:0.05:1, default=1, show_value=true)), $(@bind fgv Slider(0:0.05:1, default=1, show_value=true))
"

# ╔═╡ e1e5d8c1-9b73-41ce-920c-e512d608602d
md"
**fg = HSV( $(fgh) , $(fgs) , $(fgv) )** 
"

# ╔═╡ 134d7236-ffa5-4e75-9570-1e9301daa434
md" **bg=** $(bg = HSV(bgh,bgs,bgv)), **fg=** $(fg = HSV(fgh,fgs,fgv)) "

# ╔═╡ b118228a-7bce-457a-bfec-f2f2e9be4deb
md"**show** $(@bind s5 CheckBox(default=false))"

# ╔═╡ 458cfed8-220c-4054-b8a2-9331a230417f
md" #### Colorisation irrisée

Intégrer l'option **rainbow = true** à l'appel de la fonction permet de colorer la fractale d'une couleur variable de gauche à droite, par défaut :
"

# ╔═╡ 1387c0e4-b0e7-43af-9b33-b02fc1480f24
range(HSV(0,1,1), stop=HSV(360,1,1), length=1000)

# ╔═╡ 3f0a75af-5823-41d7-bdd6-98533ace75ff
md"Les paramètres **h**, **s**, **v** et **a** permettent de controler l'irrisation, **h**, **s** et **v** définissent respectivement la couleur de départ, la saturation et la valeur de l'irrisation (triplet _HSV_). Quant à **a**, il régit le déplacement angulaire des couleurs à partir de la couleur de départ (c.f. le cercle _HSV_ plus haut)."

# ╔═╡ 7085c315-bda1-48b3-be4e-5b7322aba3d0
md"
 **h=** $(@bind h NumberField(0:10:360, default=180)) **s=** $(@bind s Slider(0:0.05:1, default=1, show_value=true)) **v=** $(@bind v Slider(0:0.05:1, default=1, show_value=true))
"

# ╔═╡ 0e527dd1-4cdb-42b5-81d0-3c22061b00e9
md" **a=** $(@bind a Slider(0:10:720, default=360, show_value=true)) "

# ╔═╡ d613484b-9459-488e-bfeb-0b08e47278f2
range(HSV(h,v,a), stop=HSV(h+a,s,v), length=1000)

# ╔═╡ 8eb5d187-eacb-40aa-a7fa-76aea52085f3
md" **rainbow =** $(@bind rainbow CheckBox(default=false))"

# ╔═╡ a2f5168d-3527-478b-8f64-bb24716cc5f0
md"**show** $(@bind s6 CheckBox(default=false))"

# ╔═╡ 96ba5aef-60a1-4d0f-bb44-420229bcd191
md""" ### Sauvegarde de l'image et tips

La fonction renvoie une image, qu'il est possible de sauvegarder sur votre machine en indicant **dl = true** à la fonction. Vous pouvez aussi renseigner l'endroit où enregistrer l'image en indicant, \
**PATH = "chemin vers un dossier"**.

"""

# ╔═╡ ac591c54-38f3-46b9-835f-b21a1310204f
md"Enfin **tips = true** donne de petits conseils quant à la génération de l'image par l'algorithme _ET_ à chaque appel de la fonction. Vous pourriez avoir envi d'indiquer **tips = false** pour que cela cesse."

# ╔═╡ 7ee67682-962e-4524-8077-66692acadeda
md" **tips =** $(@bind tips CheckBox(default=true))"

# ╔═╡ aba85dca-75bd-49e7-8e00-988117d1ff14
md"### Generation de l'image"

# ╔═╡ 8dc984a0-0f4d-4a8f-8031-529df38bfa72
# On doit discriminer l'appel de la fonction car suivant l'algorithme choisi, les paramètres de l'autre ne sont pas déclarés.

if algo == "INV"
	img = JFractalMR(c, algo=algo, N=N, B=B, xa=(xa1,xa2), ya=(ya1,ya2), xc=xc, yc=yc, fl=fl, fL=fL, r=r, bg=bg, fg=fg, rainbow=rainbow, h=h, s=s, v=v, a=a, tips=tips)
else
	img = JFractalMR(c, algo=algo, len=len, I=I, xa=(xa1,xa2), ya=(ya1,ya2), xc=xc, yc=yc, fl=fl, fL=fL, r=r, bg=bg, fg=fg, rainbow=rainbow, h=h, s=s, v=v, a=a,tips=tips)
end

# ╔═╡ 9b871eef-4f1f-4a86-9860-01c6dfcac0ee
if s1
	img
end

# ╔═╡ de39b6a3-d02e-46a6-a189-880212b2856b
if s2
	img
end

# ╔═╡ efd86e16-cc44-48fa-a8f2-39ef2ca70614
if s3
	img
end

# ╔═╡ 743c5ee1-ae61-4166-b7f2-a603a767a1e1
if s4
	img
end

# ╔═╡ bc046191-2e14-4ec1-8ff4-50fc46c3c2ca
if s5
	img
end

# ╔═╡ 3da71237-199e-431b-9fe5-287a13a7579d
if s6
	img
end

# ╔═╡ 7e73ad0a-b00b-47eb-8e47-7665c7d020c9
md"
Voici à quoi ressemble l'appel de la fonction en julia: 

JFractalMR(c, algo=algo, N=N, B=B, len=len, I=I, xa=(xa1,xa2), ya=(ya1,ya2), xc=xc, yc=yc, fl=fl, fL=fL, r=r, bg=bg, fg=fg, rainbow=rainbow, h=h, s=s, v=v, a=a, tips=tips)

"

# ╔═╡ d31e5e14-28de-4614-83be-4a22890463ff
TableOfContents(title = "Sommaire", indent = true, depth = 5)

# ╔═╡ Cell order:
# ╟─97309d3e-4595-413a-a3f6-dace2611a700
# ╟─d2158060-9855-11ed-1196-1136912e2485
# ╟─914d7c5a-7db1-42a9-a561-9bfc2de40b8a
# ╟─b4325dc1-9fc0-4056-91ad-b49947ca9dc1
# ╟─7f8eac90-db89-435d-a18c-045099f930e4
# ╟─a9d0ea0c-5a87-4286-be89-f12bb2947dbc
# ╟─4787244c-a865-49ae-8bd9-d3ad1b623d00
# ╟─30b807ce-ce64-466e-9bf9-4db0623d792c
# ╟─c452262d-bf42-48e5-9583-29c0997f303f
# ╟─9b871eef-4f1f-4a86-9860-01c6dfcac0ee
# ╟─c9f0b7c4-8b7e-4cdf-a1aa-d0a9c099f604
# ╟─9b6dbd2e-00c3-469a-bb39-85dd858473ca
# ╟─e04ffb0e-19a2-4b63-9c91-e272351536e8
# ╟─3ac0bd6a-4df5-4d41-8e2f-99b1756d2f0f
# ╟─6e7d97ed-bf0b-49c8-95b8-0900431b07c0
# ╟─dc22ef7e-7e28-4897-a9d0-967b1f589af7
# ╟─de39b6a3-d02e-46a6-a189-880212b2856b
# ╟─abb91812-a451-4127-a59f-4ff3aad764a9
# ╟─93666b6a-edc6-4fd0-8907-66d6fff943f1
# ╟─3f41608f-711e-4d68-9338-167c9784547c
# ╟─edddd3be-9abf-4ebb-b398-f43b797b318b
# ╟─e8ee00b9-d9d4-4048-8652-a8473cb16025
# ╟─efd86e16-cc44-48fa-a8f2-39ef2ca70614
# ╟─41be8e02-c72d-441e-8191-b5b94d76a46c
# ╟─4183640b-dcd7-4104-b413-545f3e1d7c83
# ╟─ae7532f7-bcbe-4857-aeb0-51a2c009ef58
# ╟─323c7e45-a660-459e-98e6-ea5ed6e6987d
# ╟─743c5ee1-ae61-4166-b7f2-a603a767a1e1
# ╟─09f9cf0d-1b71-4363-b061-854d0454485d
# ╟─a60932dc-697f-4dac-8821-0ad430602e21
# ╟─1a49d3e8-1412-4581-b9c9-050dd01a299c
# ╟─efee7fe2-5aff-4f97-9ac9-3f5c776c2ff2
# ╟─c5c24ced-9646-4494-8a52-5ee9d52936c9
# ╟─e1e5d8c1-9b73-41ce-920c-e512d608602d
# ╟─134d7236-ffa5-4e75-9570-1e9301daa434
# ╟─b118228a-7bce-457a-bfec-f2f2e9be4deb
# ╟─bc046191-2e14-4ec1-8ff4-50fc46c3c2ca
# ╟─458cfed8-220c-4054-b8a2-9331a230417f
# ╟─1387c0e4-b0e7-43af-9b33-b02fc1480f24
# ╟─3f0a75af-5823-41d7-bdd6-98533ace75ff
# ╟─7085c315-bda1-48b3-be4e-5b7322aba3d0
# ╟─0e527dd1-4cdb-42b5-81d0-3c22061b00e9
# ╟─d613484b-9459-488e-bfeb-0b08e47278f2
# ╟─8eb5d187-eacb-40aa-a7fa-76aea52085f3
# ╟─a2f5168d-3527-478b-8f64-bb24716cc5f0
# ╟─3da71237-199e-431b-9fe5-287a13a7579d
# ╟─96ba5aef-60a1-4d0f-bb44-420229bcd191
# ╟─ac591c54-38f3-46b9-835f-b21a1310204f
# ╟─7ee67682-962e-4524-8077-66692acadeda
# ╟─aba85dca-75bd-49e7-8e00-988117d1ff14
# ╟─8dc984a0-0f4d-4a8f-8031-529df38bfa72
# ╟─7e73ad0a-b00b-47eb-8e47-7665c7d020c9
# ╟─d31e5e14-28de-4614-83be-4a22890463ff
