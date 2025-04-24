section .data
    prompt db 'Entre ton nom: ', 0
    prompt_len equ $ - prompt
    greeting db 'Bonjour, ', 0
    greeting_len equ $ - greeting

section .bss
    name resb 256

section .text
    global _start

_start:
    ; Afficher le prompt
    mov eax, 4         
    mov ebx, 1          
    mov ecx, prompt     
    mov edx, prompt_len 
    int 0x80            

    ; Lire le nom de l'utilisateur
    mov eax, 3          
    mov ebx, 0          
    mov ecx, name       
    mov edx, 256        
    int 0x80           

    ; Afficher le message de salutation
    mov eax, 4          
    mov ebx, 1          
    mov ecx, greeting   
    mov edx, greeting_len 
    int 0x80            

    ; Afficher le nom de l'utilisateur
    mov eax, 4         
    mov ebx, 1          
    mov ecx, name      
    mov edx, 256        
    int 0x80            

    ; Terminer le programme
    mov eax, 1          
    xor ebx, ebx        
    int 0x80            

; Il est, d'un manière générale, préférable de diviser le code en fonctions (exit, get_input ...) puis les appeler depuis _start
; Cela rendra le code plus humain, plus besoin des commentaires qui deviendront redondants et vous pourrez donc les enlever.