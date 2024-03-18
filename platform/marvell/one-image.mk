# sonic marvell one image installer

ifeq ($(CONFIGURED_ARCH),$(filter $(CONFIGURED_ARCH),arm64 armhf))
SONIC_ONE_IMAGE = sonic-marvell-$(CONFIGURED_ARCH).bin
else
SONIC_ONE_IMAGE = sonic-marvell.bin
endif
$(SONIC_ONE_IMAGE)_MACHINE = marvell
$(SONIC_ONE_IMAGE)_IMAGE_TYPE = onie
$(SONIC_ONE_IMAGE)_INSTALLS += $(SYSTEMD_SONIC_GENERATOR)
ifeq ($(CONFIGURED_ARCH),arm64)
$(SONIC_ONE_IMAGE)_INSTALLS += $(MRVL_PRESTERA_DEB)
$(SONIC_ONE_IMAGE)_LAZY_INSTALLS += $(NOKIA_7215_PLATFORM) \
				$(AC5X_RD98DX35xx_PLATFORM) \
				$(AC5X_RD98DX35xxCN9131_PLATFORM)
else ifeq ($(CONFIGURED_ARCH),armhf)
$(SONIC_ONE_IMAGE)_INSTALLS += $(MRVL_PRESTERA_DEB)
$(SONIC_ONE_IMAGE)_LAZY_INSTALLS += $(NOKIA_7215_PLATFORM)
else ifeq ($(CONFIGURED_ARCH),amd64)
$(SONIC_ONE_IMAGE)_LAZY_INSTALLS += $(AC5X_RD98DX35xx_PLATFORM)
endif
ifeq ($(INSTALL_DEBUG_TOOLS),y)
$(SONIC_ONE_IMAGE)_DOCKERS += $(SONIC_INSTALL_DOCKER_DBG_IMAGES)
$(SONIC_ONE_IMAGE)_DOCKERS += $(filter-out $(patsubst %-$(DBG_IMAGE_MARK).gz,%.gz, $(SONIC_INSTALL_DOCKER_DBG_IMAGES)), $(SONIC_INSTALL_DOCKER_IMAGES))
else
$(SONIC_ONE_IMAGE)_DOCKERS = $(SONIC_INSTALL_DOCKER_IMAGES)
endif
SONIC_INSTALLERS += $(SONIC_ONE_IMAGE)
