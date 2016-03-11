extern void isr_0();
extern void isr_1();
extern void isr_2();
extern void isr_3();
extern void isr_4();
extern void isr_5();
extern void isr_6();
extern void isr_7();
extern void isr_8();
extern void isr_9();
extern void isr_10();
extern void isr_11();
extern void isr_12();
extern void isr_13();
extern void isr_14();
extern void isr_15();
extern void isr_end();

void *idtptrs[] = {
  isr_0,
  isr_1,
  isr_2,
  isr_3,
  isr_4,
  isr_5,
  isr_6,
  isr_7,
  isr_8,
  isr_9,
  isr_10,
  isr_11,
  isr_12,
  isr_13,
  isr_14,
  isr_15
};
int tot_idtptrs = sizeof(idtptrs) / sizeof(*idtptrs);
