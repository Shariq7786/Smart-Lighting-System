@ Group 06 Work:
@ Done By: Muhammad Shariq Batavia and Md Nazmun Hasan Nafees



.syntax unified
.global asm_initGPIO
.global asm_turnRedLEDOn
.global asm_turnRedLEDOff
.global asm_turnGreenLEDOn
.global asm_turnGreenLEDOff
.global asm_delay_ms

.text

// Initialize GPIO
asm_initGPIO:
    // Enable clock to Port A, Port B, Port C, and Port E
    LDR R0, =0x40048038  // Address for SIM_SCGC5
    LDR R1, [R0]
    ORR R1, R1, #0x3F    // Enable clock to all necessary ports (A, B, C, E)
    STR R1, [R0]

    // Set PTA4 (SW3) as input (already configured with pull-up)
    LDR R0, =0x40049000  // Address for PORTA_PCR[4]
    LDR R1, [R0]
    BIC R1, R1, #0x700   // Clear MUX field
    ORR R1, R1, #0x1     // Set MUX=1 (GPIO)
    STR R1, [R0]

    // Set PTC6 (SW2) as input (already configured with pull-up)
    LDR R0, =0x4004A000  // Address for PORTC_PCR[6]
    LDR R1, [R0]
    BIC R1, R1, #0x700   // Clear MUX field
    ORR R1, R1, #0x1     // Set MUX=1 (GPIO)
    STR R1, [R0]

    // Set PTB22 (Red LED) as output
    LDR R0, =0x4004B000  // Address for PORTB_PCR[22]
    LDR R1, [R0]
    BIC R1, R1, #0x700   // Clear MUX field
    ORR R1, R1, #0x1     // Set MUX=1 (GPIO)
    STR R1, [R0]

    // Set PTE26 (Green LED) as output
    LDR R0, =0x4004D000  // Address for PORTE_PCR[26]
    LDR R1, [R0]
    BIC R1, R1, #0x700   // Clear MUX field
    ORR R1, R1, #0x1     // Set MUX=1 (GPIO)
    STR R1, [R0]

    // Configure direction of pins: PTA4 (input), PTC6 (input), PTB22 (output), PTE26 (output)
    LDR R0, =0x400FF094  // Address for GPIOA_PDDR
    LDR R1, [R0]
    BIC R1, R1, #0x10    // Set PTA4 as input
    STR R1, [R0]

    LDR R0, =0x400FF0B4  // Address for GPIOC_PDDR
    LDR R1, [R0]
    BIC R1, R1, #0x40    // Set PTC6 as input
    STR R1, [R0]

    LDR R0, =0x400FF054  // Address for GPIOB_PDDR
    LDR R1, [R0]
    ORR R1, R1, #0x400000 // Set PTB22 as output
    STR R1, [R0]

    LDR R0, =0x400FF114  // Address for GPIOE_PDDR
    LDR R1, [R0]
    ORR R1, R1, #0x2000000 // Set PTE26 as output
    STR R1, [R0]

    BX LR  // Return from function

// Turn on Red LED
asm_turnRedLEDOn:
    LDR R0, =0x400FF040  // Address for GPIOB_PSOR
    LDR R1, =0x400000     // Set bit for PTB22
    STR R1, [R0]
    BX LR  // Return from function

// Turn off Red LED
asm_turnRedLEDOff:
    LDR R0, =0x400FF043  // Address for GPIOB_PCOR
    LDR R1, =0x400000     // Clear bit for PTB22
    STR R1, [R0]
    BX LR  // Return from function

// Turn on Green LED
asm_turnGreenLEDOn:
    LDR R0, =0x400FF100  // Address for GPIOE_PSOR
    LDR R1, =0x2000000    // Set bit for PTE26
    STR R1, [R0]
    BX LR  // Return from function

// Turn off Green LED
asm_turnGreenLEDOff:
    LDR R0, =0x400FF103  // Address for GPIOE_PCOR
    LDR R1, =0x2000000    // Clear bit for PTE26
    STR R1, [R0]
    BX LR  // Return from function

// Delay function (in ms)
asm_delay_ms:
    // Delay for a fixed number of ms (simple loop)
    MOV R2, #1000       // Set loop count (1000 for 1ms delay)
    loop_delay:
        NOP              // No operation (just a placeholder)
        SUBS R2, R2, #1  // Decrement loop counter
        BNE loop_delay   // If counter is not zero, continue loop
    BX LR  // Return from function
