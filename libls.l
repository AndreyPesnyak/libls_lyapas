main(/)
	Ox Oq Oy Or Od Ot Op
	@+F1(16) @+F2(16)
	@'020004ABC0A8002C'>F1
	*char_to_number(F1/F1)
	0⇒d 1⇒t 2⇒p
	*socket(d,t,p/x)
	*connect(x,F1,10h/r)
	*freadf(x,F2,0,5/a)
	*fwritef(x,F2,0,5/a)
	*close(x/)
	**
************************************
*** ФУНКЦИИ СЕТЕВОГО ПРОГРАММРОВАНИЯ
************************************
char_to_number(F1/F1)
	{xor ebx,ebx}
	{mov edi,ebp}
	{add edi,220}
	{mov esi,[edi]}
  	{mov edi,esi}
  	{mov ecx,[ebp+1020]}
	{conv:mov al,byte[esi]}
	{mov [esi],bh}
  	{cmp al,0x40}
  	{jl number}
  	{sub al,7}
	{number:sub al,0x30}
	{shl bl,4}
	{or bl,al}
	{test ecx,0x1}
	{jz next_iteration}
  	{mov [edi],bl}
  	{xor bl,bl}
	{inc edi}
 	{next_iteration:inc esi}
	{loop conv}
	{shr [ebp+1020],1}
	**
socket(d,t,p/s)
	@+F1(12)
	{mov eax,102}
	{mov ebx,1}
	{mov ecx, [ebp+220]}
	{mov edi,ecx}
	{mov edx,[ebp+64]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+80]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+16]}
	{mov [edi],edx}
	{int 80h }
	{mov [ebp+76],eax}
	**
bind(s,p/)
	{push 0x0}
	{mov edx, [ebp+64]} 
	{ror dx,8}
	{push dx}
	{push word 0x2}
	{mov ecx,esp}
	{mov edx,0x00000010}
	{push edx}
	{push ecx}
	{push dword[ebp+76]}
	{mov ecx, esp}
	{mov ebx, 2}
	{mov eax,102}
	{int 80h}
	{add esp, 20}
	**
listen(s/)
	{push 0x1}
	{push dword[ebp+76]}
	{mov eax,0x66}
	{mov ebx,0x4}
	{mov ecx,esp}
	{int 80h}
	{add esp, 8}
	**
accept(s/q)
	{push 0x0}
	{push 0x0}
	{push dword[ebp+76]}
	{mov eax,0x66}
	{mov ebx,5}
	{mov ecx, esp}
	{int 80h}
	{mov [ebp+68], eax}
	{add esp,12}
	**
connect(s,F2,l/r)
	@+F1(16)
	{mov edi,[ebp+220]}
	{mov esi,[ebp+76]}
	{mov [edi],esi}
	{add edi,4}
	{mov esi,[ebp+224]}
	{mov [edi],esi}
	{add edi,4}
	{mov esi,[ebp+48]}
	{mov [edi],esi}
	{mov eax,102}
	{mov ebx,3}
	{mov ecx,[ebp+220]}
	{int 80h}
	{mov [ebp+72],eax}
	**
close(s/)
	{mov eax,6}
	{mov ebx,[ebp+76]}
	{int 80h}
	**
fwritef(n,F1,b,l/k)
	{mov eax,4}
	{mov ebx,[ebp+56]}
        {mov ecx,[ebp+220]}
	{add ecx,[ebp+8]}
	{mov edx,[ebp+48]}
	{int 80h}
	{mov [ebp+44],eax}
	**
freadf(n,F1,b,l/k)
	{mov eax,3}
        {mov ebx,[ebp+56]}
        {mov ecx,[ebp+220]}
	{add ecx,[ebp+8]}
	{mov edx,[ebp+48]}
	{int 80h}
	{mov [ebp+44],eax}
	**
