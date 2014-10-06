main(/)
	Ox Oq 
	@+F1(1)
	4ABh⇒q
	*socket(/x)
	*bind(x,q/)
	*listen(x/)
	/F1<C
	*close(x/)
	**
************************************
*** ФУНКЦИИ СЕТЕВОГО ПРОГРАММРОВАНИЯ
************************************

socket(/s)
	{xor edx,edx}
	{push edx}
	{push 0x01}
	{push 0x02}
	{mov eax,102}
	{mov ebx,1}
	{mov ecx, esp}
	{int 80h}
	{mov [ebp+76],eax}
	{add esp,12}
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
	{push dword[ebp+76]}
	{mov eax,0x66}
	{mov ebx,5}
	{mov ecx, esp}
	{int 80h}
	{mov [ebp+68], eax}
	{add esp,8}
	**
TCPServercreate(p/s)
	{xor edx,edx}
	{push edx}
	{push 0x1}
	{push 0x2}
	{mov eax,102}
	{mov ebx,1}
	{mov ecx,esp}
	{int 80h}
	**
close(s/)
	{mov eax,6}
	{mov ebx,[ebp+76]}
	{int 80h}
	**
