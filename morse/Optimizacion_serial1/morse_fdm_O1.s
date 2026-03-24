	.file	"morse_fdm.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O1 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Uso: %s <N>\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC7:
	.string	"Error: LAPACK no pudo converger.\n"
	.align 8
.LC9:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$104, %rsp	#,
	.cfi_def_cfa_offset 160
# morse_fdm.c:7: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp163
	movq	%rax, 88(%rsp)	# tmp163, D.57651
	xorl	%eax, %eax	# tmp163
# morse_fdm.c:8:     if (argc < 2) {
	cmpl	$1, %edi	#, argc
	jle	.L11	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_52(D) + 8B], MEM[(char * *)argv_52(D) + 8B]
	movl	$10, %edx	#,
	movl	$0, %esi	#,
	call	__isoc23_strtol@PLT	#
	movq	%rax, %r14	# _79, _79
	movq	%rax, 40(%rsp)	# _79, %sfp
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, %r13d	# _79, _80
# morse_fdm.c:14:     int n2 = n * n;
	movl	%eax, %edi	# _79, n2_54
	imull	%eax, %edi	# tmp224, n2_54
# morse_fdm.c:27:     double *H = (double *)calloc(n2, sizeof(double));
	movslq	%edi, %rdi	# n2_54, _5
	movl	$8, %esi	#,
	call	calloc@PLT	#
	movq	%rax, %r15	# H, H
# morse_fdm.c:28:     double *E = (double *)malloc(n * sizeof(double));
	movslq	%r14d, %rbx	# _79, _6
# morse_fdm.c:28:     double *E = (double *)malloc(n * sizeof(double));
	salq	$3, %rbx	#, _7
# morse_fdm.c:28:     double *E = (double *)malloc(n * sizeof(double));
	movq	%rbx, %rdi	# _7,
	call	malloc@PLT	#
	movq	%rax, 32(%rsp)	# E, %sfp
# morse_fdm.c:31:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	48(%rsp), %rsi	#, tmp171
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_fdm.c:34:     for (int i = 0; i < n; i++) {
	testl	%r14d, %r14d	# _79
	jle	.L4	#,
# morse_fdm.c:23:     double dx = (XMAX - XMIN) / (double)(n + 1);
	movl	%r14d, %eax	# _79, tmp225
	addl	$1, %eax	#, _3
# morse_fdm.c:23:     double dx = (XMAX - XMIN) / (double)(n + 1);
	pxor	%xmm0, %xmm0	# _4
	cvtsi2sdl	%eax, %xmm0	# _3, _4
# morse_fdm.c:23:     double dx = (XMAX - XMIN) / (double)(n + 1);
	movsd	.LC1(%rip), %xmm1	#, tmp174
	divsd	%xmm0, %xmm1	# _4, tmp174
	movsd	%xmm1, (%rsp)	# dx, %sfp
# morse_fdm.c:24:     double dx2 = dx * dx;
	movapd	%xmm1, %xmm7	# dx, dx2
	mulsd	%xmm1, %xmm7	# dx, dx2
	movsd	%xmm7, 8(%rsp)	# dx2, %sfp
	leaq	8(%rbx), %rax	#, _86
	movq	%rax, 16(%rsp)	# _86, %sfp
	movq	%r15, %r12	# H, ivtmp.11
	movl	%r14d, %eax	# _79, tmp230
	movl	%r14d, 28(%rsp)	# tmp230, %sfp
	addl	$1, %eax	#, _95
	movl	%eax, 24(%rsp)	# _95, %sfp
	movl	$0, %ebp	#, ivtmp.13
# morse_fdm.c:34:     for (int i = 0; i < n; i++) {
	movl	$0, %ebx	#, _8
	jmp	.L6	#
.L11:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rsi), %rdx	# *argv_52(D),
	leaq	.LC0(%rip), %rsi	#,
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
# morse_fdm.c:10:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L1	#
.L5:
# morse_fdm.c:34:     for (int i = 0; i < n; i++) {
	movq	16(%rsp), %rax	# %sfp, _86
	addq	%rax, %r12	# _86, ivtmp.11
	movl	24(%rsp), %eax	# %sfp, _95
	addl	%eax, %ebp	# _95, ivtmp.13
	cmpl	%r13d, %ebx	# _80, _8
	je	.L4	#,
.L6:
	movl	%ebx, %r14d	# _8, i
# morse_fdm.c:35:         double x_i = XMIN + (double)(i + 1) * dx;
	addl	$1, %ebx	#, _8
# morse_fdm.c:35:         double x_i = XMIN + (double)(i + 1) * dx;
	pxor	%xmm0, %xmm0	# _9
	cvtsi2sdl	%ebx, %xmm0	# _8, _9
# morse_fdm.c:35:         double x_i = XMIN + (double)(i + 1) * dx;
	mulsd	(%rsp), %xmm0	# %sfp, _10
# morse_fdm.c:35:         double x_i = XMIN + (double)(i + 1) * dx;
	subsd	.LC2(%rip), %xmm0	#, x_i_68
# morse_fdm.c:36:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	mulsd	.LC3(%rip), %xmm0	#, _11
	call	exp@PLT	#
	movapd	%xmm0, %xmm1	#, _12
# morse_fdm.c:36:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	.LC4(%rip), %xmm0	#, _13
	subsd	%xmm1, %xmm0	# _12, _13
	mulsd	%xmm0, %xmm0	# _13, powmult_78
# morse_fdm.c:36:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	mulsd	.LC5(%rip), %xmm0	#, v_i_71
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	movsd	.LC4(%rip), %xmm1	#, _15
	movsd	8(%rsp), %xmm5	# %sfp, dx2
	divsd	%xmm5, %xmm1	# dx2, _15
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	addsd	%xmm1, %xmm0	# _15, _21
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	movsd	%xmm0, (%r12)	# _21, MEM[(double *)_96]
# morse_fdm.c:42:         if (i < n - 1) {
	leal	-1(%r13), %eax	#, _22
# morse_fdm.c:42:         if (i < n - 1) {
	cmpl	%r14d, %eax	# i, _22
	jle	.L5	#,
# morse_fdm.c:43:             double off_diag = -1.0 / (2.0 * dx2);
	movsd	.LC6(%rip), %xmm0	#, tmp190
	movapd	%xmm5, %xmm1	# dx2, _23
	addsd	%xmm5, %xmm1	# dx2, _23
	divsd	%xmm1, %xmm0	# _23, off_diag
# morse_fdm.c:44:             H[i * n + (i + 1)] = off_diag;
	leal	1(%rbp), %eax	#, _101
	cltq
# morse_fdm.c:44:             H[i * n + (i + 1)] = off_diag;
	movsd	%xmm0, (%r15,%rax,8)	# off_diag, *_27
# morse_fdm.c:45:             H[(i + 1) * n + i] = off_diag;
	movl	28(%rsp), %eax	# %sfp, _94
	addl	%ebp, %eax	# ivtmp.13, _103
	cltq
# morse_fdm.c:45:             H[(i + 1) * n + i] = off_diag;
	movsd	%xmm0, (%r15,%rax,8)	# off_diag, *_32
	jmp	.L5	#
.L4:
# morse_fdm.c:51:     int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 168
	pushq	40(%rsp)	# %sfp
	.cfi_def_cfa_offset 176
	movl	56(%rsp), %r9d	# %sfp,
	movq	%r15, %r8	# H,
	movl	%r13d, %ecx	# _80,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
	movl	%eax, %ebx	# info, info
# morse_fdm.c:53:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	80(%rsp), %rsi	#, tmp195
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_fdm.c:56:     if (info > 0) {
	addq	$16, %rsp	#,
	.cfi_def_cfa_offset 160
	testl	%ebx, %ebx	# info
	jg	.L12	#,
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	72(%rsp), %rax	# end.tv_nsec, end.tv_nsec
	subq	56(%rsp), %rax	# start.tv_nsec, _39
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm4, %xmm4	# _40
	cvtsi2sdq	%rax, %xmm4	# _39, _40
	divsd	.LC8(%rip), %xmm4	#, _41
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	64(%rsp), %rax	# end.tv_sec, end.tv_sec
	subq	48(%rsp), %rax	# start.tv_sec, _35
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _36
	cvtsi2sdq	%rax, %xmm0	# _35, _36
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	addsd	%xmm0, %xmm4	# _36,
	movq	32(%rsp), %rbx	# %sfp, E
	movsd	24(%rbx), %xmm3	# MEM[(double *)E_60 + 24B],
	movsd	16(%rbx), %xmm2	# MEM[(double *)E_60 + 16B],
	movsd	8(%rbx), %xmm1	# MEM[(double *)E_60 + 8B],
	movsd	(%rbx), %xmm0	# *E_60,
	movl	%r13d, %edx	# _80,
	leaq	.LC9(%rip), %rsi	#,
	movl	$2, %edi	#,
	movl	$5, %eax	#,
	call	__printf_chk@PLT	#
# morse_fdm.c:65:     free(H);
	movq	%r15, %rdi	# H,
	call	free@PLT	#
# morse_fdm.c:66:     free(E);
	movq	%rbx, %rdi	# E,
	call	free@PLT	#
# morse_fdm.c:67:     return 0;
	movl	$0, %eax	#, <retval>
.L1:
# morse_fdm.c:68: }
	movq	88(%rsp), %rdx	# D.57651, tmp220
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp220
	jne	.L13	#,
	addq	$104, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
.L12:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:111:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	stderr(%rip), %rcx	# stderr,
	movl	$33, %edx	#,
	movl	$1, %esi	#,
	leaq	.LC7(%rip), %rdi	#,
	call	fwrite@PLT	#
# morse_fdm.c:58:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L1	#
.L13:
# morse_fdm.c:68: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1076953088
	.align 8
.LC2:
	.long	0
	.long	1073741824
	.align 8
.LC3:
	.long	0
	.long	-1075838976
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1076101120
	.align 8
.LC6:
	.long	0
	.long	-1074790400
	.align 8
.LC8:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 15.2.0-4ubuntu4) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
