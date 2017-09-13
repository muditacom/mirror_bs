ifndef MK_CONFIG_MK
MK_CONFIG_MK=				TRUE

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

# INFO: Downolad repository via git
CONFIG_GITREPO_BRANCH_DEFAULT=		master

# INFO: Suffixes.
CONFIG_FULL_SUFFIX=			full
CONFIG_DEEP_SUFFIX=			deep

# INFO: Build rules.
CONFIG_ALL_RULE=			all

# INFO: Clean rules.
CONFIG_CLEAN_RULE=			clean
CONFIG_CLEAN_FULL_RULE=			$(CONFIG_CLEAN_RULE)_$(CONFIG_FULL_SUFFIX)
CONFIG_CLEAN_DEEP_RULE=			$(CONFIG_CLEAN_RULE)_$(CONFIG_DEEP_SUFFIX)

# INFO: Execute rules.
CONFIG_RUN_RULE=			run
CONFIG_DEBUG_RULE=			debug
CONFIG_CGDB_RULE=			cgdb

# INFO: Format rules.
CONFIG_FORMAT_RULE=			format

# INFO: Unit test rules.
CONFIG_UNIT_TEST_GEN_RULE=		$(CONFIG_UNIT_TEST_PREFIX)_gen
CONFIG_UNIT_TEST_BUILD_RULE=		$(CONFIG_UNIT_TEST_PREFIX)_build
CONFIG_UNIT_TEST_RUN_RULE=		$(CONFIG_UNIT_TEST_PREFIX)_run

# INFO: Sanity test rules.
CONFIG_SANITY_TEST_RULE=		sanity_test

# INFO: Documentation rules.
CONFIG_DOC_RULE=			doc

# INFO: Sources extensions.
CONFIG_ASM_SOURCE_FILE_EXT=		S
CONFIG_C_SOURCE_FILE_EXT=		c
CONFIG_CPP_SOURCE_FILE_EXT=		cpp

# INFO: Coverage extensions.
CONFIG_GCNO_FILE_EXT=			gcno
CONFIG_GCDA_FILE_EXT=			gcda
CONFIG_GCOV_FILE_EXT=			gcov
CONFIG_LCOV_FILE_EXT=			lcov

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
CONFIG_ARGS_EXT=			args
CONFIG_LIST_EXT=			list
# TODO: Not sure if needed
CONFIG_CFG_EXT=				cfg
CONFIG_CSV_EXT=				csv
CONFIG_GDB_SCRIPT_EXT=			gdb
CONFIG_GITREPO_EXT=			gitrepo

# INFO: File names.
CONFIG_DEPENDENCIES_FILE_NAME=		dependencies.$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_EXTERNALS_FILE_NAME=		externals.$(CONFIG_LIST_EXT)
CONFIG_DEFINES_FILE_NAME=		defines.$(CONFIG_LIST_EXT)
CONFIG_PLATFORMS_FILE_NAME=		platforms.$(CONFIG_LIST_EXT)
CONFIG_INCLUDES_FILE_NAME=		includes.$(CONFIG_LIST_EXT)
CONFIG_IGNORE_FILE_NAME=		ignore.$(CONFIG_LIST_EXT)
CONFIG_DO_NOT_TEST_FILE_NAME=		do_not_test.$(CONFIG_LIST_EXT)
CONFIG_ARGS_FILE_NAME=			default.$(CONFIG_ARGS_EXT)
CONFIG_IN_FLAGS_FILE_NAME=		in.$(CONFIG_LIST_EXT)
CONFIG_OUT_FLAGS_FILE_NAME=		out.$(CONFIG_LIST_EXT)

CONFIG_MODULE_DEP_FILE_NAME=		$(CONFIG_MODULE_PREFIX)s.$(CONFIG_DEP_EXT)
CONFIG_APPLICATION_DEP_FILE_NAME=	$(CONFIG_APPLICATION_PREFIX)s.$(CONFIG_DEP_EXT)
CONFIG_TOOL_DEP_FILE_NAME=		$(CONFIG_TOOL_PREFIX)s.$(CONFIG_DEP_EXT)

CONFIG_PULL_FILE_NAME=			pull.$(CONFIG_GITREPO_EXT)
CONFIG_PUSH_FILE_NAME=			push.$(CONFIG_GITREPO_EXT)

CONFIG_MTRACE_FILE_NAME=		mtrace
CONFIG_MAKEFILE_FILE_NAME=		Makefile

# INFO: Build templates.
CONFIG_DEFAULT_APPLICATION_BUILDSCRIPT_FILE_NAME=	$(CONFIG_APPLICATION_PREFIX).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_DEFAULT_MODULE_BUILDSCRIPT_FILE_NAME=		$(CONFIG_MODULE_PREFIX).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
CONFIG_DEFAULT_TOOL_BUILDSCRIPT_FILE_NAME=		$(CONFIG_TOOL_PREFIX).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)

endif

