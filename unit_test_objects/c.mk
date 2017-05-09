ifndef MK_UNIT_TEST_OBJECTS_C_MK
MK_UNIT_TEST_OBJECTS_C_MK=		TRUE

INCLUDER_MODULES_LIST=			config \
					dirs \
					signature \
					unit_test_sources/c

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif


# TODO: merge into one variable: $(DIRS_OBJECTS_DIR)/$(PLATFORM)

UNIT_TEST_OBJECTS_C_EXT_SUFFIX=		$(UNIT_TEST_SOURCES_C_SUFFIX)_$(SIGNATURE_C_OBJECT_SUFFIX)
UNIT_TEST_OBJECTS_C_EXT_ENTRY_SUFFIX=	$(UNIT_TEST_SOURCES_C_ENTRY_SUFFIX).$(CONFIG_C_OBJECT_FILE_EXT)

ifeq ($(PLATFORM_COMPATIBLE_FLAG), TRUE)
UNIT_TEST_OBJECTS_C_LIST=	$(patsubst \
					$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_SOURCES_C_EXT_SUFFIX), \
					$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_$(UNIT_TEST_OBJECTS_C_EXT_SUFFIX), \
					$(UNIT_TEST_SOURCES_C_LIST))

UNIT_TEST_OBJECTS_C_ENTRY_FILE=	$(patsubst \
					$(DIRS_UNIT_TEST_DIR)/%_$(UNIT_TEST_SOURCES_C_EXT_ENTRY_SUFFIX), \
					$(DIRS_OBJECTS_DIR)/$(PLATFORM)/%_$(UNIT_TEST_OBJECTS_C_EXT_ENTRY_SUFFIX), \
					$(UNIT_TEST_SOURCES_C_ENTRY_FILE))
else
UNIT_TEST_OBJECTS_C_LIST=
UNIT_TEST_OBJECTS_C_ENTRY_FILE=
endif

endif
