/* The bootloader will look at this image and start execution at the symbol
   designated as the entry point. */
ENTRY(_start)

/* Tell where the various sections of the object files will be put in the final
   kernel image. */
SECTIONS
{
	/* Begin putting sections at 1 MiB, a conventional place for kernels to be
	   loaded at by the bootloader. */
	. = 1M;
  
	/* First put the multiboot header, as it is required to be put very early
	   early in the image or the bootloader won't recognize the file format.
	   Next we'll put the .text section. */
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.multiboot)
		*(.reserved_real16)
	}
  
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.gdt)
	}
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.irq.table)
	}
  
	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.text)
		*(.code)
	}
  
	/* Read-only data. */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	/* Read-write data (initialized) */ 
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}

	/* Read-write data (uninitialized) and stack */
	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(.bootstrap_stack)
		*(COMMON)
		*(.bss)
	}
  
  .data BLOCK(4K) : ALIGN(4K)
  {
    _tinyext2_fs.o
  }
	/* The compiler may produce other sections, by default it will put them in
	   a segment with the same name. Simply add stuff here as needed. */
}

