/* Linker script for Olimex STM32-H103 eval board.
 *
 * Version: 0.1
 *
 *  Copyright 2007 CodeSourcery.
 *
 * The authors hereby grant permission to use, copy, modify, distribute,
 * and license this software and its documentation for any purpose, provided
 * that existing copyright notices are retained in all copies and that this
 * notice is included verbatim in any distributions. No written agreement,
 * license, or royalty fee is required for any of the authorized uses.
 * Modifications to this software may be copyrighted by their authors
 * and need not follow the licensing terms described here, provided that
 * the new terms are clearly indicated on the first page of each file where
 * they apply.
 *
 * Modified by Olimex
 * 2009-04-07: Modified by Piotr Esden-Tempski <piotr@esden.net>
 */

_estack = 0x20000000 + 48K;

SECTIONS
  {
    .  = 0x0;          /* From 0x00000000 */

    .bios 0x08004200 (NOLOAD) : {
      build/BIOS.o
    }

    .text : {
      _vectors = .;
      *(.isr_vectors)      /* Vector table */
      _scode = .;
      *(.text*)        /* Program code */
      _ecode = .;
      *(.rodata*)      /* Read only data */
      _etext = .;
      _sidata = _etext;
    } >rom

    .  = 0x20000000;   /* From 0x20000000 */      

    .data : {
      _sdata = . ;
      *(.data)        /* Data memory */
      _edata = .;
    } >ram AT > rom

  .bss : {
    _sbss = .;
    *(.bss)         /* Zero-filled run time allocate data memory */
    _ebss = .;
    } >ram AT > rom
    
    .dummy (NOLOAD) : {
         /* We don't need no stinking exceptions */
        *(.ARM.exidx*)
    }
  }  
/*========== end of file ==========*/
