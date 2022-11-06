`sort/2`

# Két predikátumot kell írnia Prolog nyelven.

Az iranylistak/3 predikátum
Írjon egy iranylistak(NM, Fs, ILs) Prolog-eljárást, amely a feladvány alapadataiból előállítja minden egyes fa kezdeti iránylistáját!
Az eljárásnak két bemenő és egy kimenő paramétere van.

Az NM bemenő paraméter egy N-M pár, ahol N ill. M a kert, mint mátrix sorainak ill. oszlopainak a száma.
Az Fs bemenő paraméter a kertbeli fák helyét írja le I-J alakú számpárokból álló f hosszúságú lista formájában, ahol I ill. J az adott fa sorának ill. oszlopának sorszáma.
Az ILs kimenő paraméter egy f hosszúságú lista, amelynek elemei iránylisták. Az ILs lista l-edik eleme azt írja elő, hogy az Fs lista l-edik eleme által meghatározott fához képest melyik oldalszomszéd parcellákra lehet a fához tartozó sátrat helyezni.
Az iranylistak(NM, Fs, ILs) eljáráshívás végrehajtása:

Az Fs lista által megadott fa-pozíciók mindegyikéhez előállít egy iránylistát.
Az iránylista alapértelmezésben mind a négy égtájat tartalmazza (lexikografikus sorrendben)
Ha az adott fa valamelyik oldalszomszédján egy másik fa található, vagy az adott oldalszomszéd a kerten kívül van, akkor az adott oldalszomszédra mutató irányt el kell hagyni az iránylistából.
Más indokkal nem szabad atomokat elhagyni az iránylistából.
Ha legalább egy fa-pozícióhoz egy üres lista van rendelve (ami azt jelenti, hogy a feladványnak nincs megoldása), akkor az ILs kimenő paraméter értéke az üres lista, egyébként pedig a fákhoz rendelt (nem-üres) iránylisták listája kell legyen.
Példák

```prolog
| ?- iranylistak(2-3, [1-1,2-2], ILs).
ILs = [[e,s],[e,n,w]] ? ;
no

| ?- iranylistak(3-3, [1-1,2-1], ILs).
ILs = [[e],[e,s]] ? ;
no

| ?- iranylistak(6-6, [1-3,1-5,3-1,4-6,5-1,5-4,6-5], ILs).
ILs = [[e,s,w],[e,s,w],[e,n,s],[n,s,w],[e,n,s],[e,n,s,w],[e,n,w]] ? ;
no

| ?- iranylistak(2-3, [1-1,1-2,2-1], ILs).
ILs = [] ? ;
no
```

## A sator_szukites/4 predikátum

Írjon egy sator_szukites(Fs, I, ILs0, ILs) Prolog-eljárást, amely azt a helyzetet kezeli, amikor egy adott fához tartozó iránylista már csak egyetlen elemet tartalmaz, azaz egyértelmű, hogy hova kerül az adott fához tartozó sátor. Ilyenkor bizonyos következtetésekkel más fák iránylistáiból el lehet hagyni elemeket: az adott sátor mezőjére, valamint ennek max. 8 szomszédos mezőjére más fa sátra nem kerülhet. Ennek megfelelően szűkíteni kell azoknak a fáknak az iránylistáit, amelyek sátra ezekbe a mezőkbe kerülhet.
Az eljárásnak három bemenő és egy kimenő paramétere van.

Az Fs bemenő paraméter a kertbeli fák helyét a fenti módon leíró f hosszúságú lista.
Az I bemenő paraméter (1 ≤ I ≤ f) az Fs lista által leírt I-edik fát jelöli ki.
Az ILs0 bemenő paraméter a kertbeli fák iránylistáit tartalmazó lista.
Az ILs kimenő paraméter a kertbeli fák esetlegesen szűkített iránylistáit tartalmazó lista.
Az eljárást alapvetően akkor érdemes használni, amikor az ILs0 lista I-edik eleme egy egyelemű (irány)lista, azaz az I-edik fához egyértelműen rendelhető sátor. Ebben az esetben lehetőség nyílik az iránylisták szűkítésére.

Az eljárás megírásakor feltételezhetjük, hogy az ILs0 bemenő paramétert az iranylistak/3 eljárás állította elő, vagy ILs0 ebből szűkítéssel (iránylista-elemek elhagyásával) keletkezett. Tehát az iranylistak/3-ban végzett szűkítéseket itt felesleges megismételni. (A kerten kívüli parcellák felismerésére itt nincs is módunk, hiszen a kert méreteit megadó NM paraméter nem áll rendelkezésünkre.)

A sator_szukites(Fs, I, ILs0, ILs) eljáráshívás végrehajtása:

Ha az ILs0 lista I-edik eleme nem egy egyelemű (irány)lista, akkor az eljáráshívás meghiúsul, ezzel jelezve, hogy a szűkítés nem alkalmazható.
Egyébként (azaz ha az I-edik iránylista egyelemű, és ebből következően az I-edik sátor helye egyértelműen meghatározott) összegyűjti azokat a parcellákat, amelyekre az I-től különböző sorszámú fák (röviden többi fa) sátrai nem kerülhetnek:
az I-edik fához tartozó sátor parcellája;
valamint ennek a parcellának az oldal és sarokszomszédai (maximum 8 ilyen mező lehet).
A többi fa iránylistáiból elhagyja azokat az irányokat, amelyek a fent összegyűjött parcellák valamelyikére mutatnak.
Más indokkal nem szabad atomokat elhagyni az iránylistákból.
Ha legalább egy fa-pozícióhoz egy üres lista van rendelve (ami azt jelenti, hogy a feladványnak nincs megoldása), akkor az ILs kimenő paraméter értéke az üres lista, egyébként pedig a fákhoz rendelt (nem-üres) iránylisták listája kell legyen.
Példák

```prolog
| ?- sator_szukites([1-1,2-2], 2, [[e],[n,s]], ILs).
no

| ?- sator_szukites([1-1,2-2], 2, [[e,s],[s]], ILs).
ILs = [[e],[s]] ? ;
no

| ?- sator_szukites([5-2,2-2], 1, [[n],[e,n,s,w]],ILs).
ILs = [[n],[e,n,w]] ? ;
no

| ?- sator_szukites([4-2,2-2], 1, [[n],[e,n,s,w]],ILs).
ILs = [[n],[n]] ? ;
no

| ?- sator_szukites([1-1,1-5,3-3,3-5], 3, [[e,s],[e,s,w],[n],[e,n,s,w]],ILs).
ILs = [[s],[e,s],[n],[e,n,s]] ? ;
no

| ?- sator_szukites([1-1,2-2], 2, [[e,s],[n]], ILs).
ILs = [] ? ;
no
```

A beadott programokat Linux környezetben SICStus Prolog 4 rendszerrel teszteljük.

A fenti eljárások paramétereinek típusát a következő – megjegyzésként megadott – Prolog-típusdefiníciók írják le.

```
% :- type parcMutató == int-int. % egy parcella helyét meghatározó egészszám-pár
% :- type fák == list(parcMutató). % a fák helyeit tartalmazó lista
% :- type irány ---> n % észak
% ; e % kelet
% ; s % dél
% ; w. % nyugat
% :- type iránylista == list(irany). % egy adott fához rendelt sátor
% % lehetséges irányait megadó lista
% :- type iránylisták == list(iránylista). % az összes fa iránylistája

% :- pred iranylistak(parcMutató::in % NM
% fák::in, % Fs
% iránylisták::out) % ILs
% :- pred sator_szukites(fák::in, % Fs
% int::in, % I
% iránylisták::in, % ILs0
% iránylisták::out) % ILs
```

Egy teljes példasor
Az alábbiakban egy olyan példasort adunk meg, amely egy egyszerű feladvány teljes megoldási folyamatát mutatja be.

Tekintsük az alábbi, három sorból és négy oszlopból álló, három fát (F1, F2 és F3) tartalmazó feladványt, amelyben nincsenek összegfeltételek (a sátrak soronkénti ill. oszloponkénti számára nincs semmilyen megszorítás):

```prolog
+-------------+
| F1 F2 .  .  |      Fs = [1-1,1-2,3-4]
| .  .  .  .  |
| .  .  .  F3 |
+-------------+
```

A kezdeti iránylista előállítása:

```prolog
| ?- Fs=[1-1,1-2,3-4], iranylistak(3-4, Fs, ILs0). ---> ILs0 = [[s],[e,s],[n,w]]

+-------------+
| F1 F2 .  .  |      Fs = [1-1,1-2,  3-4]
| .  .  .  .  |
| .  .  .  F3 |      ILs0 = [[s],[e,s],[n,w]]
+-------------+
```

Mivel az F1 fa iránylistája egyelemű, érdemes meghívni a sator_szukites eljárást:

```prolog
| ?- Fs=[1-1,1-2,3-4], ILs0=[[s],[e,s],[n,w]], sator_szukites(Fs, 1, ILs0, ILs1). ---> ILs1 = [[s],[e],[n,w]]

+-------------+
| F1 F2 .  .  |      Fs = [1-1,1-2,3-4]
| S  x  .  .  |
| x  x  .  F3 |      ILs1 = [[s],[e],[n,w]]
+-------------+
```

A sátrakat S, E, N, W betűkkel ábrázoljuk, ezzel jelezve, hogy a fájukhoz képest milyen irányban állnak. Azokat a mezőket, amelyekre szomszédsági korlátozások miatt nem kerülhet sátor (ezek egy már ismert helyű sátor oldal- ill. sarokszomszédai) x betűkkel jelezzük.

A fenti sator_szukites(Fs, 1, ILs0, ILs1) hívás feladata, hogy az 1-es sorszámú fához tartozó, egyértelműen déli irányban levő sátort elhelyezze, ennek a mezőnek még jelöletlen szomszédait x betűkkel jelölje, és a többi fák iránylistáiból elhagyja azokat az irányokat, amelyek x-szel jelölt mezőkbe mutatnak. Példánkban egyetlen ilyen van: az F2 fa déli iránya; ezért az ILs0 második eleméből ([e,s]) elhagyjuk az s elemet, és így áll elő az új iránylista-lista, az ILs1.

Mivel most már az F2 fa iránylistája is egyelemű, érdemes újra meghívni a sator_szukites eljárást, de most a 2-es sorszámú fára:

```prolog
| ?- Fs=[1-1,1-2,3-4], ILs1=[[s],[e],[n,w]], sator_szukites(Fs, 2, ILs1, ILs2). ---> ILs2 = [[s],[e],[w]]

+-------------+
| F1 F2 E  x  |        Fs = [1-1,1-2,3-4]
| S  x  x  x  |
| x  x  .  F3 |      ILs2 = [[s],[e],[w]]
+-------------+
```

Itt is történt szűkítés: F3 iránylistájából elhagytuk az északi irányt, mert az F3 fölötti mező F2 sátrának sarokszomszédja.

Ezzel meg is oldottuk a feladatot. Bár itt most felesleges, általános esetben érdemes lehet még egy szűkítést lefuttatni:

```prolog
| ?- Fs=[1-1,1-2,3-4], ILs2=[[s],[e],[w]], sator_szukites(Fs, 3, ILs2, ILs3). ---> ILs3 = [[s],[e],[w]]

+-------------+
| F1 F2 E  x  |        Fs = [1-1,1-2,3-4]
| S  x  x  x  |
| x  x  W  F3 |      ILs3 = [[s],[e],[w]]
+-------------+
```

További szűkítést nem kaptunk, de az ellentmondásra utaló ILs3 = [] választ sem, így a kapott egyelemű iránylisták az eredeti feladat egyetlen megoldását mutatják:

```prolog
[s,e,w]
```

## Tesztek

```prolog
convert_to_coords([1-1, 2-3, 2-3, 3-2], [e,n,s,w], [1-2, 1-3, 3-3, 3-1]).

get_and_test_nth_tree([1-1, 2-2, 3-3], [[s],[e],[w]], 1, 1-3-0-2).
\+ get_and_test_nth_tree([1-1, 2-2, 3-3], [[s,e],[e],[w]], 1, A).

iranylistak(2-3, [1-1,2-2], [[e,s],[e,n,w]]).
iranylistak(3-3, [1-1,2-1], [[e],[e,s]]).
iranylistak(6-6, [1-3,1-5,3-1,4-6,5-1,5-4,6-5], [[e,s,w],[e,s,w],[e,n,s],[n,s,w],[e,n,s],[e,n,s,w],[e,n,w]]).
iranylistak(2-3, [1-1,1-2,2-1], []).

\+ sator_szukites([1-1,2-2], 2, [[e],[n,s]], ILs).
sator_szukites([1-1,2-2], 2, [[e,s],[s]], [[e],[s]]).
sator_szukites([5-2,2-2], 1, [[n],[e,n,s,w]], [[n],[e,n,w]]).
sator_szukites([4-2,2-2], 1, [[n],[e,n,s,w]], [[n],[n]]).
sator_szukites([1-1,1-5,3-3,3-5], 3, [[e,s],[e,s,w],[n],[e,n,s,w]], [[s],[e,s],[n],[e,n,s]]).
sator_szukites([1-1,2-2], 2, [[e,s],[n]], []).
```
