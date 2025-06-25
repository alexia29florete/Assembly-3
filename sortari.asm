section .data
struc node
    .info: resd 1  ;am declarat un int - 4 bytes
    .next: resd 1  ;am declarat node* next
endstruc

section .text
global sort

;   struct node {
;    int val;
;    struct node* next;
;   };

;; struct node* sort(int n, struct node* node);
;   The function will link the nodes in the array
;   in ascending order and will return the address
;   of the new found head of the list
; @params:
;   n -> the number of nodes in the array
;   node -> a pointer to the beginning in the array
;   @returns:
;   the address of the head of the sorted list
sort:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push ebx
    push esi
    push edi

    ;salvez n - numarul de noduri
    mov ebx, [ebp + 8]
    ;salvez nodurile
    mov esi, [ebp + 12]

    ;initializez head cu NULL
    xor eax, eax

    xor ecx, ecx
start_loop_initializare:
    cmp ecx, ebx
    jge end_loop_initializare

    ;initializez toate nodurile cu next = NULL
    ;iau adresa nodului curent
    lea edi, [esi + ecx * 8]
    ;setez next = NULL
    mov dword [edi + node.next], 0

    inc ecx
    jmp start_loop_initializare
end_loop_initializare:
    xor ecx, ecx
start_loop_head_list:
    cmp ecx, ebx
    jge end_loop_head_list

    ;iau adresa nodului curent
    lea edi, [esi + ecx * 8]
    ;compar valoarea nodului curent cu 1
    cmp dword [edi + node.info], 1
    je seteaza_head

    inc ecx
    jmp start_loop_head_list

seteaza_head:
    ;actualizez head cu valoarea nodului curent, adica cu 1
    mov eax, edi
    push eax
end_loop_head_list:

    ;o sa fac un for de la 2 la n 
    ;(pentru ca stiu ca am n numere consecutive si pe 1 l-am pus deja prima valoare)
    xor ecx, ecx
    ;incep for-ul de la 2
    mov ecx, 2
    ;curent = head
    mov edx, eax
start_loop1:
    cmp ecx, ebx
    jg end_loop1

    push ecx
    xor ecx, ecx
start_inner_loop:
    cmp ecx, ebx
    jge end_inner_loop

    ;iau adresa nodului curent
    lea edi, [esi + ecx * 8]
    ;eax = valoarea nodului curent
    mov eax, [edi + node.info]

    ;pe stiva se afla valoarea curenta
    cmp eax, [esp]
    je seteaza_legaturi

    inc ecx
    jmp start_inner_loop

seteaza_legaturi:
    mov [edx + node.next], edi
    ;actualizez nodul curent
    mov edx, edi

end_inner_loop:
    pop ecx

    inc ecx
    jmp start_loop1

end_loop1:

    ;ultimul element are next = NULL
    mov dword [edx + node.next], 0
    pop eax

    pop edi
    pop esi
    pop ebx

    leave
    ret

