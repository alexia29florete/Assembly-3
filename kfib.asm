section .text
global kfib

kfib:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax

    push ebx
    push esi
    push edi

    ;am declarat n
    mov ebx, [ebp + 8]
    ;am declarat K
    mov edx, [ebp + 12]

    ;compar n cu K
    cmp ebx, edx
    jl ret_0
    je ret_1

    ;declar suma
    xor edi, edi
    ;declar contorul loop-ului
    xor ecx, ecx
    inc ecx
start_loop:
    cmp ecx, edx
    jg end_loop

    ;salvez n si i curente pentru ca le stric la suma
    push ecx
    push ebx

    ;fac ebx = n-i
    sub ebx, ecx
    ;adaug argumentele cu care fac recursia pe stiva
    ;il adaug pe K
    push edx
    ;il adaug pe n-i
    push ebx
    call kfib
    ;golesc stiva
    add esp, 8

    pop ebx
    pop ecx
    ;eax reprezinta rezultatul apelului recursiv pe care il adaug la suma
    add edi, eax

    inc ecx
    jmp start_loop

ret_0:
    ;daca n < k => returnez 0
    mov eax, 0
    jmp end_func

ret_1:
    ;daca n = k => returnez 1
    mov eax, 1
    jmp end_func

end_loop:
    mov eax, edi

end_func:
    pop edi
    pop esi
    pop ebx
    leave
    ret

