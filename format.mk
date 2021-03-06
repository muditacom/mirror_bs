ifndef MK_FORMAT_MK
MK_FORMAT_MK=				TRUE

INCLUDER_MODULES_LIST=			config \
					modules \
					applications

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

FORMAT_PREFIX=				$(CONFIG_FORMAT_RULE)

FORMAT_APP_PREFIX=			$(FORMAT_PREFIX)_$(CONFIG_APPLICATION_PREFIX)
FORMAT_MOD_PREFIX=			$(FORMAT_PREFIX)_$(CONFIG_MODULE_PREFIX)

FORMAT_APP_STANDARD_LIST=		$(patsubst \
						$(CONFIG_APPLICATION_PREFIX)_%, \
						$(FORMAT_APP_PREFIX)_%, \
						$(APPLICATIONS_STANDARD_LIST))

FORMAT_APP_NONSTANDARD_LIST=		$(patsubst \
						$(CONFIG_APPLICATION_PREFIX)_%, \
						$(FORMAT_APP_PREFIX)_%, \
						$(APPLICATIONS_NONSTANDARD_LIST))

FORMAT_MOD_STANDARD_LIST=		$(patsubst \
						$(CONFIG_MODULE_PREFIX)_%, \
						$(FORMAT_MOD_PREFIX)_%, \
						$(MODULES_STANDARD_LIST))

FORMAT_MOD_NONSTANDARD_LIST=		$(patsubst \
						$(CONFIG_MODULE_PREFIX)_%, \
						$(FORMAT_MOD_PREFIX)_%, \
						$(MODULES_NONSTANDARD_LIST))

FORMAT_SOURCE_C_EXT_SUFFIX=		$(CONFIG_C_SOURCE_FILE_EXT).$(FORMAT_PREFIX)

FORMAT_SOURCES_C_LIST=			$(patsubst \
						$(DIRS_SOURCES_DIR)/%.$(CONFIG_C_SOURCE_FILE_EXT), \
						$(DIRS_SOURCES_DIR)/%.$(FORMAT_SOURCE_C_EXT_SUFFIX), \
						$(SOURCES_C_LIST))

FORMAT_SOURCES_LIST=			$(FORMAT_SOURCES_C_LIST)

FORMAT_SOURCES_EXISTING_LIST=		$(wildcard \
						$(FORMAT_SOURCES_C_LIST))

FORMAT_COMMAND=				uncrustify

FORMAT_CONFIGURATION_FILE_NAME=		$(FORMAT_COMMAND).$(CONFIG_CFG_EXT)
FORMAT_CONFIGURATION_FILE=		$(ROOT_DIR)/$(DIRS_TEMPLATES_DIR)/$(FORMAT_CONFIGURATION_FILE_NAME)

FORMAT_FLAGS=				-c \
					$(FORMAT_CONFIGURATION_FILE) \
					-f

# don't format switch
FORMAT_DNF_FILE=			dont_format_this

endif
