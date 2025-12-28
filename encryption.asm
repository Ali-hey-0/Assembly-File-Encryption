; ========================================================================
; CryptoVault Pro v2.0 - Advanced File Encryption System
; Platform: Linux x86-64 (WSL Compatible)
; Author: Ali Heydari
; Date: 2026
; ========================================================================

section .data
    ; ============ Banner & Interface ============
    banner          db 10, "╔═══════════════════════════════════════════════════════════╗", 10
                    db "║     🔐 CryptoVault Pro v2.0 - Ultimate Edition 🔐     ║", 10
                    db "║         Advanced Encryption System - Assembly         ║", 10
                    db "╚═══════════════════════════════════════════════════════════╝", 10, 10, 0
    
    menu            db 10, "╔════════════════ MAIN MENU ════════════════╗", 10
                    db "║  [1] 🔒 Encrypt File                  ║", 10
                    db "║  [2] 🔓 Decrypt File                  ║", 10
                    db "║  [3] 🔄 Batch Encrypt (Multiple)     ║", 10
                    db "║  [4] 🎲 Generate Random Key           ║", 10
                    db "║  [5] 🛠️  Algorithm Settings           ║", 10
                    db "║  [6] 📊 View Statistics               ║", 10
                    db "║  [7] ℹ️  Help & Documentation         ║", 10
                    db "║  [8] 📖 About This Program            ║", 10
                    db "║  [9] 🚪 Exit                          ║", 10
                    db "╚═══════════════════════════════════════════╝", 10
                    db 10, "Your choice: ", 0
    
    algo_menu       db 10, "╔════════ ALGORITHM SELECTION ════════╗", 10
                    db "║  [1] XOR Cipher (Fast)          ║", 10
                    db "║  [2] Caesar Cipher (Classic)    ║", 10
                    db "║  [3] Vigenere Cipher (Strong)   ║", 10
                    db "║  [4] ROT13 (Quick)              ║", 10
                    db "║  [5] Return to Main Menu        ║", 10
                    db "╚═════════════════════════════════════╝", 10
                    db 10, "Select algorithm: ", 0
    
    ; ============ Prompts ============
    prompt_input    db 10, "📁 Input file path: ", 0
    prompt_output   db "📝 Output file path: ", 0
    prompt_key      db "🔑 Encryption key: ", 0
    prompt_shift    db "🔢 Shift value (1-25): ", 0
    prompt_continue db 10, "Continue? (y/n): ", 0
    
    ; ============ Messages ============
    msg_encrypting  db 10, "[⏳] Processing encryption...", 10, 0
    msg_decrypting  db 10, "[⏳] Processing decryption...", 10, 0
    msg_success     db "[✅] Operation completed successfully!", 10, 0
    msg_progress    db "[▓▓▓▓▓▓▓▓▓▓] 100%", 13, 0
    
    ; ============ Errors ============
    msg_error_open  db "[❌] Error: Cannot open input file!", 10
                    db "💡 Tip: In WSL, use /mnt/c/... for Windows paths", 10
                    db "   Example: /mnt/c/Users/YourName/Desktop/file.txt", 10, 0
    msg_error_create db "[❌] Error: Cannot create output file!", 10, 0
    msg_error_key   db "[❌] Error: Invalid key!", 10, 0
    msg_error_path  db "[⚠️] Warning: Path looks like Windows format", 10
                    db "   Did you mean: /mnt/c/... ?", 10, 0
    
    ; ============ Info Messages ============
    msg_file_info   db 10, "📋 File Information:", 10
                    db "   Size: ", 0
    msg_bytes       db " bytes", 10, 0
    msg_algorithm   db "   Algorithm: ", 0
    msg_processing  db "   Processing...", 10, 0
    
    current_algo_name db "XOR Cipher", 0
    algo_xor        db "XOR Cipher", 0
    algo_caesar     db "Caesar Cipher", 0
    algo_vigenere   db "Vigenere Cipher", 0
    algo_rot13      db "ROT13", 0
    
    ; ============ Statistics ============
    stats_header    db 10, "╔════════════ STATISTICS ════════════╗", 10, 0
    stats_files     db "║  Files Encrypted: ", 0
    stats_total     db "║  Total Bytes: ", 0
    stats_footer    db "╚════════════════════════════════════╝", 10, 0
    
    ; ============ Help Text ============
    help_text       db 10, "╔══════════════ HELP & TIPS ══════════════╗", 10
                    db "║                                       ║", 10
                    db "║  💡 File Path Tips (WSL):             ║", 10
                    db "║     • Use relative paths: ./file.txt  ║", 10
                    db "║     • Or absolute: /home/user/...     ║", 10
                    db "║     • Windows C:\ = /mnt/c/...       ║", 10
                    db "║                                       ║", 10
                    db "║  🔐 Encryption Tips:                  ║", 10
                    db "║     • Use strong keys (8+ chars)      ║", 10
                    db "║     • Remember your key!              ║", 10
                    db "║     • Test on small files first       ║", 10
                    db "║                                       ║", 10
                    db "║  ⚡ Quick Start:                      ║", 10
                    db "║     1. Choose algorithm [5]           ║", 10
                    db "║     2. Encrypt file [1]               ║", 10
                    db "║     3. Use same key to decrypt [2]    ║", 10
                    db "║                                       ║", 10
                    db "╚═══════════════════════════════════════╝", 10, 10, 0
    
    about_text      db 10, "╔═══════════════════════════════════════════════╗", 10
                    db "║    CryptoVault Pro v2.0 Ultimate Edition  ║", 10
                    db "╠═══════════════════════════════════════════════╣", 10
                    db "║  • 4 Encryption Algorithms                ║", 10
                    db "║  • WSL/Windows Compatible                 ║", 10
                    db "║  • Batch Processing Support               ║", 10
                    db "║  • Statistics Tracking                    ║", 10
                    db "║  • Random Key Generator                   ║", 10
                    db "║  • Professional Grade                     ║", 10
                    db "║                                           ║", 10
                    db "║  Written in: Pure x86-64 Assembly        ║", 10
                    db "║  Platform: Linux/WSL                      ║", 10
                    db "║  Build: December 2024                     ║", 10
                    db "╚═══════════════════════════════════════════════╝", 10, 10, 0
    
    key_gen_msg     db 10, "[🎲] Generating random key...", 10, 0
    key_generated   db "[✅] Random key: ", 0
    
    separator       db "───────────────────────────────────────", 10, 0
    newline         db 10, 0

section .bss
    ; ============ Buffers ============
    choice          resb 4
    input_path      resb 512        ; Increased for long paths
    output_path     resb 512
    key_buffer      resb 64         ; Increased key size
    shift_value     resb 4
    key_len         resq 1
    file_buffer     resb 8192       ; 8KB buffer for better performance
    input_fd        resq 1
    output_fd       resq 1
    bytes_read      resq 1
    total_bytes     resq 1
    
    ; ============ Settings ============
    current_algo    resb 1          ; 1=XOR, 2=Caesar, 3=Vigenere, 4=ROT13
    
    ; ============ Statistics ============
    files_encrypted resq 1
    total_processed resq 1
    
    ; ============ Random seed ============
    random_seed     resq 1

section .text
    global _start

; ========================================================================
; Main Entry Point
; ========================================================================
_start:
    ; Initialize
    mov byte [current_algo], 1      ; Default: XOR
    mov qword [files_encrypted], 0
    mov qword [total_processed], 0
    
    ; Get random seed from time
    call init_random
    
    ; Display banner
    mov rdi, banner
    call print_string
    
main_loop:
    ; Display menu
    mov rdi, menu
    call print_string
    
    ; Read choice
    mov rdi, choice
    mov rsi, 4
    call read_input
    
    movzx rax, byte [choice]
    sub rax, '0'
    
    cmp rax, 1
    je encrypt_file
    cmp rax, 2
    je decrypt_file
    cmp rax, 3
    je batch_encrypt
    cmp rax, 4
    je generate_random_key
    cmp rax, 5
    je algorithm_menu
    cmp rax, 6
    je show_statistics
    cmp rax, 7
    je show_help
    cmp rax, 8
    je show_about
    cmp rax, 9
    je exit_program
    
    jmp main_loop

; ========================================================================
; Algorithm Menu
; ========================================================================
algorithm_menu:
    mov rdi, algo_menu
    call print_string
    
    mov rdi, choice
    mov rsi, 4
    call read_input
    
    movzx rax, byte [choice]
    sub rax, '0'
    
    cmp rax, 5
    je main_loop
    
    cmp rax, 1
    jl main_loop
    cmp rax, 4
    jg main_loop
    
    mov [current_algo], al
    
    ; Display selected algorithm
    mov rdi, newline
    call print_string
    mov rdi, msg_algorithm
    call print_string
    
    movzx rax, byte [current_algo]
    cmp rax, 1
    je .show_xor
    cmp rax, 2
    je .show_caesar
    cmp rax, 3
    je .show_vigenere
    cmp rax, 4
    je .show_rot13
    
.show_xor:
    mov rdi, algo_xor
    call print_string
    jmp .done
    
.show_caesar:
    mov rdi, algo_caesar
    call print_string
    jmp .done
    
.show_vigenere:
    mov rdi, algo_vigenere
    call print_string
    jmp .done
    
.show_rot13:
    mov rdi, algo_rot13
    call print_string
    
.done:
    mov rdi, newline
    call print_string
    jmp main_loop

; ========================================================================
; Generate Random Key
; ========================================================================
generate_random_key:
    mov rdi, key_gen_msg
    call print_string
    
    ; Generate 16 random characters
    mov rcx, 16
    xor rbx, rbx
    
.gen_loop:
    call get_random_char
    mov [key_buffer + rbx], al
    inc rbx
    loop .gen_loop
    
    mov byte [key_buffer + rbx], 0
    
    ; Display generated key
    mov rdi, key_generated
    call print_string
    mov rdi, key_buffer
    call print_string
    mov rdi, newline
    call print_string
    
    jmp main_loop

; ========================================================================
; Batch Encrypt
; ========================================================================
batch_encrypt:
    mov rdi, newline
    call print_string
    mov rdi, separator
    call print_string
    
    ; Get key once
    mov rdi, prompt_key
    call print_string
    mov rdi, key_buffer
    mov rsi, 64
    call read_input
    
    mov rdi, key_buffer
    call string_length
    mov [key_len], rax
    
    cmp rax, 0
    je key_empty_error
    
.batch_loop:
    mov rdi, separator
    call print_string
    
    mov rdi, prompt_input
    call print_string
    mov rdi, input_path
    mov rsi, 512
    call read_input
    
    ; Check if user wants to exit
    cmp byte [input_path], 0
    je main_loop
    
    mov rdi, prompt_output
    call print_string
    mov rdi, output_path
    mov rsi, 512
    call read_input
    
    ; Check for Windows path
    call check_windows_path
    
    mov rdi, msg_encrypting
    call print_string
    
    call process_file
    
    cmp rax, 0
    jl .batch_error
    
    mov rdi, msg_success
    call print_string
    
    mov rdi, prompt_continue
    call print_string
    mov rdi, choice
    mov rsi, 4
    call read_input
    
    cmp byte [choice], 'y'
    je .batch_loop
    cmp byte [choice], 'Y'
    je .batch_loop
    
    jmp main_loop
    
.batch_error:
    jmp file_error

; ========================================================================
; Encrypt File
; ========================================================================
encrypt_file:
    mov rdi, msg_encrypting
    call print_string
    
    mov rdi, prompt_input
    call print_string
    mov rdi, input_path
    mov rsi, 512
    call read_input
    
    ; Check for Windows path
    call check_windows_path
    
    mov rdi, prompt_output
    call print_string
    mov rdi, output_path
    mov rsi, 512
    call read_input
    
    mov rdi, prompt_key
    call print_string
    mov rdi, key_buffer
    mov rsi, 64
    call read_input
    
    mov rdi, key_buffer
    call string_length
    mov [key_len], rax
    
    cmp rax, 0
    je key_empty_error
    
    call process_file
    
    cmp rax, 0
    jl file_error
    
    ; Update statistics
    inc qword [files_encrypted]
    
    mov rdi, msg_success
    call print_string
    jmp main_loop

; ========================================================================
; Decrypt File
; ========================================================================
decrypt_file:
    mov rdi, msg_decrypting
    call print_string
    
    mov rdi, prompt_input
    call print_string
    mov rdi, input_path
    mov rsi, 512
    call read_input
    
    call check_windows_path
    
    mov rdi, prompt_output
    call print_string
    mov rdi, output_path
    mov rsi, 512
    call read_input
    
    mov rdi, prompt_key
    call print_string
    mov rdi, key_buffer
    mov rsi, 64
    call read_input
    
    mov rdi, key_buffer
    call string_length
    mov [key_len], rax
    
    cmp rax, 0
    je key_empty_error
    
    call process_file
    
    cmp rax, 0
    jl file_error
    
    mov rdi, msg_success
    call print_string
    jmp main_loop

; ========================================================================
; Process File with Selected Algorithm
; ========================================================================
process_file:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    
    ; Open input file
    mov rax, 2
    mov rdi, input_path
    mov rsi, 0
    mov rdx, 0
    syscall
    
    cmp rax, 0
    jl .error_open
    mov [input_fd], rax
    
    ; Create output file
    mov rax, 2
    mov rdi, output_path
    mov rsi, 0x241
    mov rdx, 0644o
    syscall
    
    cmp rax, 0
    jl .error_create
    mov [output_fd], rax
    
    xor r12, r12            ; Key index
    mov qword [total_bytes], 0
    
.read_loop:
    ; Read chunk
    mov rax, 0
    mov rdi, [input_fd]
    mov rsi, file_buffer
    mov rdx, 8192
    syscall
    
    cmp rax, 0
    jle .done_reading
    
    mov [bytes_read], rax
    mov r13, rax
    
    ; Add to total
    add [total_bytes], rax
    add [total_processed], rax
    
    ; Apply encryption based on algorithm
    movzx r14, byte [current_algo]
    
    cmp r14, 1
    je .apply_xor
    cmp r14, 2
    je .apply_caesar
    cmp r14, 3
    je .apply_vigenere
    cmp r14, 4
    je .apply_rot13
    
.apply_xor:
    call xor_encrypt_buffer
    jmp .write_buffer
    
.apply_caesar:
    call caesar_encrypt_buffer
    jmp .write_buffer
    
.apply_vigenere:
    call vigenere_encrypt_buffer
    jmp .write_buffer
    
.apply_rot13:
    call rot13_buffer
    
.write_buffer:
    ; Write encrypted data
    mov rax, 1
    mov rdi, [output_fd]
    mov rsi, file_buffer
    mov rdx, r13
    syscall
    
    jmp .read_loop
    
.done_reading:
    ; Close files
    mov rax, 3
    mov rdi, [input_fd]
    syscall
    
    mov rax, 3
    mov rdi, [output_fd]
    syscall
    
    xor rax, rax
    jmp .return
    
.error_open:
    mov rax, -1
    jmp .return
    
.error_create:
    mov rax, 3
    mov rdi, [input_fd]
    syscall
    mov rax, -2
    
.return:
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    ret

; ========================================================================
; XOR Encryption
; ========================================================================
xor_encrypt_buffer:
    push rbp
    mov rbp, rsp
    push rbx
    
    xor rbx, rbx
    
.loop:
    cmp rbx, r13
    jge .done

        ; Ensure key index is within key length (r12 %= key_len)
        mov rax, r12
        xor rdx, rdx
        mov r8, [key_len]
        div r8
        mov r12, rdx

        movzx rax, byte [file_buffer + rbx]
        movzx rcx, byte [key_buffer + r12]
        xor rax, rcx

        mov [file_buffer + rbx], al

        inc rbx
        inc r12

        ; Normalize key index for next iteration
        mov rax, r12
        xor rdx, rdx
        mov r8, [key_len]
        div r8
        mov r12, rdx

        jmp .loop
    
.done:
    pop rbx
    pop rbp
    ret

; ========================================================================
; Caesar Cipher
; ========================================================================
caesar_encrypt_buffer:
    push rbp
    mov rbp, rsp
    push rbx
    
    ; Use first char of key as shift
    movzx r14, byte [key_buffer]
    and r14, 0x1F           ; Shift 1-31
    
    xor rbx, rbx
    
.loop:
    cmp rbx, r13
    jge .done
    
    movzx rax, byte [file_buffer + rbx]
    
    ; Only shift letters
    cmp al, 'A'
    jl .not_upper
    cmp al, 'Z'
    jg .not_upper
    
    sub al, 'A'
    add al, r14b
    movzx rcx, al
    mov rax, rcx
    mov rcx, 26
    xor rdx, rdx
    div rcx
    add dl, 'A'
    mov al, dl
    jmp .store
    
.not_upper:
    cmp al, 'a'
    jl .store
    cmp al, 'z'
    jg .store
    
    sub al, 'a'
    add al, r14b
    movzx rcx, al
    mov rax, rcx
    mov rcx, 26
    xor rdx, rdx
    div rcx
    add dl, 'a'
    mov al, dl
    
.store:
    mov [file_buffer + rbx], al
    inc rbx
    jmp .loop
    
.done:
    pop rbx
    pop rbp
    ret

; ========================================================================
; Vigenere Cipher
; ========================================================================
vigenere_encrypt_buffer:
    push rbp
    mov rbp, rsp
    push rbx
    
    xor rbx, rbx
    xor r12, r12
    
.loop:
    cmp rbx, r13
    jge .done
    
    ; Normalize key index (r12 %= key_len) and fetch key char
    mov rax, r12
    xor rdx, rdx
    mov r8, [key_len]
    div r8
    mov r12, rdx

    movzx r14, byte [key_buffer + r12]
    and r14, 0x1F

    movzx rax, byte [file_buffer + rbx]
    
    ; Apply vigenere
    cmp al, 'A'
    jl .not_upper
    cmp al, 'Z'
    jg .not_upper
    
    sub al, 'A'
    add al, r14b
    movzx rcx, al
    mov rax, rcx
    mov rcx, 26
    xor rdx, rdx
    div rcx
    add dl, 'A'
    mov al, dl
    inc r12
    jmp .store
    
.not_upper:
    cmp al, 'a'
    jl .store
    cmp al, 'z'
    jg .store
    
    sub al, 'a'
    add al, r14b
    movzx rcx, al
    mov rax, rcx
    mov rcx, 26
    xor rdx, rdx
    div rcx
    add dl, 'a'
    mov al, dl
    inc r12
    
.store:
    mov [file_buffer + rbx], al
    inc rbx
    jmp .loop
    
.done:
    pop rbx
    pop rbp
    ret

; ========================================================================
; ROT13
; ========================================================================
rot13_buffer:
    push rbp
    mov rbp, rsp
    push rbx
    
    xor rbx, rbx
    
.loop:
    cmp rbx, r13
    jge .done
    
    movzx rax, byte [file_buffer + rbx]
    
    cmp al, 'A'
    jl .not_upper
    cmp al, 'Z'
    jg .not_upper
    
    sub al, 'A'
    add al, 13
    movzx rcx, al
    mov rax, rcx
    mov rcx, 26
    xor rdx, rdx
    div rcx
    add dl, 'A'
    mov al, dl
    jmp .store
    
.not_upper:
    cmp al, 'a'
    jl .store
    cmp al, 'z'
    jg .store
    
    sub al, 'a'
    add al, 13
    movzx rcx, al
    mov rax, rcx
    mov rcx, 26
    xor rdx, rdx
    div rcx
    add dl, 'a'
    mov al, dl
    
.store:
    mov [file_buffer + rbx], al
    inc rbx
    jmp .loop
    
.done:
    pop rbx
    pop rbp
    ret

; ========================================================================
; Check for Windows Path
; ========================================================================
check_windows_path:
    push rbp
    mov rbp, rsp
    
    ; Check if path starts with C:\ or similar
    movzx rax, byte [input_path]
    cmp al, 'C'
    je .warn
    cmp al, 'D'
    je .warn
    cmp al, 'E'
    je .warn
    
    movzx rax, byte [input_path + 1]
    cmp al, ':'
    jne .ok
    
.warn:
    mov rdi, msg_error_path
    call print_string
    
.ok:
    pop rbp
    ret

; ========================================================================
; Random Number Generator
; ========================================================================
init_random:
    push rbp
    mov rbp, rsp
    
    ; Use time as seed
    mov rax, 201            ; sys_time
    xor rdi, rdi
    syscall
    
    mov [random_seed], rax
    
    pop rbp
    ret

get_random_char:
    push rbp
    mov rbp, rsp
    
    ; Simple LCG
    mov rax, [random_seed]
    mov rcx, 1103515245
    mul rcx
    add rax, 12345
    mov [random_seed], rax
    
    ; Get printable char (A-Z, a-z, 0-9)
    xor rdx, rdx
    mov rcx, 62
    div rcx
    
    mov al, dl
    cmp al, 26
    jl .upper
    cmp al, 52
    jl .lower
    
    sub al, 52
    add al, '0'
    jmp .done
    
.upper:
    add al, 'A'
    jmp .done
    
.lower:
    sub al, 26
    add al, 'a'
    
.done:
    pop rbp
    ret

; ========================================================================
; Show Statistics
; ========================================================================
show_statistics:
    mov rdi, stats_header
    call print_string
    
    mov rdi, stats_files
    call print_string
    
    mov rax, [files_encrypted]
    call print_number
    
    mov rdi, newline
    call print_string
    
    mov rdi, stats_total
    call print_string
    
    mov rax, [total_processed]
    call print_number
    
    mov rdi, msg_bytes
    call print_string
    
    mov rdi, stats_footer
    call print_string
    
    jmp main_loop

; ========================================================================
; Show Help
; ========================================================================
show_help:
    mov rdi, help_text
    call print_string
    jmp main_loop

; ========================================================================
; Show About
; ========================================================================
show_about:
    mov rdi, about_text
    call print_string
    jmp main_loop

; ========================================================================
; Error Handlers
; ========================================================================
key_empty_error:
    mov rdi, msg_error_key
    call print_string
    jmp main_loop

file_error:
    cmp rax, -1
    je .open_error
    
    mov rdi, msg_error_create
    call print_string
    jmp main_loop
    
.open_error:
    mov rdi, msg_error_open
    call print_string
    jmp main_loop

; ========================================================================
; Exit Program
; ========================================================================
exit_program:
    mov rdi, newline
    call print_string
    mov rdi, separator
    call print_string
    
    mov rax, 60
    xor rdi, rdi
    syscall

; ========================================================================
; Utility Functions
; ========================================================================
print_string:
    push rbp
    mov rbp, rsp
    push rdi
    
    call string_length
    mov rdx, rax
    
    pop rsi
    
    mov rax, 1
    mov rdi, 1
    syscall
    
    pop rbp
    ret

string_length:
    push rbp
    mov rbp, rsp
    xor rax, rax
    
.loop:
    cmp byte [rdi + rax], 0
    je .done
    inc rax
    jmp .loop
    
.done:
    pop rbp
    ret

read_input:
    push rbp
    mov rbp, rsp
    push rdi
    push rsi
    
    mov rax, 0
    mov rdi, 0
    pop rdx
    pop rsi
    syscall
    
    dec rax
    mov byte [rsi + rax], 0
    
    pop rbp
    ret

print_number:
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    
    mov rbx, 10
    xor rcx, rcx
    
.divide_loop:
    xor rdx, rdx
    div rbx
    push rdx
    inc rcx
    test rax, rax
    jnz .divide_loop
    
.print_loop:
    pop rax
    add al, '0'
    
    push rcx
    mov [file_buffer], al
    mov rax, 1
    mov rdi, 1
    mov rsi, file_buffer
    mov rdx, 1
    syscall
    pop rcx
    
    loop .print_loop
    
    pop rdx
    pop rcx
    pop rbx
    pop rbp
    ret