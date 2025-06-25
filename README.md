# Tema 3 - Cosminel cel Pasionat

### Autori
 - Valentin-Razvan Bogdan
 - Ilinca-Ioana Strutu

 ## Termen limita
 - $\textbf{28.05.2025, 23:55}$

## Minipoveste
Dupa perioada de 1 mai, 2 mai, trebuia sa vina si ... tema 3 la IOCLA! <p>
Intuind entuziasmul studentilor, am decis sa-l introducem pe Cosminel, un personaj fictiv, pentru a da un strop de culoare exercitiilor 💫 . Dupa cum veti vedea, Cosminel este un tip cu multe pasiuni... <p>

## Scop
Tema isi propune sa testeze notiunile invatate in laboratoarele ("The Stack", "Functions", "The C-Assembly Interaction") si sa va ajute la aprofundare.

## Exercitii si punctaje
- Task-1 "Sortari" - 20p
- Task-2 "Operatii" - 25p
- Task-3 "KFib" - 20p
- Task-4 "Composite Palindrome" - 35p
    - SubTask-1 "Palindrome Check" - 5p
    - SubTask-2 "Composite Palindrome" - 30p

Pentru fiecare exercitiu veti gasi enuntul in directorul asignat acestuia, $\textbf{cititi-le cu atentie!}$ <p>
Exercitiile sunt puse intr-o ordine aleatorie, $\textbf{cititi-le pe toate inainte de a va apuca de vreo rezolvare!}$. 

# Task 1 - Sortari (20p)

Cosminel, mare fan al curateniei si ordinii, a decis să stocheze numere într-o listă înlănțuită, ale cărei noduri nu sunt legate între ele. Acesta trebuie să implementeze funcția cu semnătura "`struct node* sort(int n, struct node* node);`" din fișierul sortari.asm, care "leagă" nodurile din listă în ordine crescătoare.
Funcția primește numărul de noduri și adresa vectorului și întoarce adresa primului nod din lista rezultată.

Structura unui nod este:
```
struct node {
    int val;
    struct node* next;
};
```
și, inițial, câmpul `next` este setat la `NULL`.

## Precizări:
- n >= 1
- secvența conține numere consecutive distincte începand cu 1 (ex: 1 2 3 ...)
- structura vectorulului NU trebuie modificată (interschimbarea nodurilor este interzisă)
- sortarea trebuie facută in-place
- este permisă folosirea unor structuri auxiliare, atâta timp cât, nodurile listei rezultate sunt cele din vectorul inițial
- NU este permisă folosirea funcției `qsort` din libc

## Exemplu
```
Inițial:

| Adresă    | Valoare   | Next      |
| --------- | --------- | --------- |
| 0x32      | 2         | NULL      |
| 0x3A      | 1         | NULL      |
| 0x42      | 3         | NULL      |

Apelul funcției `sort` întoarce `0x3A` (adresa nodului cu valoarea 1) și vectorul va arăta astfel:

| Adresă    | Valoare   | Next      |
| --------- | --------- | --------- |
| 0x32      | 2         | 0x42      |
| 0x3A      | 1         | 0x32      |
| 0x42      | 3         | NULL      |
```

## Hint:
- pentru implementarea sortării vă puteți inspira din [Selection Sort](https://www.geeksforgeeks.org/selection-sort/)

# Task 2 - Operatii (25p)

Cosminel, mare fan al literaturii moderne, vrea sa separe un text filozofic in cuvinte dupa niste delimitatori si, dupa aceea, sa sorteze aceste cuvinte folosind functia qsort. Sortarea se va face intai dupa lungimea cuvintelor si in cazul egalitatii se va sorta lexicografic. <br>

Va trebui sa implementati 2 functii cu semnaturile "`void get_words(char *s, char **words, int number_of_words);`" si "`void sort(char **words, int number_of_words, int size);`" din fisierul task3.asm. Functia get_words primeste ca parametri textul, un vector de stringuri in care va trebui sa salvati cuvintele pe care ulterior le veti sorta si numarul de cuvinte. Functia sort va primi vectorul de cuvinte, numarul de cuvinte si dimensiunea unui cuvant.

## Precizări:
- lungimea textului este mai mica decat 1000;
- vectorul de cuvinte va avea maxim 100 de cuvine a 100 de caractere fiecare;
- delimitatorii pe care trebuie sa ii luati in calcul sunt: " ,.\n"
- nu aveti voie sa folositi alta metoda de sortare in afara de qsort. In cazul in care veti folosi alta metoda punctajul pe acest task se va pierde.

## Exemplu
```
number_of_words: 9
s: "Ana are 27 de mere, si 32 de pere."
dupa apelul get_words: words = ["Ana", "are", "27", "de", "mere", "si", "32", "de", "pere"]
dupa apelul sort: words = ["27", "32", "de", "de", "si", "Ana", "are", "mere", "pere"]
```

## Hint:
- pentru mai multe informatii despre qsort puteti accesa linkul: https://man7.org/linux/man-pages/man3/qsort.3.html

# Task 3 - KFib (20p)

Cosminel este mare fan al [sirului lui Fibonacci](#sirul-lui-fibonacci). In timp ce gatea, acestuia ii trece un gand briliant prin minte: cum ar fi sa generalizeze secventele de tip Fibonacci ?!  

Asadar, el defineste [sirul KFib](#sirul-kfib) si isi propuna sa calculeze rezultatul **recursiv** pentru diferite valori.

Din nefericire, se incurca in multitudinea de cadre de stiva si ... voi trebuie sa salvati situatia!

#### Sirul lui Fibonacci
Numim sirul lui Fibonacci secventa de numere $0, 1, 1, 2, 3, 5, 8, 13, ...$, unde termenul general $F_n = F_{n - 1} + F_{n - 2}$ pentru orice $n \gt 2$, iar $F_{1} = 0$, $F_{2} = 1$.

#### Sirul KFib
Numim sirul KFib secventa generata de urmatoarea functie: <p>
$$
KFib(n) = 
\begin{cases}
0, & \text{daca } n \lt K \\
1, & \text{daca } n = K \hspace{1cm} \text{pentru K fixat} \\
KFib(n - 1) + KFib(n - 2) + \dots + KFib(n - K), & \text{daca } n > K
\end{cases}
$$ <p>
Exemplu: <p>
$3Fib = 0, 0, 1, 1, 2, 4, 7, 13, 24, 44, 81, ...$


## Organizare
Task-ul are doar un subtask. **Va recomand sa cititi cu atentie restul enuntului**.<p>
Subtask 1: 20p <p>
Exista punctaje partiale, insa testele sunt impartite in grupuri (😁), iar pentru a lua punctele asociate unui grup va trebui ca toate testele aferente sa fie trecute.

## Subtask 1 - KFib
Pentru acest subtask, va trebui sa implementati o functie ce intoarce al $n$-lea termen al sirului $KFib$.
```c
const int fib(int n, int K);
```
Parametrii:
- **n** - pozitia termenului cerut din sirul $KFib$ (indexarea este de la 1);
- **K** - specifica tipul sirului de tip Fibonacci. 

Functia va intoarce:
- $KFib_n$

<span style="color:red">🚨🚨🚨 Rezultatul trebuie calculat <b>recursiv</b>, asadar punctajul afisat de checker e provizoriu, fiind validat de echipa la o verificare ulterioara!!! 🚨🚨🚨</span><p>
<span style="color:red">🚨🚨🚨 Se garanteaza ca rezultatul poate fi reprezentat pe 32 de biti!!!🚨🚨🚨</span><p>


## Constrangeri
- $2 \leq K \leq 30 \equiv$  Tipul maxim al unui sir de tip Fibonacci este 30;
- $2 \leq n \leq 40 \equiv$ Pozitia maxima ceruta a unui termen din sirul $KFib$ este 40;
- $K \leq n \equiv$ Rezultatul este garantat mai mare ca 0.


## Folosire si interpretare checker
Checker-ul poate fi folosit selectiv pentru primele $X \hspace{0.05cm}(1 \leq X \leq 4)$ grupuri de teste, nu inainte de a compila sursele folosind **make**.

- rulati **./checker 1** pentru a verifica primul grup de teste;
- rulati **./checker 2** pentru a verifica primele 2 grupuri de teste;
- rulati **./checker 3** pentru a verifica primele 3 grupuri de teste;
- rulati **./checker 4** pentru a verifica toate grupurile de teste;
- rulati **./checker** pentru a verifica toate grupurile de teste; <p>

**Cu ce scop ?** Grupul 4 de teste **va dura mai mult** (de ordinul zecilor de secunde, depinde de ce hardware aveti), asadar **va recomand** sa-l rulati doar dupa ce le rezolvati pe primele 3.


Odata rulat checker-ul:
- veti vedea in consola punctajul obtinut;
- in cazul unei implementari incorecte, in cadrul grupului respectiv vi se afisa numarul primului test
la care output-ul difera de referinta (indexarea este de la 0) pentru a va usura debugging-ul.


# Task 4 - Composite Palindrome (35p)

Cosminel, mare fan al [palindroamelor](#palindrom), ar face orice ca sa aiba de-a face cu acestea. <p>
Asadar, se gandeste la urmatoarea problema: fiind dat un vector format din $N$ cuvinte, el vrea sa gaseasca cel mai lung palindrom format din concatenarea unui [subsir](#subsir) de cuvinte, iar in caz de egalitate il va alege pe cel [minim in ordine lexicografica](#ordine-lexicografica).

Intrucat de abia s-a terminat minivacanta de 1 mai, Cosminel e foarte obosit si va cere ajutorul pentru a o rezolva.


#### Palindrom
Numim palindrom un sir de caractere care, citit de la stanga la dreapta sau invers, acesta ramane neschimbat. <p>
Exemplu:
- palindrom: $\text{a}$, $\text{aa}$, $\text{abba}$;
- non-palindrom: $\text{ab}$, $\text{acdc}$.

#### Subsir

Numim subsir al unui vector $V$, indexat de la $0$ si de lungime $N$, o secventa de elemente $[V_{i_0}, V_{i_1}, \ldots, V_{i_{m-1}}]$, unde $i_{k-1} < i_k$ pentru orice $k \in \{1, \ldots, m-1\}$, $i_0 \geq 0$, si $i_{m-1} < N$.

Exemplu: <p>
$V = [\text{Ana}, \text{are}, \text{mere}]$

- Unele subsiruri valide: $[\text{are}]$, $[\text{Ana}, \text{mere}]$, $[\text{Ana}, \text{are}, \text{mere}]$;
- Unele subsiruri invalide: $[\text{mere}, \text{Ana}]$, $[\text{Ana}, \text{mere}, \text{are}]$.


#### Ordine lexicografica

Avand sirul de caractere $A = A_0 A_1 \ldots A_{n-1}$ si $B = B_0 B_1 \ldots B_{m-1}$, numim $A$ mai mic lexicografic decat $B$ daca una din conditii se indeplineste:
- prima pozitie $i$ unde $A_i \neq B_i$, avem $A_i < B_i$;
- $A_0 A_1 \ldots A_{n-1} = B_0 B_1 \ldots B_{n-1}$, $n < m$. <p>

Exemplu: <p>
- $A = abczzz$, $B = abdaaa$ $\Longrightarrow$ $A \lt B$
- $A = a$, $B = aa$ $\Longrightarrow$ $A \lt B$
- $A = aa$, $B = z$ $\Longrightarrow$ $A \lt B$

## Organizare
Task-ul este divizat in doua parti pentru a va modulariza rezolvarea. **Va recomand sa le rezolvati in ordine si sa cititi cu atentie restul enuntului**.<p>
Subtask 1: 5p <p>
Nu exista punctaje partiale la acest subtask, asadar va trebui ca solutia voastra sa treaca toate testele asociate acestuia.<p>
Subtask 2: 30p <p>
Exista punctaje partiale la acest subtask, insa testele sunt impartite in grupuri (😁), iar pentru a lua punctele asociate unui grup va trebui ca toate testele aferente sa fie trecute.

## Subtask 1 - Palindrome Check (5p)
Pentru acest subtask, va trebui sa implementati o functie ce verifica daca un sir de caractere este palindrom.
```c
const int check_palindrome(const char * const str, const int len);
```
Parametrii:
- **str** - sirul de caractere (indexat de la 0);
- **len** - lungimea sirului **str**. 

Functia va intoarce:
- **0**, daca nu este palindrom;
- **1**, daca este palindrom.

## Subtask 2 - Composite Palindrome (30p)
Pentru acest subtask, va trebui sa implementati o functie ce gaseste cel mai lung palindrom, minim lexicografic, obtinut prin concatenarea unui subsir de cuvinte dintr-un vector.
```c
char * const composite_palindrome(const char * const * const strs, const int len);
```
Parametrii:
- **strs** - vectorul de cuvinte (indexat de la 0, la fel si caracterelor in cadrul cuvintelor);
- **len**  - numarul de cuvinte din vector.

Functia va intoarce:
- sirul de caractere cerut. <p>

<span style="color:red">🚨🚨🚨 Sirul de caractere rezultat trebuie sa fie alocat pe <b>heap</b>!!! 🚨🚨🚨</span>



## Constrangeri
- $1 \leq |str_{1,2}| \leq 10 \equiv$ dimensiunea maxima a unui sir este de 10 caractere (subtask 1 + 2);
- $|strs| = 15 \equiv$ numărul de cuvinte din vectorul $strs$ este 15 (subtask 2);
- $str_1 \in \{a, b, \ldots, z\}^* \equiv$ cuvintele sunt formate din caractere apartinand alfabetului englezesc (subtask 1);
- $str_2 \in \{a, b\}^* \equiv$ cuvintele sunt formate doar din caracterele `a` si `b` (subtask 2).


## Folosire si interpretare checker
Checker-ul poate fi folosit individual pentru fiecare subtask, nu inainte de a compila sursele folosind **make**.

- rulati **./checker 1** pentru a verifica primul subtask;
- rulati **./checker 2** pentru a verifica al doilea subtask;
- rulati **./checker** pentru a verifica ambele subtask-uri.

Odata rulat checker-ul:
- veti vedea in consola punctajul obtinut;
- in cazul unei implementari incorecte, in cadrul grupului respectiv vi se afisa numarul primului test
la care output-ul difera de referinta (indexarea este de la 0) pentru a va usura debugging-ul.



