ORG 0x7c00 ; endereço de carregamento
BITS 16 ; modo de 16 bits

start:
  mov si, message ; carrega o endereço da mensagem em SI
  call print ; chama a função print
  jmp $ ; entra em loop infinito

print:
  mov bx, 0 ; inicializa BX com 0
.loop:
  lodsb ; carrega o próximo byte da string em AL
  cmp al, 0 ; compara AL com 0 (fim da string)
  je .done ; se AL for 0, pula para .done
  call print_char ; chama a função print_char
  jmp .loop ; repete o loop
.done:  
  ret ; retorna da função

print_char:
  mov ah, 0eh ; função de impressão de caractere
  int 0x10 ; chamada de interrupção de BIOS
  ret ; retorna da função

message: db ' ##### Bem-vindo ao MEU BOOT LOADER #####', 0 ; define a mensagem com terminador nulo

times 510-($ - $$) db 0 ; preenche o restante do setor com zeros
dw 0xAA55 ; assinatura de boot
