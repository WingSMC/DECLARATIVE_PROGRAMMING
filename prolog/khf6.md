# KHF6

## Test

```prolog
osszeg_szukites([6-6,9-7], oszl(7,2), [[n,s,w],[e,n,s,w]], []),
osszeg_szukites([6-6,9-7], oszl(7,2), [[e,n,s,w],[e,n,s,w]], [[e],[n,s]]),
osszeg_szukites([6-6,9-7], oszl(7,2), [[e,n,s,w],[n,s]], [[e],[n,s]]),
osszeg_szukites([6-6,9-7], oszl(7,1), [[e,n,s,w],[n,s]], [[n,s,w],[n,s]]),
osszeg_szukites([6-6,9-7], oszl(7,0), [[e,n,s,w],[n,s]], []),
\+ osszeg_szukites([6-6,9-7], oszl(7,1), [[e,n,s,w],[e,n,s,w]], _),
osszeg_szukites([1-5,2-3,3-6,4-4,5-1,6-1,6-3],oszl(2,1),[[e,s,w],[e,n,s,w],[e,n,s,w],[e,n,s,w],[n],[e],[e,w]],[[e,s,w],[e,n,s],[e,n,s,w],[e,n,s,w],[n],[e],[e]]),
osszeg_szukites([1-5,2-3,3-6,4-4,5-1,6-1,6-3],sor(3,1),[[e,s,w],[e,n,s],[e,n,s,w],[n],[n],[e],[e]],[[e,s,w],[e,n],[n,s],[n],[n],[e],[e]]),
osszeg_szukites([6-6,9-7],oszl(7,1),[[e,n,s,w],[n,s]],[[n,s,w],[n,s]]),
osszeg_szukites([1-3,2-1,3-2],oszl(1,1),[[e],[n],[e,w]],[[e],[n],[e]]),
osszeg_szukites([2-1,2-3,2-5,3-3,4-3,4-4,6-5],sor(2,2),[[e,n,s],[e],[e],[w],[s,w],[e],[e]],[[n,s],[e],[e],[w],[s,w],[e],[e]]).


osszeg_szukites([6-6,9-7], oszl(7,2), [[n,s,w],[e,n,s,w]], ILs).
osszeg_szukites([6-6,9-7], oszl(7,2), [[e,n,s,w],[e,n,s,w]], ILs).
osszeg_szukites([6-6,9-7], oszl(7,2), [[e,n,s,w],[n,s]], ILs).
osszeg_szukites([6-6,9-7], oszl(7,1), [[e,n,s,w],[n,s]], ILs).
osszeg_szukites([6-6,9-7], oszl(7,0), [[e,n,s,w],[n,s]], ILs).
\+ osszeg_szukites([6-6,9-7], oszl(7,1), [[e,n,s,w],[e,n,s,w]], ILs).

osszeg_szukites([2-3,3-6,4-4],sor(3,1),[[e,n,s],[e,n,s,w],[n]],ILs).
```
