ifndef MK_CONFIG_MK
MK_CONFIG_MK=			TRUE

# TODO: Prefixes are distributed - sum them up in this place.
# INFO: Prefixes.
CONFIG_MODULE_PREFIX=			module
CONFIG_APPLICATION_PREFIX=		application
CONFIG_TOOL_PREFIX=			tool
CONFIG_DOT_PREFIX=			dot
CONFIG_PNG_PREFIX=			png
CONFIG_LIB_PREFIX=			lib
CONFIG_UNIT_TEST_PREFIX=		unit_test

# INFO: 
CONFIG_GDB_HOST=			localhost
CONFIG_GDB_PORT=			9000

# INFO: Suffixes.
CONFIG_FULL_SUFFIX=			full

# INFO: Base rules.
CONFIG_ALL_RULE=			all
CONFIG_CLEAN_RULE=			clean
CONFIG_RUN_RULE=			run
CONFIG_DEBUG_RULE=			debug
CONFIG_CGDB_RULE=			cgdb
CONFIG_FORMAT_RULE=			format
CONFIG_UNIT_TEST_GEN_RULE=		$(CONFIG_UNIT_TEST_PREFIX)_gen
CONFIG_UNIT_TEST_BUILD_RULE=		$(CONFIG_UNIT_TEST_PREFIX)_build
CONFIG_UNIT_TEST_RUN_RULE=		$(CONFIG_UNIT_TEST_PREFIX)_run
CONFIG_CLEAN_FULL_RULE=			$(CONFIG_CLEAN_RULE)_$(CONFIG_FULL_SUFFIX)

# INFO: Source extensions.
CONFIG_ASM_SOURCE_FILE_EXT=		S
CONFIG_C_SOURCE_FILE_EXT=		c
CONFIG_CPP_SOURCE_FILE_EXT=		cpp

# INFO: Object extensions.
CONFIG_ASM_OBJECT_FILE_EXT=		objs
CONFIG_C_OBJECT_FILE_EXT=		objc
CONFIG_CPP_OBJECT_FILE_EXT=		objcpp

# INFO: Documentation extensions.
CONFIG_ASCIIDOC_FILE_EXT=		asciidoc
CONFIG_HTML_FILE_EXT=			html
CONFIG_LATEX_FILE_EXT=			latex
CONFIG_PDF_FILE_EXT=			pdf
CONFIG_DOT_FILE_EXT=			dot
CONFIG_PNG_FILE_EXT=			png

# INFO: Archive extensions.
CONFIG_STATIC_LIBRARY_EXT=		a

# INFO: Build system extensions.
CONFIG_LD_EXT=				ld
CONFIG_MAP_EXT=				map
CONFIG_BUILD_SYSTEM_SCRIPT_EXT=		mk
CONFIG_AUX_EXT=				aux
CONFIG_DEP_EXT=				dep
CONFIG_DEP_EXT=				dep
CONFIG_ARGS_EXT=			args
CONFIG_LIST_EXT=			list
CONFIG_CFG_EXT=				cfg
CONFIG_GDB_SCRIPT_EXT=			gdb

# INFO: File names.
CONFIG_DEPENDENCIES_FILE_NAME=		dependencies.$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_EXTERNALS_FILE_NAME=		externals.$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_PLATFORMS_FILE_NAME=		platforms.$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_GDB_SCRIPT_FILE_NAME=		script.$(CONFIG_GDB_SCRIPT_EXT)
CONFIG_ARGS_FILE_NAME=			default.$(CONFIG_ARGS_EXT)
CONFIG_IN_FLAGS_FILE_NAME=		in.$(CONFIG_LIST_EXT)
CONFIG_OUT_FLAGS_FILE_NAME=		out.$(CONFIG_LIST_EXT)

CONFIG_MODULE_DEP_FILE_NAME=		$(CONFIG_MODULE_PREFIX)s.$(CONFIG_DEP_EXT)
CONFIG_APPLICATION_DEP_FILE_NAME=	$(CONFIG_APPLICATION_PREFIX)s.$(CONFIG_DEP_EXT)
CONFIG_TOOL_DEP_FILE_NAME=		$(CONFIG_TOOL_PREFIX)s.$(CONFIG_DEP_EXT)

CONFIG_MTRACE_FILE_NAME=		mtrace
CONFIG_MAKEFILE_FILE_NAME=		Makefile
CONFIG_SELF_TEST_FILE_NAME=		self_test

# INFO: Download mechanism.
CONFIG_DOWNLOAD_FILE_NAME=		download.git

# INFO: Build templates.
CONFIG_DEFAULT_APPLICATION_BUILDSCRIPT_FILE_NAME=	$(CONFIG_APPLICATION_PREFIX).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_DEFAULT_MODULE_BUILDSCRIPT_FILE_NAME=		$(CONFIG_MODULE_PREFIX).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_DEFAULT_TOOL_BUILDSCRIPT_FILE_NAME=		$(CONFIG_TOOL_PREFIX).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_DEFAULT_DOWNLOAD_BUILDSCRIPT_FILE_NAME=		download.$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)

# INFO: Miscellaneous.
CONFIG_WATCH_LINES=			50
CONFIG_WATCH_INTERVAL=			1

# INFO: Development directory.
CONFIG_PUPNP_DIR_NAME=			pupnp
CONFIG_PUPNP_DIR=			$(CONFIG_PUPNP_DIR_NAME)

endif

