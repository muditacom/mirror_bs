ifndef MK_LIBS_MK
MK_LIBS_MK=			TRUE

INCLUDER_MODULES_LIST=		dirs \
				config \
				modules \
				signature

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

LIBS_DIRS_PREFIX=		-L
LIBS_PREFIX=			-l

# TODO: Not sure is this quard is needed.
#ifndef 
LIBS_DEPENDENCIES_EXISTENCE=	$(wildcard \
					$(CONFIG_MODULE_DEP_FILE_NAME))

ifneq ($(LIBS_DEPENDENCIES_EXISTENCE), )
LIBS_DEPENDENCIES_COMMAND=	cat \
					$(CONFIG_MODULE_DEP_FILE_NAME)

LIBS_MODULES_LIST=		$(shell \
					$(LIBS_DEPENDENCIES_COMMAND))
else
LIBS_MODULES_LIST=
endif

#endif

ifeq ($(MODE_MEMORY_LEAK_DETECTOR), MODULE_MEMORY_MTRACE)
LIBS_CONDITIONAL_MODULES=	memory_mtrace
else ifeq ($(MODE_MEMORY_LEAK_DETECTOR), MODULE_MEMORY_WRAPPER)
LIBS_CONDITIONAL_MODULES=	memory_wrapper
else
LIBS_CONDITIONAL_MODULES=
endif

LIBS_MODULES_LIST+=		$(LIBS_CONDITIONAL_MODULES)

LIBS_MODULE_ROOT_DIR=		$(DIRS_MODULES_DIR)/$($(CONFIG_MODULE_PREFIX))
LIBS_MODULE_INSTALL_DIR=	$(LIBS_MODULE_ROOT_DIR)/$(DIRS_LIB_DIR)
LIBS_MODULE_INSTALL_RELATIVE_DIR=	$(RELATIVE_ROOT_DIR)/$(LIBS_MODULE_INSTALL_DIR)
LIBS_MODULE_LIB_NAME=		$($(CONFIG_MODULE_PREFIX))_$(SIGNATURE_SUFFIX)
LIBS_MODULE_LIB_FILE_NAME=	$(CONFIG_LIB_PREFIX)$(LIBS_MODULE_LIB_NAME).$(CONFIG_STATIC_LIBRARY_EXT)
LIBS_MODULE_LIB_FILE=		$(LIBS_MODULE_INSTALL_RELATIVE_DIR)/$(LIBS_MODULE_LIB_FILE_NAME)

LIBS_MODULE_EXIST_TEST=		$(wildcard \
					$(LIBS_MODULE_LIB_FILE))

LIBS_MODULE_FOUND_FORMATTER=	'%s %s %s %s'

LIBS_MODULE_FOUND_COMMAND=	printf \
					$(LIBS_MODULE_FOUND_FORMATTER) \
					$(LIBS_DIRS_PREFIX) \
					$(LIBS_MODULE_INSTALL_RELATIVE_DIR) \
					$(LIBS_PREFIX) \
					$(LIBS_MODULE_LIB_NAME)

LIBS_MODULE_FOUND_SUCCESS=	$(shell \
					$(LIBS_MODULE_FOUND_COMMAND))

LIBS_MODULE_FOUND_ERROR=	$(error \
					Library $(LIBS_MODULE_LIB_FILE_NAME) not found!)

LIBS_MODULE_CHECK_EXIST=	$(if \
					$(LIBS_MODULE_EXIST_TEST), \
					$(LIBS_MODULE_FOUND_SUCCESS), \
					$(LIBS_MODULE_FOUND_ERROR))

LIBS_LIST=			$(foreach \
					$(CONFIG_MODULE_PREFIX), \
					$(LIBS_MODULES_LIST), \
					$(LIBS_MODULE_CHECK_EXIST))

endif

