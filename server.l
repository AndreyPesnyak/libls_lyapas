main(/)
	Os Oe Oq Oc Oy Or Od Ot Op
	@+F1(16) @+F2(16) @+F3(16)
	@'0.0.0.0'>F2
	2⇒d 1⇒t 0⇒p
	*set_sockaddr_bind_domain(F1,2/)
	*set_sockaddr_bind_port(F1,1195/)
	*set_sockaddr_bind_ip(F1,F2/)
	*socket(d,t,p/s)
	*bind(s,F1,10h/e)
	*listen(s,100/e)
	*accept(s,F2,10h/c)
	*freadf(c,F3,0,5/a)
	*fwritef(c,F3,0,5/a)
	*close(c/)
	*close(s/)
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
set_sockaddr_bind_domain(F1,p/)
	{mov edi,[ebp+220]}
	{mov eax,[ebp+64]}
	{mov [edi],ax}
	{mov al,2}
	{mov [ebp+1020],al}
	**
set_sockaddr_bind_port(F1,p/)
	{mov edi,[ebp+220]}
	{add edi,2}
	{mov eax,[ebp+64]}
	{ror ax,8}
	{mov [edi],ax}
	{mov al,4}
	{mov [ebp+1020],al}
	**
set_sockaddr_bind_ip(F1,F2/)
	{xor edi,edi}
	{xor eax,eax}
	{mov ebx,10}
	{mov esi,[ebp+224]}
	{mov ecx,[ebp+1024]}
	{cycle:mov dl,byte[esi]}
	{cmp dl,46}
	{jne next_byte}
	{or edi,eax}
	{shl edi,8}
	{xor eax,eax}
	{dec ecx}
	{inc esi}
	{mov dl,byte[esi]}
	{next_byte:mul bl}
	{sub dl,0x30}
	{add al,dl}
	{inc esi}
	{loop cycle}
	{or edi,eax}
	{ror di,8}
	{ror edi,16}
	{ror di,8}
	{mov esi,[ebp+220]}
	{add esi,4}
	{mov [esi],edi}
	{mov al,8}
	{mov [ebp+1020],al}
	**
socket(d,t,p/s)
	@+F1(12)
	{mov eax,102}
	{mov ebx,1}
	{mov ecx, [ebp+220]}
	{mov edi,ecx}
	{mov edx,[ebp+16]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+80]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+64]}
	{mov [edi],edx}
	{int 80h}
	{mov [ebp+76],eax}
	**
bind(s,F1,l/e)
	@+F2(12)
	{mov eax,102}
	{mov ebx,2}
	{mov ecx,[ebp+224]}
	{mov edi,ecx}
	{mov edx,[ebp+76]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+220]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+48]}
	{mov [edi],edx}
	{int 80h}
	{mov [ebp+20],eax}
	**
listen(s,b/e)
	@+F1(8)
	{mov ecx,[ebp+220]}
	{mov edi,ecx}
	{mov edx,[ebp+76]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+8]}
	{mov [edi],edx}
	{mov eax,102}
	{mov ebx,4}
	{int 80h}
	{mov [ebp+20],eax}
	**
accept(s,F1,l/c)
	@+F2(8)
	{mov eax,102}
	{mov ebx,5}
	{mov ecx,[ebp+224]}
	{mov edi,ecx}
	{mov edx,[ebp+76]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+220]}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,[ebp+48]}
	{mov [edi],edx}
	{int 80h}
	{mov [ebp+12],eax}
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
