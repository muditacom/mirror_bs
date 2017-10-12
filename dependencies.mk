ifndef MK_DEPENDENCIES_MK
MK_DEPENDENCIES_MK=		TRUE

INCLUDER_MODULES_LIST=		dirs \
				config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

DEPENDENCIES_FILE=		$(DIRS_BS_TEMP_DIR)/$(CONFIG_DEPENDENCIES_FILE_NAME)
DEPENDENCIES_APPLICATION_NAME=	smart_deps
DEPENDENCIES_GREP_PREFIX=	-e

DEPENDENCIES_SEARCH_DIRS_LIST=	$(DIRS_APPLICATIONS_DIR) \
				$(DIRS_MODULES_DIR) \
				$(DIRS_TOOLS_DIR)

DEPENDENCIES_GREP_PATTERN_LIST=	$(CONFIG_MODULE_DEP_FILE_NAME) \
				$(CONFIG_APPLICATION_DEP_FILE_NAME) \
				$(CONFIG_TOOL_DEP_FILE_NAME)

DEPENDENCIES_GREP_PATTERN=	$(addprefix \
					$(DEPENDENCIES_GREP_PREFIX), \
					$(DEPENDENCIES_GREP_PATTERN_LIST))

DEPENDENCIES_LIST_COMMAND=	find \
					$(DEPENDENCIES_SEARCH_DIRS_LIST) \
					-type \
					f \
					-name \
					\*.$(CONFIG_DEP_EXT) | \
				grep \
					$(DEPENDENCIES_GREP_PATTERN)

DEPENDENCIES_LIST=		$(shell \
					$(DEPENDENCIES_LIST_COMMAND))

$(DEPENDENCIES_FILE): \
		$(DEPENDENCIES_LIST) | \
		$(DIRS_BS_TEMP_DIR)
	$(DEPENDENCIES_APPLICATION_NAME) > \
	$@

include $(DEPENDENCIES_FILE)

endif

