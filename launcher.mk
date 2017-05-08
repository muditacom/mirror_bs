ifndef MK_LAUNCHER_MK
MK_LAUNCHER_MK=				TRUE

INCLUDER_MODULES_LIST=			root

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

LAUNCHER_RELATIVE_ROOT_DIR=		../..

LAUNCHER_VARIABLES=			ROOT_DIR=$(ROOT_DIR) \
					RELATIVE_ROOT_DIR=$(LAUNCHER_RELATIVE_ROOT_DIR)

endif

