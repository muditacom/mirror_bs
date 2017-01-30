ifndef MK_PLATFORM_MK
MK_PLATFORM_MK=			TRUE

INCLUDER_MODULES_LIST=		config \
				jobs \
				ubuntu \
				path

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

PLATFORM_SEPARATOR=		-
PLATFORM_HOST_ARCHITECTURE=	host

# TODO: Default platform should not be assumed!
ifndef PLATFORM
PLATFORM=			$(PLATFORM_HOST_ARCHITECTURE)
endif

# INFO: Base configuration
PLATFORM_HOST_ASSEMBLER=	as
PLATFORM_HOST_ARCHIVER=		ar
PLATFORM_HOST_LINKER=		ld
PLATFORM_HOST_RANLIB=		ranlib
PLATFORM_HOST_C_COMPILER=	gcc
PLATFORM_HOST_CPP_COMPILER=	g++
PLATFORM_HOST_FLAG_LIST=	-pthread

# INFO: Host.
ifeq ($(PLATFORM), $(PLATFORM_HOST_ARCHITECTURE))
PLATFORM_PREFIX=
PLATFORM_ASSEMBLER=		$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_HOST_ARCHIVER)
PLATFORM_C_COMPILER=		$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_HOST_CPP_COMPILER)
PLATFORM_FLAG_LIST=		$(PLATFORM_HOST_FLAG_LIST)

# TODO: Host should be solved in another way.
PLATFORM_QEMU=			
PLATFORM_UBUNTU=		
PLATFORM_UBUNTU_KERNEL_SUFFIX=	
PLATFORM_UBUNTU_INITRD_SUFFIX=	
PLATFORM_CPU=			
PLATFORM_MACHINE=		
PLATFORM_SMP=			
PLATFORM_MEMORY=		
PLATFORM_STORAGE=		
PLATFORM_APPEND=		
endif

# TODO: Compilation process not tested
# INFO: Intel Architecture 64 bit
ifeq ($(PLATFORM), x86_64)
PLATFORM_PREFIX=
PLATFORM_ASSEMBLER=		$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_C_COMPILER=		$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_HOST_CPP_COMPILER)
PLATFORM_FLAG_LIST=		$(PLATFORM_HOST_FLAG_LIST)

PLATFORM_QEMU=			x86_64
PLATFORM_UBUNTU=		amd64
PLATFORM_UBUNTU_KERNEL_SUFFIX=	generic
PLATFORM_UBUNTU_INITRD_SUFFIX=	generic
PLATFORM_CPU=			$(PLATFORM_HOST_ARCHITECTURE)
PLATFORM_MACHINE=		pc
PLATFORM_SMP=			$(JOBS_PROCESSORS_COUNT)
PLATFORM_MEMORY=		4G
PLATFORM_STORAGE=		-hda \
					$(UBUNTU_SQUASHFS_PATH)
PLATFORM_APPEND=		"root=/dev/sda console=ttyS0"
endif

# TODO: Compilation process not tested
# INFO: Intel Architecture 32 bit
ifeq ($(PLATFORM), i386)
PLATFORM_PREFIX=
PLATFORM_ASSEMBLER=		$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_C_COMPILER=		$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_HOST_CPP_COMPILER)
PLATFORM_FLAG_LIST=		$(PLATFORM_HOST_FLAG_LIST)

PLATFORM_QEMU=			i386
PLATFORM_UBUNTU=		i386
PLATFORM_UBUNTU_KERNEL_SUFFIX=	generic
PLATFORM_UBUNTU_INITRD_SUFFIX=	generic
PLATFORM_CPU=			$(PLATFORM_HOST_ARCHITECTURE)
PLATFORM_MACHINE=		pc
PLATFORM_SMP=			$(JOBS_PROCESSORS_COUNT)
PLATFORM_MEMORY=		4G
PLATFORM_STORAGE=		-hda \
					$(UBUNTU_SQUASHFS_PATH)
PLATFORM_APPEND=		"root=/dev/sda console=ttyS0"
endif

# TODO: Implement this architecture
# INFO: AMR 64 bit
ifeq ($(PLATFORM), aarch64)
PLATFORM_QEMU=			aarch64
PLATFORM_UBUNTU=		arm64
PLATFORM_UBUNTU_KERNEL_SUFFIX=	generic
PLATFORM_UBUNTU_INITRD_SUFFIX=	generic	
PLATFORM_MACHINE=		virt
PLATFORM_SMP=			$(JOBS_PROCESSORS_COUNT)
PLATFORM_MEMORY=		4G
PLATFORM_STORAGE=		-hda \
					$(UBUNTU_SQUASHFS_PATH)
PLATFORM_APPEND=		""
endif

# INFO: ARM 32 bit
ifeq ($(PLATFORM), arm)
PLATFORM_PREFIX=		$(PLATFORM)-none-eabi
PLATFORM_PREFIX_EXPORT=		$(PATH_EXPORT_COMMAND) && \
				$(PLATFORM_PREFIX)
PLATFORM_ASSEMBLER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_LINKER)
PLATFORM_C_COMPILER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_FLAG_LIST=		-mcpu=arm926ej-s

PLATFORM_QEMU=			$(PLATFORM)
PLATFORM_UBUNTU=		$(PLATFORM)hf
PLATFORM_UBUNTU_KERNEL_SUFFIX=	lpae
PLATFORM_UBUNTU_INITRD_SUFFIX=	generic-lpae
PLATFORM_CPU=			cortex-a9
PLATFORM_MACHINE=		vexpress-a15
PLATFORM_SMP=			4
PLATFORM_MEMORY=		1G
PLATFORM_STORAGE=		-drive \
					file=$(UBUNTU_SQUASHFS_PATH),if=sd,cache=writeback
PLATFORM_APPEND=		"root=/dev/mmcblk0p2 vga=normal mem=$(PLATFORM_MEMORY) devtmpfs.mount=0 rw"
endif

# INFO: ARM 32 bit
ifeq ($(PLATFORM), armv7em)
PLATFORM_PREFIX=		arm-none-eabi
PLATFORM_PREFIX_EXPORT=		$(PATH_EXPORT_COMMAND) && \
				$(PLATFORM_PREFIX)
PLATFORM_ASSEMBLER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_LINKER)
PLATFORM_C_COMPILER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_C_COMPILER)
# TODO: Cut of not obligatory!
PLATFORM_SPECS_LIST=		-mfpu=fpv4-sp-d16 \
				-mfloat-abi=softfp \
				-mcpu=cortex-m4 \
				-march=armv7e-m \
				-mthumb

PLATFORM_DEFINES_LIST=		-DREVISION_STR=\"@\" \
				-DREVISION_SGN=0x00000000 \
				-DPROJECT_NAME=\"ekofone\" \
				-DREENTRANT_SYSCALLS_PROVIDED=1 \
				-DDEBUG \
				-DNO_VCP \
				-DBATTERY_SIZE=710 \
				-DCORE_M4 \
				-DARM_MATH_CM4

PLATFORM_WARNINGS_LIST=		-Wno-unused-function \
				-Werror \
				-Wall \
				-Wstrict-prototypes \
				-Wreturn-type \
				-Wmissing-prototypes \
				-Wmissing-declarations \
				-Wimplicit-function-declaration \
				-Wmaybe-uninitialized \
				-Wuninitialized

PLATFORM_IMPERS_LIST=		-fno-strict-aliasing \
				-ffunction-sections \
				-fdata-sections \
				-fno-builtin-printf \
				-finput-charset=UTF-8

PLATFORM_LINKER_LIST=		-Wl,--gc-sections \
				-Os \
				-DSTM32L476xx \
				-DUSED_PROCESSOR_L4 \
				-DUSE_HAL_DRIVER=1

PLATFORM_FLAG_LIST=		$(PLATFORM_SPECS_LIST) \
				$(PLATFORM_DEFINES_LIST) \
				$(PLATFORM_WARNINGS_LIST) \
				$(PLATFORM_IMPERS_LIST) \
				$(PLATFORM_LIBS_LIST) \
				$(PLATFORM_LINKER_LIST)

PLATFORM_QEMU=			
PLATFORM_UBUNTU=		
PLATFORM_UBUNTU_KERNEL_SUFFIX=	
PLATFORM_UBUNTU_INITRD_SUFFIX=	
PLATFORM_CPU=			
PLATFORM_MACHINE=		
PLATFORM_SMP=			
PLATFORM_MEMORY=		
PLATFORM_STORAGE=		
PLATFORM_APPEND=		
endif

# INFO: OpenRISC 32 bit
ifeq ($(PLATFORM), or1k)
PLATFORM_PREFIX=		$(PLATFORM)-elf
PLATFORM_PREFIX_EXPORT=		$(PATH_EXPORT_COMMAND) && \
				$(PLATFORM_PREFIX)
PLATFORM_ASSEMBLER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_ASSEMBLER)
PLATFORM_ARCHIVER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_ARCHIVER)
PLATFORM_LINKER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_LINKER)
PLATFORM_RANLIB=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_RANLIB)
PLATFORM_C_COMPILER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_C_COMPILER)
PLATFORM_CPP_COMPILER=		$(PLATFORM_PREFIX_EXPORT)-$(PLATFORM_HOST_CPP_COMPILER)
PLATFORM_FLAG_LIST=		
endif

ifneq ($(wildcard $(CONFIG_PLATFORMS_FILE_NAME)), )
PLATFORM_COMPATIBLE_LIST_COMMAND=	cat \
						$(CONFIG_PLATFORMS_FILE_NAME)

PLATFORM_COMPATIBLE_LIST=	$(shell \
					$(PLATFORM_COMPATIBLE_LIST_COMMAND))

PLATFORM_CURRENT_PRESENT=	$(filter \
					$(PLATFORM), \
					$(PLATFORM_COMPATIBLE_LIST))


ifeq ($(PLATFORM_CURRENT_PRESENT), $(PLATFORM))
PLATFORM_COMPATIBLE_FLAG=	TRUE
else
PLATFORM_COMPATIBLE_FLAG=	FALSE
endif
else
PLATFORM_COMPATIBLE_FLAG=	TRUE
endif

endif

