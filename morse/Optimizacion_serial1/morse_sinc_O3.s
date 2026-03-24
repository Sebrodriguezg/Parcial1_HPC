	.file	"morse_sinc.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O3 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"Uso: %s <N>\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC10:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
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
	subq	$88, %rsp	#,
	.cfi_def_cfa_offset 144
# morse_sinc.c:11: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp163
	movq	%rax, 72(%rsp)	# tmp163, D.57659
	xorl	%eax, %eax	# tmp163
# morse_sinc.c:12:     if (argc < 2) {
	cmpl	$1, %edi	#, argc
	jle	.L19	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_54(D) + 8B], MEM[(char * *)argv_54(D) + 8B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	__isoc23_strtol@PLT	#
# morse_sinc.c:29:     double *H = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
# morse_sinc.c:18:     int n2 = n * n;
	movl	%eax, %edi	# _80, n2_56
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	%rax, %r15	#, _80
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, 28(%rsp)	# _80, %sfp
# morse_sinc.c:18:     int n2 = n * n;
	imull	%eax, %edi	# _80, n2_56
# morse_sinc.c:29:     double *H = (double *)calloc(n2, sizeof(double));
	movslq	%edi, %rdi	# n2_56, _4
	call	calloc@PLT	#
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	movslq	%r15d, %rdi	# _80, _5
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	salq	$3, %rdi	#, _6
# morse_sinc.c:29:     double *H = (double *)calloc(n2, sizeof(double));
	movq	%rax, %rbx	#, H
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	call	malloc@PLT	#
# morse_sinc.c:33:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	32(%rsp), %rsi	#, tmp172
	movl	$1, %edi	#,
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	movq	%rax, 16(%rsp)	# E, %sfp
# morse_sinc.c:33:     clock_gettime(CLOCK_MONOTONIC, &start);
	call	clock_gettime@PLT	#
# morse_sinc.c:36:     for (int i = 0; i < n; i++) {
	testl	%r15d, %r15d	# _80
	jle	.L12	#,
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	movsd	.LC3(%rip), %xmm1	#, tmp175
# morse_sinc.c:26:     double dx2   = dx * dx;
	xorl	%ebp, %ebp	# ivtmp.18
	xorl	%r12d, %r12d	# ivtmp.15
	movl	%r15d, %r14d	# _80, _112
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	pxor	%xmm0, %xmm0	# _3
	cvtsi2sdl	%r15d, %xmm0	# _80, _3
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	divsd	%xmm0, %xmm1	# _3, tmp175
# morse_sinc.c:26:     double dx2   = dx * dx;
	movapd	%xmm1, %xmm3	# dx, dx2
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	movsd	%xmm1, 8(%rsp)	# dx, %sfp
# morse_sinc.c:26:     double dx2   = dx * dx;
	mulsd	%xmm1, %xmm3	# dx, dx2
	.p2align 4
	.p2align 3
.L11:
	movl	%r12d, %r13d	# ivtmp.15, ivtmp.15
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	pxor	%xmm0, %xmm0	# _8
	addl	$1, %r12d	#, ivtmp.15
	movsd	%xmm3, (%rsp)	# dx2, %sfp
	cvtsi2sdl	%r12d, %xmm0	# ivtmp.15, _8
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	mulsd	8(%rsp), %xmm0	# %sfp, _9
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	subsd	.LC4(%rip), %xmm0	#, x_i_70
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	mulsd	.LC5(%rip), %xmm0	#, _10
	call	exp@PLT	#
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	.LC0(%rip), %xmm6	#, sign
	movslq	%ebp, %rax	# ivtmp.18, _123
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	.LC6(%rip), %xmm4	#, v_i
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movapd	%xmm0, %xmm1	#, _11
	leaq	(%rbx,%rax,8), %rcx	#, _117
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	(%rsp), %xmm3	# %sfp, dx2
	xorl	%eax, %eax	# ivtmp.9
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movapd	%xmm6, %xmm0	# sign, _12
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	.LC1(%rip), %xmm5	#, sign
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	subsd	%xmm1, %xmm0	# _11, _12
	mulsd	%xmm0, %xmm0	# _12, powmult_92
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	mulsd	%xmm0, %xmm4	# powmult_92, v_i
	jmp	.L10	#
	.p2align 4,,10
	.p2align 3
.L7:
	movl	%r13d, %edx	# ivtmp.15, _108
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	movapd	%xmm5, %xmm0	# sign, sign
	subl	%eax, %edx	# ivtmp.9, _108
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	testb	$1, %dl	#, _108
	jne	.L9	#,
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	movapd	%xmm6, %xmm0	# sign, sign
.L9:
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	pxor	%xmm2, %xmm2	# _22
	cvtsi2sdl	%edx, %xmm2	# _108, _22
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	movapd	%xmm2, %xmm1	# _22, _23
	mulsd	%xmm3, %xmm1	# dx2, _23
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	mulsd	%xmm2, %xmm1	# _22, _25
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	divsd	%xmm1, %xmm0	# _25, _31
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	%xmm0, (%rcx,%rax,8)	# _31, MEM[(double *)_117 + ivtmp.9_122 * 8]
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	addq	$1, %rax	#, ivtmp.9
	cmpq	%rax, %r14	# ivtmp.9, _112
	je	.L20	#,
.L10:
# morse_sinc.c:41:             if (i == j) {
	cmpl	%eax, %r13d	# ivtmp.9, ivtmp.15
	jne	.L7	#,
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	.LC7(%rip), %xmm1	#, _14
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	.LC8(%rip), %xmm0	#, _15
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	mulsd	%xmm3, %xmm1	# dx2, _14
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	divsd	%xmm1, %xmm0	# _14, _15
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	addsd	%xmm4, %xmm0	# v_i, _31
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	%xmm0, (%rcx,%rax,8)	# _31, MEM[(double *)_117 + ivtmp.9_122 * 8]
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	addq	$1, %rax	#, ivtmp.9
	cmpq	%rax, %r14	# ivtmp.9, _112
	jne	.L10	#,
.L20:
# morse_sinc.c:36:     for (int i = 0; i < n; i++) {
	addl	%r15d, %ebp	# _80, ivtmp.18
	cmpl	%r12d, %r15d	# ivtmp.15, _80
	jne	.L11	#,
.L12:
# morse_sinc.c:54:     int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 152
	movl	$85, %edx	#,
	movl	%r15d, %r9d	# _80,
	movq	%rbx, %r8	# H,
	pushq	24(%rsp)	# %sfp
	.cfi_def_cfa_offset 160
	movl	44(%rsp), %ecx	# %sfp,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
# morse_sinc.c:56:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	64(%rsp), %rsi	#, tmp173
	movl	$1, %edi	#,
# morse_sinc.c:54:     int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	movl	%eax, %r13d	#, info
# morse_sinc.c:56:     clock_gettime(CLOCK_MONOTONIC, &end);
	call	clock_gettime@PLT	#
# morse_sinc.c:59:     if (info > 0) return 1;
	popq	%rax	#
	.cfi_def_cfa_offset 152
	popq	%rdx	#
	.cfi_def_cfa_offset 144
	testl	%r13d, %r13d	# info
	jle	.L5	#,
.L3:
# morse_sinc.c:14:         return 1;
	movl	$1, %eax	#, <retval>
.L1:
# morse_sinc.c:67: }
	movq	72(%rsp), %rdx	# D.57659, tmp235
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp235
	jne	.L21	#,
	addq	$88, %rsp	#,
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
.L5:
	.cfi_restore_state
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	56(%rsp), %rax	# end.tv_nsec, end.tv_nsec
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm4, %xmm4	# _39
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _35
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	28(%rsp), %edx	# %sfp,
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	40(%rsp), %rax	# start.tv_nsec, _38
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	16(%rsp), %r15	# %sfp, E
	movl	$2, %edi	#,
	leaq	.LC10(%rip), %rsi	#,
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm4	# _38, _39
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	48(%rsp), %rax	# end.tv_sec, end.tv_sec
	subq	32(%rsp), %rax	# start.tv_sec, _34
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	divsd	.LC9(%rip), %xmm4	#, _40
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm0	# _34, _35
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	addsd	%xmm0, %xmm4	# _35,
	movsd	24(%r15), %xmm3	# MEM[(double *)E_62 + 24B],
	movsd	16(%r15), %xmm2	# MEM[(double *)E_62 + 16B],
	movsd	8(%r15), %xmm1	# MEM[(double *)E_62 + 8B],
	movsd	(%r15), %xmm0	# *E_62,
	movl	$5, %eax	#,
	call	__printf_chk@PLT	#
# morse_sinc.c:65:     free(H); free(E);
	movq	%rbx, %rdi	# H,
	call	free@PLT	#
# morse_sinc.c:65:     free(H); free(E);
	movq	%r15, %rdi	# E,
	call	free@PLT	#
# morse_sinc.c:66:     return 0;
	xorl	%eax, %eax	# <retval>
	jmp	.L1	#
.L19:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rsi), %rdx	# *argv_54(D),
	movl	$2, %edi	#,
	leaq	.LC2(%rip), %rsi	#,
	call	__printf_chk@PLT	#
# morse_sinc.c:14:         return 1;
	jmp	.L3	#
.L21:
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
