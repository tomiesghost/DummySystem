includelib legacy_stdio_definitions.lib
includelib ucrt.lib
includelib kernel32.lib

SetConsoleCtrlHandler proto 
printf				  proto 


.data
caughtSignal			byte	"Signal caught", 10, 0
handlerInstalled		byte	"Control Handler is installed", 10, 0
handlerNotInstalled		byte	"Could not install control handler", 10, 0

CTRL_C_EVENT			equ		0
EXIT_FAILURE			equ		1
EXIT_SUCCESS			equ		0


.code
main PROC
		 call setConsole
		 cmp  rax, EXIT_SUCCESS
		 jmp  exit

		 call installedHandler
		 cmp  rax, 0
		 jmp  exit

exit:
	 xor rax, rax
	 ret

main ENDP


print PROC
    sub  rsp, 40   
    call printf
    add  rsp, 40  
    ret
print ENDP


setConsole PROC
			  sub  rsp, 40
			  lea  rcx, [HandlerRoutine]
			  mov  rdx, 1
			  call SetConsoleCtrlHandler
			  add  rsp, 40

setConsole ENDP


installedHandler PROC
					 sub  rsp, 40
					 lea  rcx, handlerInstalled
					 call print
					 add  rsp, 40
					 
					 jmp whileLp
whileLp:
		jmp whileLp

installedHandler ENDP


HandlerRoutine PROC dwCtrlType:DWORD
			
		     lea  rcx, caughtSignal
			 call printf
			
HandlerRoutine ENDP


end