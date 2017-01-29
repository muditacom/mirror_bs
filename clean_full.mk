ifndef MK_CLEAN_FULL_MK
MK_CLEAN_FULL_MK=			TRUE

INCLUDER_MODULES_LIST=			config \
					clean

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

CLEAN_FULL_PREFIX=			$(CONFIG_CLEAN_FULL_RULE)

# TODO: APPLICATIONS vs APPLICATION - fix it
CLEAN_FULL_APPLICATIONS_PREFIX=		$(CLEAN_FULL_PREFIX)_$(CONFIG_APPLICATION_PREFIX)
CLEAN_FULL_MODULES_PREFIX=		$(CLEAN_FULL_PREFIX)_$(CONFIG_MODULE_PREFIX)
CLEAN_FULL_TOOLS_PREFIX=		$(CLEAN_FULL_PREFIX)_$(CONFIG_TOOL_PREFIX)

CLEAN_FULL_APPLICATIONS_STANDARD_LIST=	$(patsubst \
						$(CONFIG_CLEAN_RULE)_%, \
						$(CONFIG_CLEAN_FULL_RULE)_%, \
						$(CLEAN_APPLICATIONS_STANDARD_LIST))

CLEAN_FULL_APPLICATIONS_NONSTANDARD_LIST=	$(patsubst \
						$(CONFIG_CLEAN_RULE)_%, \
						$(CONFIG_CLEAN_FULL_RULE)_%, \
							$(CLEAN_APPLICATIONS_NONSTANDARD_LIST))

CLEAN_FULL_MODULES_STANDARD_LIST=	$(patsubst \
						$(CONFIG_CLEAN_RULE)_%, \
						$(CONFIG_CLEAN_FULL_RULE)_%, \
						$(CLEAN_MODULES_STANDARD_LIST))

CLEAN_FULL_MODULES_NONSTANDARD_LIST=	$(patsubst \
						$(CONFIG_CLEAN_RULE)_%, \
						$(CONFIG_CLEAN_FULL_RULE)_%, \
						$(CLEAN_MODULES_NONSTANDARD_LIST))

CLEAN_FULL_TOOLS_STANDARD_LIST=		$(patsubst \
						$(CONFIG_CLEAN_RULE)_%, \
						$(CONFIG_CLEAN_FULL_RULE)_%, \
						$(CLEAN_TOOLS_STANDARD_LIST))

CLEAN_FULL_TOOLS_NONSTANDARD_LIST=	$(patsubst \
						$(CONFIG_CLEAN_RULE)_%, \
						$(CONFIG_CLEAN_FULL_RULE)_%, \
						$(CLEAN_TOOLS_NONSTANDARD_LIST))

endif
