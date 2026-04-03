SRCS = $(wildcard Sources/*.swift)
OUT = Menu
SWIFTC = swiftc

ifndef NIX_BUILD_TOP
	export DEVELOPER_DIR=/Library/Developer/CommandLineTools
	SDK_FLAGS = -sdk /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
	SWIFTC = /usr/bin/swiftc
endif

$(OUT): $(SRCS)
	$(SWIFTC) -Onone -g $(SDK_FLAGS) -framework Cocoa \
		-o $(OUT) $(SRCS)

release: $(SRCS)
	$(SWIFTC) -O $(SDK_FLAGS) -framework Cocoa \
		-o $(OUT) $(SRCS)

clean:
	rm -rf $(OUT)
