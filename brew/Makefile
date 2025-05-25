.PHONY: install clean

BREWFILE := Brewfile

install:
	@command -v brew >/dev/null 2>&1 || { echo >&2 "Homebrew is not installed."; exit 1; }
	@echo "Running brew bundle from $(BREWFILE)..."
	brew bundle --file=$(BREWFILE)

clean:
	@echo "Uninstalling all packages from $(BREWFILE)..."
	brew bundle --file=$(BREWFILE) cleanup --force

