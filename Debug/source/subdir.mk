################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../source/Final_Project.c \
../source/semihost_hardfault.c 

S_SRCS += \
../source/Final_Project.s 

C_DEPS += \
./source/Final_Project.d \
./source/semihost_hardfault.d 

OBJS += \
./source/Final_Project.o \
./source/semihost_hardfault.o 


# Each subdirectory must supply rules for building sources it contributes
source/%.o: ../source/%.c source/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__REDLIB__ -DCPU_MK64FN1M0VLL12 -DCPU_MK64FN1M0VLL12_cm4 -DSDK_OS_BAREMETAL -DSERIAL_PORT_TYPE_UART=1 -DSDK_DEBUGCONSOLE=1 -DCR_INTEGER_PRINTF -DPRINTF_FLOAT_ENABLE=0 -D__MCUXPRESSO -D__USE_CMSIS -DDEBUG -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\board" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\source" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\utilities" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\drivers" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\device" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\component\serial_manager" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\component\lists" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\CMSIS" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\component\uart" -O0 -fno-common -g3 -gdwarf-4 -Wall -c -ffunction-sections -fdata-sections -fno-builtin -fmerge-constants -fmacro-prefix-map="$(<D)/"= -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -D__REDLIB__ -fstack-usage -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.o)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

source/%.o: ../source/%.s source/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: MCU Assembler'
	arm-none-eabi-gcc -c -x assembler-with-cpp -D__REDLIB__ -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\board" -I"C:\Users\shari\Documents\MCUXpressoIDE_11.10.0_3148\workspace\Final_Project\source" -g3 -gdwarf-4 -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -D__REDLIB__ -specs=redlib.specs -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-source

clean-source:
	-$(RM) ./source/Final_Project.d ./source/Final_Project.o ./source/semihost_hardfault.d ./source/semihost_hardfault.o

.PHONY: clean-source

