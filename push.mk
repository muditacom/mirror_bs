ifndef MK_PUSH_MK
MK_PUSH_MK=			TRUE

INCLUDER_MODULES_LIST=		config

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

PUSH_BRANCH_DEFAULT=		$(CONFIG_GITREPO_BRANCH_DEFAULT)

PUSH_GITREPO_EXISTENCE=		$(wildcard \
					$(CONFIG_PUSH_FILE_NAME))
ifneq ($(PUSH_GITREPO_EXISTENCE), )
PUSH_GITREPO_CONTENT_COMMAND=	cat \
					$(CONFIG_PUSH_FILE_NAME)

PUSH_GITREPO_CONTENT=		$(shell \
					$(PUSH_GITREPO_CONTENT_COMMAND))

PUSH_GITREPO_CONTENT_WORDS=	$(words \
					$(PUSH_GITREPO_CONTENT))

ifneq ($(PUSH_GITREPO_CONTENT_WORDS), 1)
ifneq ($(PUSH_GITREPO_CONTENT_WORDS), 2)
$(error $(CONFIG_PUSH_FILE_NAME) syntax mismatch)
else
PUSH_REPO_URL=			$(word \
					1, \
					$(PUSH_GITREPO_CONTENT))

PUSH_REPO_BRANCH=		$(word \
					2, \
					$(PUSH_GITREPO_CONTENT))
endif
else
PUSH_REPO_URL=			$(PUSH_GITREPO_CONTENT)
PUSH_REPO_BRANCH=		$(PUSH_BRANCH_DEFAULT)
endif
else
PUSH_REPO_URL=
PUSH_REPO_BRANCH=
endif

endif
