section .text
global check_palindrome
global composite_palindrome

extern strlen
extern strcmp
extern strcat
extern malloc
extern free

check_palindrome:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push ebx
    push esi
    push edi
    ; am declarat vectorul
    mov esi, [ebp + 8]
    ; am declarat lungimea 
    mov edx, [ebp + 12]

    ;verfic daca elementul e palindrom
    ;i = 0
    xor ecx, ecx 
    ;elimin terminatorul de sir
    dec edx 
start_loop:
    cmp ecx, edx 
    jge e_valid
    ;sir[i]
    mov al, [esi + ecx] 
    ;sir[len-i]
    mov bl, [esi + edx] 
    cmp bl, al
    jne nu_e_valid
    jmp continue

continue:
    ;merg mai departe
    inc ecx
    dec edx
    jmp start_loop

e_valid:
    ; setez 1 pt palindrom valid
    mov eax, 1
    jmp end_loop
nu_e_valid:
    ; setez 0 dac nu e palindrom
    mov eax, 0
    jmp end_loop

end_loop:

    pop edi
    pop esi
    pop ebx

    leave
    ret

composite_palindrome:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push ebx
    push esi
    push edi

    ; am declarat vectorul
    mov esi, [ebp + 8]
    ; am declarat lungimea 
    mov edi, [ebp + 12]

    ;aloc saptiu pentru niste varaiabile pe care le voi folosi
    ;lungimea maxima = [esp + 12]
    push 0
    ;cel mai bun palindrom = [esp + 8]
    push 0
    ;masca = [esp + 4]
    push 1
    ;concat vector = [esp]
    push 0

start_loop1:
    ;1 << n unde n = lungimea
    mov eax, 1
    mov ecx, edi
    shl eax, cl
    ;verific daca mask < (1 << n)
    cmp [esp + 4], eax
    jge end_loop1

    ;sirul de concatenare
    xor ebx, ebx
    ;i = 0
    xor ecx, ecx
inner_loop:
    cmp ecx, edi
    jge outer_loop

    ;verific daca bitul de pe poztia ecx din masca este setat
    mov edx, [esp + 4]
    shr edx, cl
    ;fac si cu 1
    and edx, 1
    ;daca este setat, calculez lungimea submultimii
    cmp edx, 0
    je continua

    ;parcurg elementele din vector
    mov eax, [esi + ecx * 4]
    push ecx
    ;caulculez lungimea
    push eax
    call strlen
    ;golesc stiva
    add esp, 4
    pop ecx

    ;actualizez lungimea cuvantului
    add ebx, eax
continua:
    inc ecx
    jmp inner_loop

outer_loop:
    ;compar cu lungimea maxima
    cmp ebx, [esp + 12]
    jl masca_urm 

    ;am adaugat +1 pentru terminatorul de sir
    lea eax, [ebx + 1]

    ;aloc memorie pentru sirul concatenat
    push eax
    call malloc
    ;golesc stiva
    add esp, 4
    ;adaug in zona alocata de pe stiva
    mov [esp], eax
    ;adaug terminatorul de sir
    mov byte [eax], 0

    ;i = 0
    xor ecx, ecx
loop_concatenare_siruri:
    cmp ecx, edi
    jge end_loop_concatenare

    ;verific daca bitul de pe poztia ecx din masca este setat
    mov edx, [esp + 4]
    shr edx, cl
    ;fac si cu 1
    and edx, 1
    ;daca este setat, calculez lungimea submultimii
    cmp edx, 0
    je concatenare_urm

    ;parcurg elementele vectorului
    mov eax, [esi + ecx * 4]
    push ecx
    ;aflu submultimea cu stringurile concatenate
    push eax
    ;adaug concatenarea curenta
    push dword [esp + 8]
    call strcat
    ;golesc stiva
    add esp, 8
    pop ecx

concatenare_urm:
    inc ecx
    jmp loop_concatenare_siruri

end_loop_concatenare:
    ;verific daca concatenarea este palindrom

    push ebx
    ;concatenarea
    push dword [esp + 4]
    call check_palindrome
    ;golesc stiva
    add esp, 8

    ;verific daca nu e palindrom
    cmp eax, 0
    je not_ok

    ;compar lungimea celui mai bun cu lungimea celui actual
    cmp ebx, [esp + 12]
    jg update_best_palindrome
    jl not_ok

    ;daca au aceeasi lungime, compar lexicografic
    mov eax, [esp + 8]

    push eax
    ;adaug concatenarea curenta
    push dword [esp + 4]
    call strcmp
    ;golesc stiva
    add esp, 8

    ;verific daca e mai mare lexicografic
    cmp eax, 0
    jge not_ok

update_best_palindrome:
    ;stochez cel mai bun palindrom in eax
    mov eax, [esp + 8]
    ;daca cel mai bun palindrom e NULL, il ignor
    cmp eax, 0
    je ignore

    push eax
    call free
    ;golesc stiva
    add esp, 4
ignore:
    mov eax, [esp]
    ;actualizez cel mai bun palindrom cu concat (cel tocmai gasit)
    mov [esp + 8], eax
    ;actualizez lungimea
    mov [esp + 12], ebx
    jmp masca_urm

not_ok:
    ;eliberez memoria alocata dinamic
    push dword [esp]
    call free
    ;golesc stiva
    add esp, 4

masca_urm:
    ;incrementez valoarea mastii curente
    inc dword [esp + 4]
    jmp start_loop1

end_loop1:
    ;mut adresa celui mai bun palindrom
    mov eax, [esp + 8]
    ;curat stiva
    add esp, 16

    pop edi
    pop esi
    pop ebx

    leave
    ret

