#ifndef __KERNEL_BUILD__
extern int main(int argc, char **argv);

void _start() {
  main(0, 0);
}
#endif
