# KHF6
## Test
```prolog
osszeg_szukites([6-6,9-7], oszl(7,2), [[n,s,w],[e,n,s,w]], []).
osszeg_szukites([6-6,9-7], oszl(7,2), [[e,n,s,w],[e,n,s,w]], [[e],[n,s]]).
osszeg_szukites([6-6,9-7], oszl(7,2), [[e,n,s,w],[n,s]], [[e],[n,s]]).
osszeg_szukites([6-6,9-7], oszl(7,1), [[e,n,s,w],[n,s]], [[n,s,w],[n,s]]).
osszeg_szukites([6-6,9-7], oszl(7,0), [[e,n,s,w],[n,s]], []).
\+ osszeg_szukites([6-6,9-7], oszl(7,1), [[e,n,s,w],[e,n,s,w]], ILs).
```
