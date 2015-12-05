main(/)
	Os Oa Oe
	@+F1(16) @+F2(16) @+F3(5) @+F4(5)
	@'192.168.0.68'>F2
	@'echo\n'>F3
	*set_sockaddr_port(F1,1195/)
	*set_sockaddr_ip(F1,F2/)
	*socket(1/s)
	*connect(s,F1/e)
	*fwritef(s,F3,0,5/a)
	*freadf(s,F4,0,5/a)
	*fwritef(1,F4,0,5/a)
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
connect(s,F2/e)
	@+F1(16)
	{mov edi,[ebp+220]}
	{mov esi,[ebp+76]}
	{mov [edi],esi}
	{add edi,4}
	{mov esi,[ebp+224]}
	{mov [edi],esi}
	{add edi,4}
	{mov esi,0x10}
	{mov [edi],esi}
	{mov eax,102}
	{mov ebx,3}
	{mov ecx,[ebp+220]}
	{int 80h}
	{mov [ebp+20],eax}
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
