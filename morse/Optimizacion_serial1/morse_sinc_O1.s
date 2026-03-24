	.file	"morse_sinc.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O1 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"Uso: %s <N>\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC10:
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
# morse_sinc.c:11: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp169
	movq	%rax, 88(%rsp)	# tmp169, D.57655
	xorl	%eax, %eax	# tmp169
# morse_sinc.c:12:     if (argc < 2) {
	cmpl	$1, %edi	#, argc
	jle	.L16	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_53(D) + 8B], MEM[(char * *)argv_53(D) + 8B]
	movl	$10, %edx	#,
	movl	$0, %esi	#,
	call	__isoc23_strtol@PLT	#
	movq	%rax, %rbx	# _79, _79
	movq	%rax, 40(%rsp)	# _79, %sfp
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, %r13d	# _79, _80
# morse_sinc.c:18:     int n2 = n * n;
	movl	%eax, %edi	# _79, n2_55
	imull	%eax, %edi	# tmp257, n2_55
# morse_sinc.c:29:     double *H = (double *)calloc(n2, sizeof(double));
	movslq	%edi, %rdi	# n2_55, _4
	movl	$8, %esi	#,
	call	calloc@PLT	#
	movq	%rax, %r12	# H, H
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	movslq	%ebx, %rdi	# _79, _5
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	salq	$3, %rdi	#, _6
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	call	malloc@PLT	#
	movq	%rax, 32(%rsp)	# E, %sfp
# morse_sinc.c:33:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	48(%rsp), %rsi	#, tmp178
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_sinc.c:36:     for (int i = 0; i < n; i++) {
	testl	%ebx, %ebx	# _79
	jle	.L4	#,
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	pxor	%xmm0, %xmm0	# _3
	cvtsi2sdl	%ebx, %xmm0	# _79, _3
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	movsd	.LC3(%rip), %xmm1	#, tmp180
	divsd	%xmm0, %xmm1	# _3, tmp180
	movsd	%xmm1, 16(%rsp)	# dx, %sfp
# morse_sinc.c:26:     double dx2   = dx * dx;
	movapd	%xmm1, %xmm6	# dx, dx2
	mulsd	%xmm1, %xmm6	# dx, dx2
	movsd	%xmm6, 8(%rsp)	# dx2, %sfp
	movl	%ebx, %r15d	# _79, _106
	movl	%ebx, 28(%rsp)	# tmp261, %sfp
	movl	$0, %ebp	#, ivtmp.17
	movl	$0, %r14d	#, ivtmp.14
	jmp	.L9	#
.L16:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rsi), %rdx	# *argv_53(D),
	leaq	.LC2(%rip), %rsi	#,
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
# morse_sinc.c:14:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L1	#
.L18:
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	leal	(%rax,%rbp), %edx	#, _95
	movslq	%edx, %rdx	# _95, _18
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	8(%rsp), %xmm1	# %sfp, _14
	mulsd	.LC7(%rip), %xmm1	#, _14
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movapd	%xmm4, %xmm0	# tmp236, _15
	divsd	%xmm1, %xmm0	# _14, _15
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	addsd	%xmm3, %xmm0	# v_i, _21
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	%xmm0, (%r12,%rdx,8)	# _21, *_20
	jmp	.L6	#
.L7:
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	pxor	%xmm2, %xmm2	# _22
	cvtsi2sdl	%ecx, %xmm2	# _99, _22
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	addl	%ebp, %edx	# ivtmp.17, _101
	movslq	%edx, %rdx	# _101, _27
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	movsd	8(%rsp), %xmm1	# %sfp, _23
	mulsd	%xmm2, %xmm1	# _22, _23
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	mulsd	%xmm2, %xmm1	# _22, _24
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	divsd	%xmm1, %xmm0	# _24, _30
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	movsd	%xmm0, (%r12,%rdx,8)	# _30, *_29
.L6:
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	addl	$1, %eax	#, j
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	cmpl	%r13d, %eax	# _80, j
	je	.L17	#,
.L8:
# morse_sinc.c:41:             if (i == j) {
	cmpl	%ebx, %eax	# ivtmp.14, j
	je	.L18	#,
	movl	%eax, %edx	# j, _97
	movl	%ebx, %ecx	# ivtmp.14, _99
	subl	%eax, %ecx	# j, _99
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	movsd	.LC1(%rip), %xmm0	#, sign
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	testb	$1, %cl	#, _99
	jne	.L7	#,
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	movsd	.LC0(%rip), %xmm0	#, sign
	jmp	.L7	#
.L17:
# morse_sinc.c:36:     for (int i = 0; i < n; i++) {
	addl	%r15d, %ebp	# _106, ivtmp.17
	movl	28(%rsp), %eax	# %sfp, _108
	cmpl	%eax, %r14d	# _108, ivtmp.14
	je	.L4	#,
.L9:
	movl	%r14d, %ebx	# ivtmp.14, ivtmp.14
	addl	$1, %r14d	#, ivtmp.14
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	pxor	%xmm0, %xmm0	# _8
	cvtsi2sdl	%r14d, %xmm0	# ivtmp.14, _8
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	mulsd	16(%rsp), %xmm0	# %sfp, _9
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	subsd	.LC4(%rip), %xmm0	#, x_i_69
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	mulsd	.LC5(%rip), %xmm0	#, _10
	call	exp@PLT	#
	movapd	%xmm0, %xmm1	#, _11
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	.LC0(%rip), %xmm0	#, tmp187
	subsd	%xmm1, %xmm0	# _11, _12
	mulsd	%xmm0, %xmm0	# _12, powmult_92
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movapd	%xmm0, %xmm3	# powmult_92, powmult_92
	mulsd	.LC6(%rip), %xmm3	#, powmult_92
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	movl	$0, %eax	#, j
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	.LC8(%rip), %xmm4	#, tmp236
	jmp	.L8	#
.L4:
# morse_sinc.c:54:     int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 168
	pushq	40(%rsp)	# %sfp
	.cfi_def_cfa_offset 176
	movl	56(%rsp), %r9d	# %sfp,
	movq	%r12, %r8	# H,
	movl	%r13d, %ecx	# _80,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
	movl	%eax, %ebx	# info, info
# morse_sinc.c:56:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	80(%rsp), %rsi	#, tmp203
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_sinc.c:59:     if (info > 0) return 1;
	addq	$16, %rsp	#,
	.cfi_def_cfa_offset 160
# morse_sinc.c:59:     if (info > 0) return 1;
	movl	$1, %eax	#, <retval>
# morse_sinc.c:59:     if (info > 0) return 1;
	testl	%ebx, %ebx	# info
	jle	.L19	#,
.L1:
# morse_sinc.c:67: }
	movq	88(%rsp), %rdx	# D.57655, tmp253
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp253
	jne	.L20	#,
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
.L19:
	.cfi_restore_state
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	72(%rsp), %rax	# end.tv_nsec, end.tv_nsec
	subq	56(%rsp), %rax	# start.tv_nsec, _37
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm4, %xmm4	# _38
	cvtsi2sdq	%rax, %xmm4	# _37, _38
	divsd	.LC9(%rip), %xmm4	#, _39
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	64(%rsp), %rax	# end.tv_sec, end.tv_sec
	subq	48(%rsp), %rax	# start.tv_sec, _33
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _34
	cvtsi2sdq	%rax, %xmm0	# _33, _34
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	addsd	%xmm0, %xmm4	# _34,
	movq	32(%rsp), %rbx	# %sfp, E
	movsd	24(%rbx), %xmm3	# MEM[(double *)E_61 + 24B],
	movsd	16(%rbx), %xmm2	# MEM[(double *)E_61 + 16B],
	movsd	8(%rbx), %xmm1	# MEM[(double *)E_61 + 8B],
	movsd	(%rbx), %xmm0	# *E_61,
	movl	%r13d, %edx	# _80,
	leaq	.LC10(%rip), %rsi	#,
	movl	$2, %edi	#,
	movl	$5, %eax	#,
	call	__printf_chk@PLT	#
# morse_sinc.c:65:     free(H); free(E);
	movq	%r12, %rdi	# H,
	call	free@PLT	#
# morse_sinc.c:65:     free(H); free(E);
	movq	%rbx, %rdi	# E,
	call	free@PLT	#
# morse_sinc.c:66:     return 0;
	movl	$0, %eax	#, <retval>
	jmp	.L1	#
.L20:
# morse_sinc.c:67: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC1:
	.long	0
	.long	-1074790400
	.align 8
.LC3:
	.long	0
	.long	1077346304
	.align 8
.LC4:
	.long	0
	.long	1074266112
	.align 8
.LC5:
	.long	0
	.long	-1075838976
	.align 8
.LC6:
	.long	0
	.long	1076101120
	.align 8
.LC7:
	.long	0
	.long	1075314688
	.align 8
.LC8:
	.long	-910277154
	.long	1076084028
	.align 8
.LC9:
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
