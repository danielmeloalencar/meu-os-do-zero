ORG 0 ; endereço de carregamento
BITS 16 ; modo de 16 bits
_start:
  jmp short start
  nop

times 33 db 0 ; preenche o restante do setor com zeros

start:
  jmp 0x7c0:step2 ; pula para o endereço 0x7C0:step2

step2:
  cli ; desabilita interrupções
  mov ax, 0x07C0 ; carrega o endereço de segmento
  mov ds, ax ; carrega o endereço de segmento em DS
  mov es, ax ; carrega o endereço de segmento em ES
  mov ax, 0x00 ; carrega o endereço de segmento 0x
  mov ss, ax ; carrega o endereço de segmento em SS
  mov sp, 0x7C00 ; carrega o endereço de pilha
  sti ; habilita interrupções

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
