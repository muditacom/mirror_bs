ifndef MK_AWS_MK
MK_AWS_MK=				TRUE

INCLUDER_MODULES_LIST=			dirs \
					relative

ifndef INCLUDER_PATH
$(error tool modbuild is not installed in your build system!)
else
include $(INCLUDER_PATH)
endif

AWS_PROFILE_CI_NAME=			aws_ci
AWS_PROFILE_REPO_NAME=			aws_repo

AWS_COPY_DONE_SUFFIX=			copy_done
AWS_PREPARE_DONE_SUFFIX=		prepare_done
AWS_PACKAGES_DONE_SUFFIX=		packages_done
AWS_SCRIPTS_DONE_SUFFIX=		scripts_done
AWS_CLEAR_DONE_SUFFIX=			clear_done
AWS_REBOOT_DONE_SUFFIX=			reboot_done

AWS_SH_FILE_EXT=			sh

AWS_HOSTNAME_DNS_FILE_NAME=		hostname.dns
AWS_PEM_FILE_NAME=			arch-ci-mudita.pem
AWS_PACMAN_CONF_FILE_NAME=		pacman.conf

AWS_README_ASCIIDOC_FILE_NAME=		README.$(CONFIG_ASCIIDOC_FILE_EXT)

AWS_AIROOTFS_DIR_NAME=			airootfs
AWS_STEPS_DIR_NAME=			steps

AWS_REMOTE_USER_NAME=			root

AWS_ERROR_MESSAGE=			File \
					$@ \
					does \
					not \
					exist. \
					See \
					$(AWS_README_ASCIIDOC_FILE_NAME) \
					for \
					more \
					details.

AWS_HOSTNAME_DNS_FILE=			$(AWS_HOSTNAME_DNS_FILE_NAME)
AWS_PEM_FILE=				$(AWS_PEM_FILE_NAME)

AWS_PACMAN_LOCAL_CONF_FILE=		$(RELATIVE_ROOT_DIR)/.circleci/$(AWS_PACMAN_CONF_FILE_NAME)
AWS_PACMAN_REMOTE_CONF_FILE=		etc/$(AWS_PACMAN_CONF_FILE_NAME)

AWS_STEPS_DIR=				$(AWS_STEPS_DIR_NAME)

AWS_COPY_DONE_FILE_NAME_COMMAND=	cat \
						$(AWS_HOSTNAME_DNS_FILE)

AWS_REMOTE_HOST_NAME=			$(shell \
						$(AWS_COPY_DONE_FILE_NAME_COMMAND))

AWS_COPY_DONE_FILE_NAME=		$(AWS_REMOTE_HOST_NAME)_$(AWS_COPY_DONE_SUFFIX)
AWS_PREPARE_DONE_FILE_NAME=		$(AWS_REMOTE_HOST_NAME)_$(AWS_PREPARE_DONE_SUFFIX)
AWS_PACKAGES_DONE_FILE_NAME=		$(AWS_REMOTE_HOST_NAME)_$(AWS_PACKAGES_DONE_SUFFIX)
AWS_SCRIPTS_DONE_FILE_NAME=		$(AWS_REMOTE_HOST_NAME)_$(AWS_SCRIPTS_DONE_SUFFIX)
AWS_CLEAR_DONE_ORPHANS_FILE_NAME=	$(AWS_REMOTE_HOST_NAME)_$(AWS_CLEAR_DONE_SUFFIX)
AWS_REBOOT_DONE_FILE_NAME=		$(AWS_REMOTE_HOST_NAME)_$(AWS_REBOOT_DONE_SUFFIX)

AWS_COPY_DONE_FILE=			$(AWS_STEPS_DIR)/$(AWS_COPY_DONE_FILE_NAME)
AWS_PREPARE_DONE_FILE=			$(AWS_STEPS_DIR)/$(AWS_PREPARE_DONE_FILE_NAME)
AWS_PACKAGES_DONE_FILE=			$(AWS_STEPS_DIR)/$(AWS_PACKAGES_DONE_FILE_NAME)
AWS_SCRIPTS_DONE_FILE=			$(AWS_STEPS_DIR)/$(AWS_SCRIPTS_DONE_FILE_NAME)
AWS_CLEAR_DONE_ORPHANS_FILE=		$(AWS_STEPS_DIR)/$(AWS_CLEAR_DONE_ORPHANS_FILE_NAME)
AWS_REBOOT_DONE_FILE=			$(AWS_STEPS_DIR)/$(AWS_REBOOT_DONE_FILE_NAME)

AWS_REMOTE_USER_AT_HOST=		$(AWS_REMOTE_USER_NAME)@$(AWS_REMOTE_HOST_NAME)
AWS_REMOTE_USER_DIR=			$(AWS_REMOTE_USER_AT_HOST):/$(AWS_REMOTE_USER_NAME)
AWS_REMOTE_ROOT_DIR=			$(AWS_REMOTE_USER_AT_HOST):/

AWS_LIST_WITH_NO_COMMENTS_COMMAND=	grep \
						-h \
						-v \
						^\#

AWS_PROFILE_DIR=			$(DIRS_PULL_DIR)/profile
AWS_PATCH_DIR=				$(DIRS_PULL_DIR)/patch

AWS_PROFILE_CI_FILE_NAME=		$(AWS_PROFILE_CI_NAME).$(CONFIG_LIST_EXT)
AWS_PROFILE_REPO_FILE_NAME=		$(AWS_PROFILE_REPO_NAME).$(CONFIG_LIST_EXT)

AWS_PROFILE_CI_FILE=			$(AWS_PROFILE_DIR)/$(AWS_PROFILE_CI_FILE_NAME)
AWS_PROFILE_REPO_FILE=			$(AWS_PROFILE_DIR)/$(AWS_PROFILE_REPO_FILE_NAME)

AWS_GET_PATCH_CI_LIST_COMMAND=		$(AWS_LIST_WITH_NO_COMMENTS_COMMAND) \
						$(AWS_PROFILE_CI_FILE)

AWS_GET_PATCH_REPO_LIST_COMMAND=	$(AWS_LIST_WITH_NO_COMMENTS_COMMAND) \
						$(AWS_PROFILE_REPO_FILE)

AWS_SCP_COMMAND=			scp \
						-C \
						-i \
						$(AWS_PEM_FILE)

AWS_SSH_INIT_COMMAND=			ssh \
						-o \
						StrictHostKeyChecking=no \
						-i \
						$(AWS_PEM_FILE) \
						$(AWS_REMOTE_USER_AT_HOST) \
						true

AWS_SSH_COMMAND=			ssh \
						-C \
						-i \
						$(AWS_PEM_FILE) \
						$(AWS_REMOTE_USER_AT_HOST)

AWS_CHECK_REMOTE_MESSAGE=		This step is already done on $(AWS_REMOTE_HOST_NAME)

AWS_CHECK_REMOTE_LOCK_COMMAND=		$(AWS_SSH_COMMAND) \
						if \[ -e $@ \]\; then \
							echo $(AWS_CHECK_REMOTE_MESSAGE)\; \
							false\; \
						fi

endif

