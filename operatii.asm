section .data
    ;am adaugat delimitatorii, unde 10 e new line si 0 e terminatorul de sir
    delimitatori db " ,.",10,0

section .text
global sort
global get_words
extern qsort
extern strtok
extern strlen
extern strcmp

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix

;mi-am fact o functie separata in care compar elementele din vector dupa lungime si lexicografic
comparare_elemente:
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi

    ;salvez primul string
    mov ebx, [ebp + 8]
    ;salvez al doilea string
    mov edx, [ebp + 12]

    ;dereferentiez
    mov ebx, [ebx]
    mov edx, [edx]

    xor edi, edi
calcul_lungime1:
    mov al, [ebx + edi]
    ;daca am juns la sfarsitul cuvantului, ma opresc
    cmp al, 0
    je end_calcul_lungime1

    inc edi
    jmp calcul_lungime1
end_calcul_lungime1:

    xor esi, esi
calcul_lungime2:
    mov al, [edx + esi]
    ;daca am juns la sfarsitul cuvantului, ma opresc
    cmp al, 0
    je end_calcul_lungime2

    inc esi
    jmp calcul_lungime2
end_calcul_lungime2:

    ;compar lungimile
    cmp edi, esi
    je comparare_lexicografica
    jne lungimi_diferite

comparare_lexicografica:
    ;compar lexicografic
    push edx
    push ebx
    call strcmp
    ;golesc stiva
    add esp, 8
    mov eax, eax
    jmp end_func

lungimi_diferite:
    mov eax, edi
    sub eax, esi
end_func:

    pop edi
    pop esi
    pop ebx
    leave
    ret

sort:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    ;salvez words
    mov esi, [ebp + 8]
    ;salvez number_of_words
    mov ebx, [ebp + 12]
    ;salvez size
    mov edx, [ebp + 16]
    ;apelez functia qsort
    push comparare_elemente
    ;edx este echivalentul lui sizeof(char *)
    push edx
    push ebx
    push esi
    call qsort
    ;golesc stiva
    add esp, 16

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push ebx
    push ecx
    push edx
    push esi
    push edi

    ;salvez s
    mov esi, [ebp + 8]
    ;salvez words
    mov edi, [ebp + 12]
    ;salvez number_of_words
    mov ebx, [ebp + 16]

    ;elimin semnele de punctuatie => rezultatul se salveaza in eax
    push delimitatori
    push esi
    call strtok
    ;golesc stiva
    add esp, 8

    xor ecx, ecx
start_loop:
    ;daca am ajuns la sfarsitul lui tokens
    cmp eax, 0
    jz end_loop
    ;daca nu am depasit vectorul
    cmp ecx, ebx
    jge end_loop

    ;adaug cuvintele obtinute in vectorul words
    mov [edi + 4 * ecx], eax
    inc ecx

    push ebx
    push ecx
    push edx
    push esi
    push edi

    push delimitatori
    ;0 este echivalentul lui NULL
    push dword 0
    call strtok
    ;golesc stiva
    add esp, 8

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx

    jmp start_loop
end_loop:

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

