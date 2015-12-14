main(/)
	Os Ot Oe Oc Oa Op
	@+F1(16) @+F2(16) @+F3(16) @+F4(10) @+F5(16)
	@'0.0.0.0'>F2
	*set_sockaddr_port(F1,1195/)
	*set_sockaddr_ip(F1,F2/)
	*socket(1/s)
	*bind(s,F1/e)
	*listen(s,100/e)
§1	*accept(s,F3/c)
	*get_sockaddr_ip(F3/F5)
	*get_sockaddr_port(F3/p)
	*freadf(c,F4,0,5/a)
	*fwritef(c,F4,0,5/a)
	*close(c/)
	→1
	*close(s/)
	**
************************************
*** ФУНКЦИИ СЕТЕВОГО ПРОГРАММРОВАНИЯ
************************************
set_sockaddr_port(F1,p/)
	{mov edi,[ebp+220]}
	{mov eax,2}
	{mov [edi],ax}
	{add edi,2}
	{mov eax,[ebp+64]}
	{ror ax,8}
	{mov [edi],ax}
	{mov al,4}
	{mov [ebp+1020],al}
	**
set_sockaddr_ip(F1,F2/)
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
get_sockaddr_ip(F1/F2)
	{xor edi,edi}
	{xor eax,eax}
	{xor edx,edx}
	{mov ebx,10}
	{mov esi,[ebp+220]}
	{mov edi,[ebp+224]}
	{add esi,4}
	{mov ecx,4}
	{cycle1:mov al,byte[esi]}
	{div bl}
	{mov dl,ah}
	{add dl,0x30}
	{cmp al,0}
	{je next_byte1}
	{shl dx,8}
	{xor ah,ah}
	{div bl}
	{mov dl,ah}
	{add dl,0x30}
	{cmp al,0}
	{je next_byte1}
	{shl edx,8}
	{mov dl,al}
	{add dl,0x30}
	{next_byte1:mov [edi],dl}
	{inc edi}
	{shr edx,8}
	{cmp dl,0}
	{jne next_byte1}
	{mov eax,46}
	{mov [edi],al}
	{inc edi}
	{inc esi}
	{loop cycle1}
	{dec edi}
	{mov [edi],cl}
	**
get_sockaddr_port(F1/p)
	{mov edx,[ebp+220]}
	{inc edx}
	{inc edx}
	{xor eax,eax}
	{mov ax,[edx]}
	{ror ax,8}
	{mov [ebp+68],eax}
	**
socket(t/s)
	@+F1(12)
	{mov eax,102}
	{mov ebx,1}
	{mov ecx, [ebp+220]}
	{mov edi,ecx}
	{mov edx,2}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,1}
	{mov [edi],edx}
	{add edi,4}
	{mov edx,0}
	{mov [edi],edx}
	{int 80h}
	{mov [ebp+76],eax}
	**
bind(s,F1/e)
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
	{mov edx,0x10}
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
accept(s,F1/c)
	@+F2(12)
	@+F3(4)
	{mov ecx,[ebp+228]}
	{mov edi,ecx}
	{mov ecx,0x10}
	{mov [edi],ecx}
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
	{mov edx,ebp}
	{add edx,228}
	{mov [edi],edx}
	{int 80h}
	{mov [ebp+12],eax}
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
	{mov [ebp+1020],eax}
	**
