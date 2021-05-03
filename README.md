# ARM-processor

A simple implementation of an ARM-based processor.

## ARM-processor Architecture

The overall architecture of ARM processors simplified:

![ARM-processors Architecture](./img/ARM_processors_architecture.png)

## Condition codes

ConditionCheck module receives the condition bits (cond) from the input instruction and checks the condition with the help of the Status Register.

The conditions for the condition to be met are listed in Table.

![Table A3-1 Condition codes](./img/Table_A3-1_Condition_codes.png)

## ARM-processor Instructions

![Table 2 CPU Instructions](./img/Table_2_CPU_Instructions.png)

## ALU Instructions

![Table 5 ALU Instructions](./img/Table_5_ALU_Instructions.png)

## Shift Case (In shift immediate commands)

![Table 4 shift case in shift immediate commands](./img/Table_4_shift_case_in_shift_immediate_commands.png)
