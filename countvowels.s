        .data
filename:   .asciiz "book.txt"        # use a full path if MARS can't find it
msg:        .asciiz "vowels: "
err_msg:    .asciiz "could not open file\n"
            .align 2
buffer:     .space 4096

        .text
        .globl main
main:
    # open(filename, read-only)
    li   $v0, 13
    la   $a0, filename
    li   $a1, 0
    li   $a2, 0
    syscall
    bltz $v0, open_error
    move $s0, $v0              # $s0 = file descriptor
    li   $s1, 0                # $s1 = running vowel total

read_loop:
    li   $v0, 14               # read(fd, buffer, 4096)
    move $a0, $s0
    la   $a1, buffer
    li   $a2, 4096
    syscall
    blez $v0, read_done        # 0 = EOF, negative = error

    move $a1, $v0              # bytes actually read
    la   $a0, buffer
    jal  countvowels
    add  $s1, $s1, $v0
    j    read_loop

read_done:
    li   $v0, 16               # close(fd)
    move $a0, $s0
    syscall

    li   $v0, 4
    la   $a0, msg
    syscall
    li   $v0, 1
    move $a0, $s1
    syscall
    li   $v0, 11
    li   $a0, 10
    syscall

    li   $v0, 10               # exit
    syscall

open_error:
    li   $v0, 4
    la   $a0, err_msg
    syscall
    li   $v0, 10
    syscall

# ------------------------------------------------------------
# countvowels
# $a0 = address of buffer, $a1 = number of bytes
# returns count in $v0 (leaf function, no stack needed)
# ------------------------------------------------------------
countvowels:
    li   $v0, 0
    blez $a1, cv_done

cv_loop:
    lb   $t0, 0($a0)
    ori  $t0, $t0, 0x20        # fold A-Z to a-z
    li   $t1, 'a'
    beq  $t0, $t1, cv_yes
    li   $t1, 'e'
    beq  $t0, $t1, cv_yes
    li   $t1, 'i'
    beq  $t0, $t1, cv_yes
    li   $t1, 'o'
    beq  $t0, $t1, cv_yes
    li   $t1, 'u'
    beq  $t0, $t1, cv_yes
    j    cv_next

cv_yes:
    addi $v0, $v0, 1

cv_next:
    addi $a0, $a0, 1
    addi $a1, $a1, -1
    bgtz $a1, cv_loop

cv_done:
    jr   $ra