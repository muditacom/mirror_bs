ifndef MK_EXTERNALS_MK
MK_EXTERNALS_MK=		TRUE

INCLUDER_MODULES_LIST=		config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

EXTERNALS_PREFIX=		-l

EXTERNALS_DEPENDENCIES_EXISTENCE=	$(wildcard \
						$(CONFIG_EXTERNALS_FILE_NAME))

ifneq ($(EXTERNALS_DEPENDENCIES_EXISTENCE), )
EXTERNALS_DEPENDENCIES_COMMAND=	cat \
					$(EXTERNALS_DEPENDENCIES_EXISTENCE)

EXTERNALS_MODULES_LIST=		$(shell \
					$(EXTERNALS_DEPENDENCIES_COMMAND))

EXTERNALS_LIST=			$(addprefix \
					$(EXTERNALS_PREFIX) , \
					$(EXTERNALS_MODULES_LIST))
else
EXTERNALS_LIST=
endif

endif
