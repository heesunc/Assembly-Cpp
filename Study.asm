%include "io64.inc"

section .text
global CMAIN
CMAIN:
     
        mov rbp, rsp; for correct debugging
    ;주석
    
    mov eax, 0x1234
    mov rbx, 0x12345678
    mov cl, 0xff
    
    ; 메모리 <-> 레지스터
    mov rax, a    ; a를 rax에 넣기 -> 디버깅 해보면 안 나옴 -> 주소 값을 가져온 것
    mov rax, [a] ; 이렇게 적어줘야 값을 넣는 것 -> 근데 정답은 아님
    mov al, [a] ; 최하위에 넣어줌 -> 제대로 나옴
    
    ; 레지스터에 잇는 것을 메모리에 건네주고 싶다면?
    mov [a], byte 0x55 ; byte를 명시해주어야 함
    mov [a], word 0x6666
    mov [a], cl ; cl이라는 것은 이미 지정되어 있기 때문에 필요 없음
    
    xor eax, eax
    ret

    ; 초기화 된 데이터
    ; [변수이름] [크기] [초기값]
    ; [크기] db(1) dw(2) dd(4) dq(8)
section .data
    a db 0x11   ; 1바이트 바구니라고 선언
    b dw 0x2222
    c dd 0x33333333
    d dq 0x4444444444444444
    
    ; 초기화 되지 않은 데이터
    ; [변수이름] [크기] [개수]
    ; [크기] resb(1) resw(2) resd(4) resq(8)
section .bss
    e resb 10
    
    ; 왜 data와 bss가 나뉘어져 있을까?
    ; exe 구조에서
    ; bss는 0이니까 최종적인 값만 필요 -> 실행 파일 크기 줄어든다
    ; data는 file에 올려야해서