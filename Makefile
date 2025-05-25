UNAME_S := $(shell uname -s)

# Find all directories except 'fonts' in the current directory
COMMON_PACKAGES := $(filter-out fonts,$(shell find . -mindepth 1 -maxdepth 1 -type d -exec basename {} \;))

# macOS-specific packages
MACOS_PACKAGES := vscode

.PHONY: all install uninstall clean

all: install

install:
	@echo "🔗 Installing dotfiles (excluding fonts)..."
	stow $(COMMON_PACKAGES)
ifeq ($(UNAME_S), Darwin)
	@echo "🍏 macOS detected – installing macOS-specific dotfiles..."
	stow $(MACOS_PACKAGES)
endif
	@echo "📦 Running unified install script..."
	./install.sh
	@echo "✅ Installation complete."

uninstall:
	@echo "🚫 Unstowing dotfiles (excluding fonts)..."
	stow -D $(COMMON_PACKAGES)
ifeq ($(UNAME_S), Darwin)
	@echo "🍏 macOS detected – unstowing macOS-specific dotfiles..."
	stow -D $(MACOS_PACKAGES)
endif
	@echo "✅ Uninstallation complete."

clean:
	@echo "🧼 Cleaning system junk files..."
	find . -name ".DS_Store" -delete
	find . -name "*~" -delete
ifeq ($(UNAME_S), Darwin)
	@echo "🍺 Running brew clean from brew/Makefile..."
	$(MAKE) -C brew clean
endif
	@echo "✨ Cleanup done."

