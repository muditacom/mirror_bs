ifndef MK_TRANSFER_MK
MK_TRANSFER_MK=				TRUE


INCLUDER_MODULES_LIST=			config \
					dirs

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

# TODO: Should be implemented some mechanism, to watch if only h are in
#       transfer header file and only c is in transfer source file.

TRANSFER_PREFIX=			transfer

TRANSFER_ITERATOR=			file_to_transfer

TRANSFER_SRC_FILE_NAME=			$(TRANSFER_PREFIX)_$(DIRS_SOURCES_DIR).$(CONFIG_LIST_EXT)
TRANSFER_INCLUDES_FILE_NAME=		$(TRANSFER_PREFIX)_$(DIRS_INCLUDE_DIR).$(CONFIG_LIST_EXT)

TRANSFER_SRC_LIST_COMMAND=		cat \
						$(TRANSFER_SRC_FILE_NAME)

TRANSFER_INCLUDES_LIST_COMMAND=		cat \
						$(TRANSFER_INCLUDES_FILE_NAME)

TRANSFER_SRC_SED_PATTERN=		s/^.*/$(DIRS_SOURCES_DIR)\\/\&/

TRANSFER_INCLUDES_SED_PATTERN=		s/^.*/$(DIRS_INCLUDE_DIR)\\/\&/

TRANSFER_SRC_SED_COMMAND=		sed \
						$(TRANSFER_SRC_SED_PATTERN)

TRANSFER_INCLUDES_SED_COMMAND=		sed \
						$(TRANSFER_INCLUDES_SED_PATTERN)

TRANSFER_CONDITION_COMMAND=		if [ ! -e $(REPO_DIR)/$$$(TRANSFER_ITERATOR) ]; then \
						echo \
							$(TRANSFER_ERROR_MESSAGE); \
						exit 1; \
					fi

TRANSFER_MKDIR_SRC_COMMAND=		dirname \
						$$$(TRANSFER_ITERATOR) | \
					$(TRANSFER_SRC_SED_COMMAND) | \
					xargs \
						mkdir \
						-p

TRANSFER_MKDIR_INC_COMMAND=		dirname \
						$$$(TRANSFER_ITERATOR) | \
					$(TRANSFER_INCLUDES_SED_COMMAND) | \
					xargs \
						mkdir \
						-p

TRANSFER_CP_SRC_COMMAND=		echo \
						$$$(TRANSFER_ITERATOR) | \
					$(TRANSFER_SRC_SED_COMMAND) | \
					xargs \
						cp \
						-f \
						$(REPO_DIR)/$$$(TRANSFER_ITERATOR)

TRANSFER_CP_INC_COMMAND=		echo \
						$$$(TRANSFER_ITERATOR) | \
					$(TRANSFER_INCLUDES_SED_COMMAND) | \
					xargs \
						cp \
						-f \
						$(REPO_DIR)/$$$(TRANSFER_ITERATOR)

TRANSFER_LOOP_BODY_SRC_COMMAND=		while read $(TRANSFER_ITERATOR); do \
						$(TRANSFER_CONDITION_COMMAND); \
						$(TRANSFER_MKDIR_SRC_COMMAND); \
						$(TRANSFER_CP_SRC_COMMAND); \
					done

TRANSFER_LOOP_BODY_INC_COMMAND=		while read $(TRANSFER_ITERATOR); do \
						$(TRANSFER_CONDITION_COMMAND); \
						$(TRANSFER_MKDIR_INC_COMMAND); \
						$(TRANSFER_CP_INC_COMMAND); \
					done

TRANSFER_SOURCES_COMMAND=		$(TRANSFER_SRC_LIST_COMMAND) | \
					$(TRANSFER_LOOP_BODY_SRC_COMMAND)


TRANSFER_INCLUDES_COMMAND=		$(TRANSFER_INCLUDES_LIST_COMMAND) | \
					$(TRANSFER_LOOP_BODY_INC_COMMAND)

TRANSFER_ERROR_MESSAGE=			File \
					$(REPO_DIR)/$$$(TRANSFER_ITERATOR) \
					from \
					$(TRANSFER_SRC_FILE_NAME) \
					was \
					not \
					found

endif
