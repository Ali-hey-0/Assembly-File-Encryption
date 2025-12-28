# ============================================================================
# Makefile for Assembly File Encryption Program
# ============================================================================

# Compiler and Linker
ASM = nasm
LD = ld

# Flags
ASMFLAGS = -f elf64 -g -F dwarf
LDFLAGS = 

# Files
TARGET = encryption
SOURCE = encryption.asm
OBJECT = encryption.o

# Test files
TEST_INPUT = test_input.txt
TEST_ENCRYPTED = test_encrypted.txt
TEST_DECRYPTED = test_decrypted.txt

# Colors for output
COLOR_RESET = \033[0m
COLOR_GREEN = \033[32m
COLOR_BLUE = \033[34m
COLOR_YELLOW = \033[33m
COLOR_RED = \033[31m

# ============================================================================
# Main targets
# ============================================================================

all: banner $(TARGET) success

$(TARGET): $(OBJECT)
	@echo "$(COLOR_BLUE)🔗 Linking object files...$(COLOR_RESET)"
	@$(LD) $(LDFLAGS) $(OBJECT) -o $(TARGET)

$(OBJECT): $(SOURCE)
	@echo "$(COLOR_BLUE)🔨 Assembling source code...$(COLOR_RESET)"
	@$(ASM) $(ASMFLAGS) $(SOURCE) -o $(OBJECT)

# ============================================================================
# Utility targets
# ============================================================================

banner:
	@echo "$(COLOR_GREEN)"
	@echo "╔════════════════════════════════════════════════╗"
	@echo "║     Assembly Encryption - Build System     ║"
	@echo "╚════════════════════════════════════════════════╝"
	@echo "$(COLOR_RESET)"

success:
	@echo ""
	@echo "$(COLOR_GREEN)✅ Build completed successfully!$(COLOR_RESET)"
	@echo "$(COLOR_YELLOW)📝 Run with: ./$(TARGET)$(COLOR_RESET)"
	@echo ""

clean:
	@echo "$(COLOR_YELLOW)🧹 Cleaning build files...$(COLOR_RESET)"
	@rm -f $(OBJECT) $(TARGET)
	@rm -f $(TEST_ENCRYPTED) $(TEST_DECRYPTED)
	@echo "$(COLOR_GREEN)✅ Clean completed$(COLOR_RESET)"

run: $(TARGET)
	@echo "$(COLOR_BLUE)🚀 Running program...$(COLOR_RESET)"
	@echo ""
	@./$(TARGET)

# ============================================================================
# Testing targets
# ============================================================================

test: $(TARGET) create-test-file
	@echo "$(COLOR_BLUE)🧪 Running automated tests...$(COLOR_RESET)"
	@echo ""
	@./test.sh

create-test-file:
	@echo "$(COLOR_YELLOW)📝 Creating test file...$(COLOR_RESET)"
	@echo "This is a test message for encryption." > $(TEST_INPUT)
	@echo "It contains multiple lines." >> $(TEST_INPUT)
	@echo "Hello from Assembly!" >> $(TEST_INPUT)
	@echo "$(COLOR_GREEN)✅ Test file created: $(TEST_INPUT)$(COLOR_RESET)"

# ============================================================================
# Debug targets
# ============================================================================

debug: ASMFLAGS += -g -F dwarf
debug: clean $(TARGET)
	@echo "$(COLOR_BLUE)🐛 Debug build completed$(COLOR_RESET)"

gdb: debug
	@echo "$(COLOR_BLUE)🐛 Starting GDB debugger...$(COLOR_RESET)"
	@gdb ./$(TARGET)

# ============================================================================
# Installation targets
# ============================================================================

install: $(TARGET)
	@echo "$(COLOR_BLUE)📦 Installing to /usr/local/bin...$(COLOR_RESET)"
	@sudo cp $(TARGET) /usr/local/bin/
	@sudo chmod +x /usr/local/bin/$(TARGET)
	@echo "$(COLOR_GREEN)✅ Installation completed$(COLOR_RESET)"

uninstall:
	@echo "$(COLOR_YELLOW)🗑️  Uninstalling...$(COLOR_RESET)"
	@sudo rm -f /usr/local/bin/$(TARGET)
	@echo "$(COLOR_GREEN)✅ Uninstallation completed$(COLOR_RESET)"

# ============================================================================
# Information targets
# ============================================================================

info:
	@echo "$(COLOR_BLUE)ℹ️  Project Information:$(COLOR_RESET)"
	@echo ""
	@echo "  Program:    $(TARGET)"
	@echo "  Source:     $(SOURCE)"
	@echo "  Object:     $(OBJECT)"
	@echo "  Assembler:  $(ASM)"
	@echo "  Linker:     $(LD)"
	@echo ""
	@echo "$(COLOR_YELLOW)Available targets:$(COLOR_RESET)"
	@echo "  make          - Build the project"
	@echo "  make clean    - Remove build files"
	@echo "  make run      - Build and run"
	@echo "  make test     - Run automated tests"
	@echo "  make debug    - Build with debug symbols"
	@echo "  make gdb      - Build and start GDB"
	@echo "  make install  - Install to system"
	@echo "  make info     - Show this information"
	@echo ""

size: $(TARGET)
	@echo "$(COLOR_BLUE)📊 Binary size information:$(COLOR_RESET)"
	@size $(TARGET)
	@echo ""
	@ls -lh $(TARGET)

# ============================================================================
# Help target
# ============================================================================

help: info

# ============================================================================
# Phony targets (not actual files)
# ============================================================================

.PHONY: all clean run test create-test-file debug gdb install uninstall info help banner success size

# ============================================================================
# Default target
# ============================================================================

.DEFAULT_GOAL := all