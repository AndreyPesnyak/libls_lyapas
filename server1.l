main(/)
	Os Oe Oq Oc Oy Or Od Ot Op
	@+F1(16) @+F2(16) @+F3(16) @+F4(10)
	@'0.0.0.0'>F2
	2⇒d 1⇒t 0⇒p
	*set_sockaddr_domain(F1,2/)
	*set_sockaddr_port(F1,1195/)
	*set_sockaddr_ip(F1,F2/)
	*TCP_server_new(F1/s,e)
§1	*accept(s,F3,10h/c)
	*freadf(c,F4,0,5/a)
	*fwritef(c,F4,0,5/a)
	*close(c/)
	→1
	*close(s/)
	**
************************************
*** ФУНКЦИИ СЕТЕВОГО ПРОГРАММРОВАНИЯ
************************************
set_sockaddr_domain(F1,d/)
	{mov edi,[ebp+220]}
	{mov eax,[ebp+16]}
	{mov [edi],ax}
	{mov al,2}
	{mov [ebp+1020],al}
	**
set_sockaddr_port(F1,p/)
	{mov edi,[ebp+220]}
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
	@+F2(12)
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
	{add edx,48}
	{mov [edi],edx}
	{int 80h}
	{mov [ebp+12],eax}
	**
TCP_server_new(F1/s,e)
	@+F2(12)
        {mov eax,102}
        {mov ebx,1}
        {mov ecx, [ebp+224]}
        {mov edi,ecx}
        {mov edx,2}
        {mov [edi],edx}
        {add edi,4}
        {mov edx,1}
        {mov [edi],edx}
        {add edi,4}
        {xor edx,edx}
        {mov [edi],edx}
        {int 80h}
        {mov [ebp+76],eax}
	{cmp eax,0}
	{je exit}
	{inc ebx}
	{mov eax,102}
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
        {cmp eax,0}
	{jne exit}
        {mov edi,ecx}
        {mov edx,[ebp+76]}
        {mov [edi],edx}
        {add edi,4}
        {mov edx,1}
        {mov [edi],edx}
	{mov eax,102}
        {inc ebx}
	{inc ebx}
        {int 80h}
	{exit: mov [ebp+20],eax}
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
