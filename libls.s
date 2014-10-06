global _start
section .text
_start:
  mov eax,45
  xor ebx,ebx
  int 0x80
  mov [_sizebim],eax
  push eax
  sub esp,1412
  push ebp
  mov ebp,esp
  call main
  mov eax,1
  mov ebx,0
  int 0x80
main:
  xor eax,eax
  mov [ebp+96],eax
  xor eax,eax
  mov [ebp+68],eax
  mov byte[ebp+121],1
  mov ebx,[ebp+1416]
  mov [ebp+220],ebx
  mov [ebp+620],dword 4
  add [ebp+1416],dword 4
  mov [ebp+1020],dword 0
  call _addmem
  mov eax,04ABh
  mov [ebp+68],eax
  sub esp,1420
  push ebp
  mov edx,esp
  mov ebx,[ebp+1416]
  mov [edx+1416],ebx
  mov ebp,edx
  call socket
  mov edx,esp
  pop ebp
  add esp,1420
  mov eax,[edx+76]
  mov [ebp+96],eax
  sub esp,1420
  push ebp
  mov edx,esp
  mov ebx,[ebp+1416]
  mov [edx+1416],ebx
  mov eax,[ebp+96]
  mov [edx+76],eax
  mov eax,[ebp+68]
  mov [edx+64],eax
  mov ebp,edx
  call bind
  mov edx,esp
  pop ebp
  add esp,1420
  sub esp,1420
  push ebp
  mov edx,esp
  mov ebx,[ebp+1416]
  mov [edx+1416],ebx
  mov eax,[ebp+96]
  mov [edx+76],eax
  mov ebp,edx
  call listen
  mov edx,esp
  pop ebp
  add esp,1420
  mov eax,3
  mov ebx,0
  mov ecx,[ebp+220]
  add ecx, [ebp+1020]
  mov edx,[ebp+620]
  int 0x80
  dec eax
  add [ebp+1020],eax
  sub esp,1420
  push ebp
  mov edx,esp
  mov ebx,[ebp+1416]
  mov [edx+1416],ebx
  mov eax,[ebp+96]
  mov [edx+76],eax
  mov ebp,edx
  call close
  mov edx,esp
  pop ebp
  add esp,1420
  ret
socket:
  xor edx,edx
  push edx
  push 0x01
  push 0x02
  mov eax,102
  mov ebx,1
  mov ecx, esp
  int 80h
  mov [ebp+76],eax
  add esp,12
  ret
bind:
  push 0x0
  mov edx, [ebp+64]
  ror dx,8
  push dx
  push word 0x2
  mov ecx,esp
  mov edx,0x00000010
  push edx
  push ecx
  push dword[ebp+76]
  mov ecx, esp
  mov ebx, 2
  mov eax,102
  int 80h
  add esp, 20
  ret
listen:
  push 0x1
  push dword[ebp+76]
  mov eax,0x66
  mov ebx,0x4
  mov ecx,esp
  int 80h
  add esp, 8
  ret
close:
  mov eax,6
  mov ebx,[ebp+76]
  int 80h
  ret
_addmem:
  push eax
  push ebx
  mov ebx,[ebp+1416]
  cmp ebx,[_sizebim]
  jbe .end
  sub ebx,[_sizebim]
  add ebx,1000h
  add ebx,[_sizebim]
  mov eax,45
  int 0x80
  and eax,eax
  jnz ._errend
  mov eax,1
  mov ebx,1
  int 0x80
._errend:
  mov [_sizebim],ebx
.end:
  pop ebx
  pop eax
  ret
_errend:
  mov eax,1
  mov ebx,1
  int 0x80
section .data
_sizebim dd 0
_rand dd 0xa1248aa9
_vesa:
  db 0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4
  db 1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5
  db 1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5
  db 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6
  db 1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5
  db 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6
  db 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6
  db 3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7
  db 1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5
  db 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6
  db 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6
  db 3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7
  db 2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6
  db 3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7
  db 3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7
  db 4,5,5,6,5,6,6,7,5,6,6,7,6,7,7,8

_I:
  dd 0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80,0x100,0x200,0x400,0x800,0x1000,0x2000,0x4000,0x8000
  dd 0x10000,0x20000,0x40000,0x80000,0x100000,0x200000,0x400000,0x800000
  dd 0x1000000,0x2000000,0x4000000,0x8000000,0x10000000,0x20000000,0x40000000,0x80000000
