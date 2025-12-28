#!/bin/bash

# ============================================================================
# Automated Test Script for Assembly Encryption Program
# ============================================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test files
TEST_INPUT="test_input.txt"
TEST_ENCRYPTED="test_encrypted.txt"
TEST_DECRYPTED="test_decrypted.txt"
TEST_KEY="TestKey123"

# Counters
TESTS_PASSED=0
TESTS_FAILED=0
TOTAL_TESTS=0

# ============================================================================
# Helper Functions
# ============================================================================

print_header() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════════╗"
    echo "║        Automated Testing Suite             ║"
    echo "╚════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_test() {
    ((TOTAL_TESTS++))
    echo -e "${YELLOW}[TEST $TOTAL_TESTS]${NC} $1"
}

print_success() {
    ((TESTS_PASSED++))
    echo -e "${GREEN}[✓ PASS]${NC} $1"
}

print_failure() {
    ((TESTS_FAILED++))
    echo -e "${RED}[✗ FAIL]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_summary() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "${BLUE}Test Summary:${NC}"
    echo -e "  Total Tests:  $TOTAL_TESTS"
    echo -e "  ${GREEN}Passed:       $TESTS_PASSED${NC}"
    echo -e "  ${RED}Failed:       $TESTS_FAILED${NC}"
    
    if [ $TESTS_FAILED -eq 0 ]; then
        echo -e "${GREEN}"
        echo "╔════════════════════════════════════════════════╗"
        echo "║          ALL TESTS PASSED! 🎉              ║"
        echo "╚════════════════════════════════════════════════╝"
        echo -e "${NC}"
        return 0
    else
        echo -e "${RED}"
        echo "╔════════════════════════════════════════════════╗"
        echo "║          SOME TESTS FAILED ❌              ║"
        echo "╚════════════════════════════════════════════════╝"
        echo -e "${NC}"
        return 1
    fi
}

cleanup() {
    rm -f $TEST_ENCRYPTED $TEST_DECRYPTED
}

# ============================================================================
# Test Functions
# ============================================================================

test_program_exists() {
    print_test "Checking if encryption program exists"
    
    if [ -f "./encryption" ]; then
        print_success "Program file found"
        return 0
    else
        print_failure "Program file not found. Run 'make' first!"
        return 1
    fi
}

test_program_executable() {
    print_test "Checking if program is executable"
    
    if [ -x "./encryption" ]; then
        print_success "Program is executable"
        return 0
    else
        print_failure "Program is not executable"
        return 1
    fi
}

test_input_file_exists() {
    print_test "Checking test input file"
    
    if [ -f "$TEST_INPUT" ]; then
        print_success "Test input file exists"
        print_info "File size: $(wc -c < $TEST_INPUT) bytes"
        return 0
    else
        print_failure "Test input file not found"
        return 1
    fi
}

test_encryption() {
    print_test "Testing file encryption"
    
    # Create encryption script
    cat > encrypt_test.exp << EOF
#!/usr/bin/expect -f
set timeout 10

spawn ./encryption

expect "Your choice:"
send "1\r"

expect "Enter input file path:"
send "$TEST_INPUT\r"

expect "Enter output file path:"
send "$TEST_ENCRYPTED\r"

expect "Enter encryption key"
send "$TEST_KEY\r"

expect {
    "successfully" {
        exit 0
    }
    timeout {
        exit 1
    }
}
EOF
    
    chmod +x encrypt_test.exp
    
    if command -v expect > /dev/null; then
        if ./encrypt_test.exp > /dev/null 2>&1; then
            if [ -f "$TEST_ENCRYPTED" ]; then
                print_success "Encryption completed, output file created"
                print_info "Encrypted file size: $(wc -c < $TEST_ENCRYPTED) bytes"
                rm encrypt_test.exp
                return 0
            else
                print_failure "Output file not created"
                rm encrypt_test.exp
                return 1
            fi
        else
            print_failure "Encryption failed"
            rm encrypt_test.exp
            return 1
        fi
    else
        print_info "Expect not installed, using manual test"
        print_info "Please run: echo -e '1\n$TEST_INPUT\n$TEST_ENCRYPTED\n$TEST_KEY\n4' | ./encryption"
        return 0
    fi
}

test_decryption() {
    print_test "Testing file decryption"
    
    if [ ! -f "$TEST_ENCRYPTED" ]; then
        print_failure "Encrypted file not found, skipping decryption test"
        return 1
    fi
    
    # Create decryption script
    cat > decrypt_test.exp << EOF
#!/usr/bin/expect -f
set timeout 10

spawn ./encryption

expect "Your choice:"
send "2\r"

expect "Enter input file path:"
send "$TEST_ENCRYPTED\r"

expect "Enter output file path:"
send "$TEST_DECRYPTED\r"

expect "Enter encryption key"
send "$TEST_KEY\r"

expect {
    "successfully" {
        exit 0
    }
    timeout {
        exit 1
    }
}
EOF
    
    chmod +x decrypt_test.exp
    
    if command -v expect > /dev/null; then
        if ./decrypt_test.exp > /dev/null 2>&1; then
            if [ -f "$TEST_DECRYPTED" ]; then
                print_success "Decryption completed, output file created"
                print_info "Decrypted file size: $(wc -c < $TEST_DECRYPTED) bytes"
                rm decrypt_test.exp
                return 0
            else
                print_failure "Decrypted file not created"
                rm decrypt_test.exp
                return 1
            fi
        else
            print_failure "Decryption failed"
            rm decrypt_test.exp
            return 1
        fi
    else
        print_info "Expect not installed, using manual test"
        print_info "Please run: echo -e '2\n$TEST_ENCRYPTED\n$TEST_DECRYPTED\n$TEST_KEY\n4' | ./encryption"
        return 0
    fi
}

test_file_integrity() {
    print_test "Verifying file integrity (original vs decrypted)"
    
    if [ ! -f "$TEST_DECRYPTED" ]; then
        print_failure "Decrypted file not found, skipping integrity test"
        return 1
    fi
    
    if diff -q "$TEST_INPUT" "$TEST_DECRYPTED" > /dev/null; then
        print_success "Files match perfectly! Encryption/Decryption working correctly"
        return 0
    else
        print_failure "Files don't match! There might be an issue"
        print_info "Showing differences:"
        diff "$TEST_INPUT" "$TEST_DECRYPTED"
        return 1
    fi
}

test_encrypted_differs() {
    print_test "Verifying that encrypted file differs from original"
    
    if [ ! -f "$TEST_ENCRYPTED" ]; then
        print_failure "Encrypted file not found"
        return 1
    fi
    
    if diff -q "$TEST_INPUT" "$TEST_ENCRYPTED" > /dev/null; then
        print_failure "Encrypted file is same as original! Encryption not working"
        return 1
    else
        print_success "Encrypted file differs from original (as expected)"
        return 0
    fi
}

test_wrong_key() {
    print_test "Testing decryption with wrong key"
    
    WRONG_KEY_OUTPUT="test_wrong_key.txt"
    
    cat > wrong_key_test.exp << EOF
#!/usr/bin/expect -f
set timeout 10

spawn ./encryption

expect "Your choice:"
send "2\r"

expect "Enter input file path:"
send "$TEST_ENCRYPTED\r"

expect "Enter output file path:"
send "$WRONG_KEY_OUTPUT\r"

expect "Enter encryption key"
send "WrongKey999\r"

expect {
    "successfully" {
        exit 0
    }
    timeout {
        exit 1
    }
}
EOF
    
    chmod +x wrong_key_test.exp
    
    if command -v expect > /dev/null; then
        if ./wrong_key_test.exp > /dev/null 2>&1; then
            if [ -f "$WRONG_KEY_OUTPUT" ]; then
                if diff -q "$TEST_INPUT" "$WRONG_KEY_OUTPUT" > /dev/null; then
                    print_failure "Wrong key produced correct output (security issue!)"
                    rm wrong_key_test.exp $WRONG_KEY_OUTPUT
                    return 1
                else
                    print_success "Wrong key produced different output (correct behavior)"
                    rm wrong_key_test.exp $WRONG_KEY_OUTPUT
                    return 0
                fi
            fi
        fi
    else
        print_info "Expect not installed, skipping wrong key test"
        return 0
    fi
    
    rm -f wrong_key_test.exp $WRONG_KEY_OUTPUT
}

# ============================================================================
# Main Test Execution
# ============================================================================

main() {
    print_header
    
    echo ""
    print_info "Starting automated tests..."
    echo ""
    
    # Cleanup before tests
    cleanup
    
    # Run tests
    test_program_exists || exit 1
    test_program_executable || exit 1
    test_input_file_exists || exit 1
    
    echo ""
    print_info "Running encryption/decryption tests..."
    echo ""
    
    test_encryption
    test_encrypted_differs
    test_decryption
    test_file_integrity
    test_wrong_key
    
    echo ""
    
    # Cleanup after tests
    cleanup
    
    # Show summary
    print_summary
    
    exit $?
}

# ============================================================================
# Run main function
# ============================================================================

main