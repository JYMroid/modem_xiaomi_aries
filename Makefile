OUT = build
RADIO_IMG = $(OUT)/radio.img
RADIO_IMG_SIZE = 174080
OUT_FIRMWARE = $(OUT)/firmware
OUT_FIRMWARE_IMAGE = $(OUT_FIRMWARE)/image

clean:
	rm -Rf $(OUT)

firmware:
	mkdir -p $(OUT_FIRMWARE_IMAGE)
	./scripts/copy_files $(OUT_FIRMWARE_IMAGE)

.PHONY: firmware
image: firmware
	rm -f $(RADIO_IMG)
	dd if=/dev/zero of=$(RADIO_IMG) bs=512 count=$(RADIO_IMG_SIZE)
	mkdosfs -F16 $(RADIO_IMG)
	mcopy -i $(RADIO_IMG) $(OUT_FIRMWARE_IMAGE) ::/
