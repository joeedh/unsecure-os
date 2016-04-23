#ifndef _SUDOBIOS_H
#define _SUDOBIOS_H

//has to be run after file system is set up
void SBIOS_init();
int SBIOS_CallBios(int func);

#endif /* _SUDOBIOS_H */
