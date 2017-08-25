ifndef MK_SELF_TEST_MK
MK_SELF_TEST_MK=			TRUE

INCLUDER_MODULES_LIST=			dirs \
					config \
					modules \
					applications

ifndef INCLUDER_PATH
$(error aosmake package is not installed in your OS!)
else
include $(INCLUDER_PATH)
endif

SELF_TEST_APPLICATIONS_SUFFIX=		$(CONFIG_APPLICATION_PREFIX)s
SELF_TEST_MODULES_SUFFIX=		$(CONFIG_MODULE_PREFIX)s
SELF_TEST_TOOLS_SUFFIX=			$(CONFIG_TOOL_PREFIX)s

# INFO: 
SELF_TEST_PREFIX=			$(CONFIG_SELF_TEST_RULE)
SELF_TEST_DEEP_PREFIX=			$(CONFIG_SELF_TEST_DEEP_RULE)
SELF_TEST_FULL_PREFIX=			$(CONFIG_SELF_TEST_FULL_RULE)

# INFO: 
SELF_TEST_APPLICATIONS_RULE=		$(SELF_TEST_PREFIX)_$(SELF_TEST_APPLICATIONS_SUFFIX)
SELF_TEST_APPLICATIONS_DEEP_RULE=	$(SELF_TEST_DEEP_PREFIX)_$(SELF_TEST_APPLICATIONS_SUFFIX)
SELF_TEST_APPLICATIONS_FULL_RULE=	$(SELF_TEST_FULL_PREFIX)_$(SELF_TEST_APPLICATIONS_SUFFIX)

# INFO: 
SELF_TEST_MODULES_RULE=			$(SELF_TEST_PREFIX)_$(SELF_TEST_MODULES_SUFFIX)
SELF_TEST_MODULES_DEEP_RULE=		$(SELF_TEST_DEEP_PREFIX)_$(SELF_TEST_MODULES_SUFFIX)
SELF_TEST_MODULES_FULL_RULE=		$(SELF_TEST_FULL_PREFIX)_$(SELF_TEST_MODULES_SUFFIX)

# INFO: 
SELF_TEST_TOOLS_RULE=			$(SELF_TEST_PREFIX)_$(SELF_TEST_TOOLS_SUFFIX)
SELF_TEST_TOOLS_DEEP_RULE=		$(SELF_TEST_DEEP_PREFIX)_$(SELF_TEST_TOOLS_SUFFIX)
SELF_TEST_TOOLS_FULL_RULE=		$(SELF_TEST_FULL_PREFIX)_$(SELF_TEST_TOOLS_SUFFIX)

# INFO: 
SELF_TEST_FILE_NAME=			$(SELF_TEST_PREFIX).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)

# INFO: 
SELF_TEST_FILE=				$(DIRS_BS_TEMP_DIR)/$(SELF_TEST_FILE_NAME)

# INFO: 
SELF_TEST_APPLICATIONS_FILE_NAME=	$(SELF_TEST_APPLICATIONS_RULE).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
SELF_TEST_MODULES_FILE_NAME=		$(SELF_TEST_MODULES_RULE).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)
SELF_TEST_TOOLS_FILE_NAME=		$(SELF_TEST_TOOLS_RULE).$(CONFIG_BUILD_SYSTEM_SCRIPT_EXT)

# INFO: 
SELF_TEST_APPLICATIONS_FILE=		$(DIRS_BS_TEMP_DIR)/$(SELF_TEST_APPLICATIONS_FILE_NAME)
SELF_TEST_MODULES_FILE=			$(DIRS_BS_TEMP_DIR)/$(SELF_TEST_MODULES_FILE_NAME)
SELF_TEST_TOOLS_FILE=			$(DIRS_BS_TEMP_DIR)/$(SELF_TEST_TOOLS_FILE_NAME)

# INFO: 
SELF_TEST_DEV_NULL_FILE=		/dev/null

SELF_TEST_BASE_FORMATER=		%s

SELF_TEST_DEEP_TAB_FORMATER=		\\t\\t%s
SELF_TEST_DEEP_TAB_NEW_LINE_FORMATER=	$(SELF_TEST_DEEP_TAB_FORMATER)\\n

SELF_TEST_RULE_FORMATER=		$(SELF_TEST_BASE_FORMATER)_$(SELF_TEST_BASE_FORMATER):

SELF_TEST_LOOP_FIRST_FORMATER=		\ %s\\n\\t\\t%s_%s\\n\\n
SELF_TEST_LOOP_SECOND_FORMATER=		$(SELF_TEST_RULE_FORMATER)\ \\\\\\n$(SELF_TEST_DEEP_TAB_NEW_LINE_FORMATER)

SELF_TEST_RULE_FIRST_FORMATER=		%s\\n$(SELF_TEST_DEEP_TAB_NEW_LINE_FORMATER)
SELF_TEST_RULE_DEEP_FORMATER=		%s\\n\\t$(SELF_TEST_DEEP_TAB_NEW_LINE_FORMATER)

SELF_TEST_CONDITION_FORMATER=		\\t%s\\n
SELF_TEST_CONDITION_BODY_FORMATER=	\\t\\t$(SELF_TEST_RULE_DEEP_FORMATER)
SELF_TEST_CONDITION_NOT_USED_MESSAGE=	'echo unused >> \'
SELF_TEST_CONDITION_USED_MESSAGE=	'echo used >> \'

SELF_TEST_MAKE_FORMATER=		\\t$(SELF_TEST_RULE_FIRST_FORMATER)
SELF_TEST_GENERIC_NEW_LINE_FORMATER=	\\t$(SELF_TEST_RULE_FIRST_FORMATER)$(SELF_TEST_DEEP_TAB_NEW_LINE_FORMATER)

SELF_TEST_DATE_FORMATER=		\\t$(SELF_TEST_RULE_FIRST_FORMATER)$(SELF_TEST_DEEP_TAB_NEW_LINE_FORMATER)

SELF_TEST_EOF_FORMATER=			\ \\\\\\n$(SELF_TEST_DEEP_TAB_NEW_LINE_FORMATER)\\n
SELF_TEST_DATE_FORMAT=			'+"%d-%m-%Y,%T,%Z," | tr -d "\n" >> \'

SELF_TEST_GREP_MATCH_PATTERN=		\^\\t''\\t$$*
SELF_TEST_GREP_FLAGS=			-m \
					1 \
					-P

$(SELF_TEST_FILE): \
		%: \
		$(SELF_TEST_APPLICATIONS_FILE)
	cp \
		$(SELF_TEST_DEV_NULL_FILE) \
		$*
	printf \
		$(SELF_TEST_RULE_FIRST_FORMATER) \
		'$$(CONFIG_SELF_TEST_RULE): \' \
		'$$(SELF_TEST_APPLICATIONS_RULE)' \
		>> \
		$*
	echo \
		>> \
		$*

$(SELF_TEST_APPLICATIONS_FILE): \
		%: \
		$(SELF_TEST_MODULES_FILE)
	cp \
		$(SELF_TEST_DEV_NULL_FILE) \
		$*
	printf \
		$(SELF_TEST_BASE_FORMATER) \
		'$$(SELF_TEST_APPLICATIONS_RULE):' \
		>> \
		$*
	for \
		$(CONFIG_APPLICATION_PREFIX) \
		in \
		$(APPLICATIONS_PLATFORMS_LIST); \
		do \
			printf \
				$(SELF_TEST_LOOP_FIRST_FORMATER) \
				'\' \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_APPLICATION_PREFIX) \
				>> \
				$*; \
			printf \
				$(SELF_TEST_LOOP_SECOND_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_APPLICATION_PREFIX) \
				'$$(SELF_TEST_PREFIX)_%:' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_DATE_FORMATER) \
				'date \' \
				$(SELF_TEST_DATE_FORMAT) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_GENERIC_NEW_LINE_FORMATER) \
				'echo \' \
				'$$*, >> \' \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_MAKE_FORMATER) \
				'make \' \
				'$$*' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_DATE_FORMATER) \
				'date \' \
				$(SELF_TEST_DATE_FORMAT) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_GENERIC_NEW_LINE_FORMATER) \
				'echo \' \
				'$$(CONFIG_CLEAN_DEEP_RULE)_$$*, >> \' \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_MAKE_FORMATER) \
				'make \' \
				'$$(CONFIG_CLEAN_DEEP_RULE)_$$*' \
				>> \
				$*; \
			echo \
				>> \
				$*; \
			printf \
				$(SELF_TEST_RULE_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_APPLICATION_PREFIX) \
				>> \
				$*; \
		done
	printf \
		$(SELF_TEST_EOF_FORMATER) \
		'$$(SELF_TEST_MODULES_RULE)' \
		>> \
		$*

$(SELF_TEST_MODULES_FILE): \
		%: \
		$(SELF_TEST_TOOLS_FILE)
	cp \
		$(SELF_TEST_DEV_NULL_FILE) \
		$*
	printf \
		$(SELF_TEST_BASE_FORMATER) \
		'$$(SELF_TEST_MODULES_RULE):' \
		>> \
		$*
	for \
		$(CONFIG_MODULE_PREFIX) \
		in \
		$(MODULES_PLATFORMS_LIST); \
		do \
			printf \
				$(SELF_TEST_LOOP_FIRST_FORMATER) \
				'\' \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_MODULE_PREFIX) \
				>> \
				$*; \
			printf \
				$(SELF_TEST_LOOP_SECOND_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_MODULE_PREFIX) \
				'$$(SELF_TEST_PREFIX)_%:' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_DATE_FORMATER) \
				'date \' \
				$(SELF_TEST_DATE_FORMAT) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_GENERIC_NEW_LINE_FORMATER) \
				'echo -n \' \
				'$$*, >> \' \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_FORMATER) \
				'if [ -z "$$(shell grep $(SELF_TEST_GREP_FLAGS) $(SELF_TEST_GREP_MATCH_PATTERN) $(DEPENDENCIES_FILE) | tr -d \\\)" ]; then \' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_BODY_FORMATER) \
				$(SELF_TEST_CONDITION_NOT_USED_MESSAGE) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT); \' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_FORMATER) \
				'else \' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_BODY_FORMATER) \
				$(SELF_TEST_CONDITION_USED_MESSAGE) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT); \' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_FORMATER) \
				'fi' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_MAKE_FORMATER) \
				'make \' \
				'$$*' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_DATE_FORMATER) \
				'date \' \
				$(SELF_TEST_DATE_FORMAT) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_GENERIC_NEW_LINE_FORMATER) \
				'echo \' \
				'$$(CONFIG_CLEAN_DEEP_RULE)_$$*, >> \' \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_MAKE_FORMATER) \
				'make \' \
				'$$(CONFIG_CLEAN_DEEP_RULE)_$$*' \
				>> \
				$*; \
			echo \
				>> \
				$*; \
			printf \
				$(SELF_TEST_RULE_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_MODULE_PREFIX) \
				>> \
				$*; \
		done
	printf \
		$(SELF_TEST_EOF_FORMATER) \
		'$$(SELF_TEST_TOOLS_RULE)' \
		>> \
		$*

$(SELF_TEST_TOOLS_FILE): \
		%: | \
		$(DIRS_BS_TEMP_DIR)
	cp \
		$(SELF_TEST_DEV_NULL_FILE) \
		$*
	printf \
		$(SELF_TEST_BASE_FORMATER) \
		'$$(SELF_TEST_TOOLS_RULE):' \
		>> \
		$*
	for \
		$(CONFIG_TOOL_PREFIX) \
		in \
		$(TOOLS_PLATFORMS_LIST); \
		do \
			printf \
				$(SELF_TEST_LOOP_FIRST_FORMATER) \
				'\' \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_TOOL_PREFIX) \
				>> \
				$*; \
			printf \
				$(SELF_TEST_LOOP_SECOND_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_TOOL_PREFIX) \
				'$$(SELF_TEST_PREFIX)_%:' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_DATE_FORMATER) \
				'date \' \
				$(SELF_TEST_DATE_FORMAT) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_GENERIC_NEW_LINE_FORMATER) \
				'echo -n \' \
				'$$*, >> \' \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_FORMATER) \
				'if [ -z "$$(shell grep $(SELF_TEST_GREP_FLAGS) $(SELF_TEST_GREP_MATCH_PATTERN) $(DEPENDENCIES_FILE) | tr -d \\\)" ]; then \' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_BODY_FORMATER) \
				$(SELF_TEST_CONDITION_NOT_USED_MESSAGE) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT); \' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_FORMATER) \
				'else \' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_BODY_FORMATER) \
				$(SELF_TEST_CONDITION_USED_MESSAGE) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT); \' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_CONDITION_FORMATER) \
				'fi' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_MAKE_FORMATER) \
				'make \' \
				'$$*' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_DATE_FORMATER) \
				'date \' \
				$(SELF_TEST_DATE_FORMAT) \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_GENERIC_NEW_LINE_FORMATER) \
				'echo \' \
				'$$(CONFIG_CLEAN_DEEP_RULE)_$$*, >> \' \
				'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
				>> \
				$*; \
			printf \
				$(SELF_TEST_MAKE_FORMATER) \
				'make \' \
				'$$(CONFIG_CLEAN_DEEP_RULE)_$$*' \
				>> \
				$*; \
			echo \
				>> \
				$*; \
			printf \
				$(SELF_TEST_RULE_FORMATER) \
				'$$(SELF_TEST_PREFIX)' \
				$$$(CONFIG_TOOL_PREFIX) \
				>> \
				$*; \
		done
	printf \
		$(SELF_TEST_LOOP_FIRST_FORMATER) \
		'\' \
		'$$(SELF_TEST_PREFIX)' \
		init \
		>> \
		$*; \
	printf \
		$(SELF_TEST_LOOP_SECOND_FORMATER) \
		'$$(SELF_TEST_PREFIX)' \
		init \
		'$$(SELF_TEST_PREFIX)_%:' \
		>> \
		$*; \
	printf \
		$(SELF_TEST_GENERIC_NEW_LINE_FORMATER) \
		'cp \' \
		'/dev/null \' \
		'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
		>> \
		$*
	printf \
		$(SELF_TEST_DATE_FORMATER) \
		'date \' \
		$(SELF_TEST_DATE_FORMAT) \
		'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
		>> \
		$*
	printf \
		$(SELF_TEST_GENERIC_NEW_LINE_FORMATER) \
		'echo \' \
		'$$(CONFIG_CLEAN_RULE), >> \' \
		'$$(SELF_TEST_PREFIX).$$(CONFIG_CSV_EXT)' \
		>> \
		$*
	printf \
		$(SELF_TEST_MAKE_FORMATER) \
		'make \' \
		'$$(CONFIG_CLEAN_RULE)' \
		>> \
		$*
	echo \
		>> \
		$*

include $(SELF_TEST_FILE)
include $(SELF_TEST_APPLICATIONS_FILE)
include $(SELF_TEST_MODULES_FILE)
include $(SELF_TEST_TOOLS_FILE)

endif

