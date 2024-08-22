#include <stdio.h>
#include <Windows.h>

BOOL WINAPI HandlerRoutine(DWORD fdwCtrlType) {
	if (fdwCtrlType == CTRL_C_EVENT)
	{
		printf("Signal caught\n");
		return EXIT_SUCCESS;
	}
}

int main(void) {
	if (!SetConsoleCtrlHandler(HandlerRoutine, TRUE)) 
	{
		printf("Could not install Control handler\n"); 
		return EXIT_FAILURE; 
	}

	printf("Control Handler is installed\n"); 

	while (1);
	
	return EXIT_SUCCESS; 
}

