	.file	"morse_base.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O3 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.p2align 4
	.globl	v_func
	.type	v_func, @function
v_func:
.LFB39:
	.cfi_startproc
	endbr64	
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 16
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	mulsd	.LC0(%rip), %xmm0	#, _1
	call	exp@PLT	#
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	movsd	.LC1(%rip), %xmm1	#, tmp106
	subsd	%xmm0, %xmm1	# _2, diff
# morse_base.c:12:     return D * diff * diff;
	movsd	.LC2(%rip), %xmm0	#, _3
# morse_base.c:13: }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 8
# morse_base.c:12:     return D * diff * diff;
	mulsd	%xmm1, %xmm0	# diff, _3
# morse_base.c:12:     return D * diff * diff;
	mulsd	%xmm1, %xmm0	# diff, _8
# morse_base.c:13: }
	ret	
	.cfi_endproc
.LFE39:
	.size	v_func, .-v_func
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"Uso: %s <N>\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC9:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB40:
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
	subq	$216, %rsp	#,
	.cfi_def_cfa_offset 272
# morse_base.c:15: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp257
	movq	%rax, 200(%rsp)	# tmp257, D.57814
	xorl	%eax, %eax	# tmp257
# morse_base.c:16:     if (argc < 2) {
	cmpl	$1, %edi	#, argc
	jle	.L49	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_117(D) + 8B], MEM[(char * *)argv_117(D) + 8B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	__isoc23_strtol@PLT	#
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	%rax, %r15	#, _170
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, 112(%rsp)	# _170, %sfp
# morse_base.c:22:     int n2 = n * n;
	imull	%eax, %eax	# _170, n2
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movslq	%eax, %rbx	# n2, _3
# morse_base.c:22:     int n2 = n * n;
	movl	%eax, 116(%rsp)	# n2, %sfp
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movq	%rbx, %rdi	# _3,
	call	calloc@PLT	#
# morse_base.c:26:     double *P    = (double *)calloc(n2, sizeof(double));
	movq	%rbx, %rdi	# _3,
	movl	$8, %esi	#,
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movq	%rax, 136(%rsp)	# X, %sfp
	movq	%rax, %rbp	#, X
# morse_base.c:26:     double *P    = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:27:     double *T    = (double *)calloc(n2, sizeof(double));
	movq	%rbx, %rdi	# _3,
	movl	$8, %esi	#,
# morse_base.c:26:     double *P    = (double *)calloc(n2, sizeof(double));
	movq	%rax, %r14	#, P
# morse_base.c:27:     double *T    = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:28:     double *VMAT = (double *)calloc(n2, sizeof(double));
	movq	%rbx, %rdi	# _3,
	movl	$8, %esi	#,
# morse_base.c:27:     double *T    = (double *)calloc(n2, sizeof(double));
	movq	%rax, 120(%rsp)	#, %sfp
# morse_base.c:28:     double *VMAT = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:29:     double *H    = (double *)calloc(n2, sizeof(double));
	movq	%rbx, %rdi	# _3,
	movl	$8, %esi	#,
# morse_base.c:28:     double *VMAT = (double *)calloc(n2, sizeof(double));
	movq	%rax, 80(%rsp)	#, %sfp
# morse_base.c:29:     double *H    = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:30:     double *VP   = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movslq	%r15d, %rbx	# _170, _4
# morse_base.c:29:     double *H    = (double *)calloc(n2, sizeof(double));
	movq	%rax, 128(%rsp)	#, %sfp
# morse_base.c:30:     double *VP   = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	leaq	0(,%rbx,8), %r10	#, _5
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movq	%r10, %rdi	# _5,
	movq	%r10, 8(%rsp)	# _5, %sfp
# morse_base.c:30:     double *VP   = (double *)calloc(n2, sizeof(double));
	movq	%rax, 88(%rsp)	#, %sfp
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	call	malloc@PLT	#
# morse_base.c:34:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	160(%rsp), %rsi	#, tmp267
	movl	$1, %edi	#,
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movq	%rax, 40(%rsp)	# E, %sfp
# morse_base.c:34:     clock_gettime(CLOCK_MONOTONIC, &start);
	call	clock_gettime@PLT	#
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	cmpl	$1, %r15d	#, _170
	movq	8(%rsp), %r10	# %sfp, _5
	jle	.L7	#,
	leaq	8(%rbp), %r12	#, ivtmp.114
	leaq	8(%r10), %rdx	#, _380
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	xorl	%eax, %eax	# i
	movq	%r10, %r13	# _5, _5
	movsd	.LC5(%rip), %xmm3	#, tmp348
	leaq	8(%r14), %rbp	#, ivtmp.117
	leal	-1(%r15), %esi	#, _398
	pxor	%xmm2, %xmm2	# tmp270
	jmp	.L12	#
	.p2align 4,,10
	.p2align 3
.L50:
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	addq	%rdx, %r12	# _380, ivtmp.114
	addq	%rdx, %rbp	# _380, ivtmp.117
.L12:
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	addl	$1, %eax	#, i
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	pxor	%xmm0, %xmm0	# _7
	cvtsi2sdl	%eax, %xmm0	# i, _7
	mulsd	%xmm3, %xmm0	# tmp348, _8
	ucomisd	%xmm0, %xmm2	# _8, tmp270
	ja	.L43	#,
	sqrtsd	%xmm0, %xmm0	# _8, val
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movapd	%xmm0, %xmm1	# val, _20
	xorpd	.LC6(%rip), %xmm1	#, _20
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	movsd	%xmm0, (%r12)	# val, MEM[(double *)_390]
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	movsd	%xmm0, -8(%r12,%rbx,8)	# val, MEM[(double *)_390 + -8B + _4 * 8]
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movsd	%xmm1, 0(%rbp)	# _20, MEM[(double *)_393]
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	movsd	%xmm0, -8(%rbp,%rbx,8)	# val, MEM[(double *)_393 + -8B + _4 * 8]
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	cmpl	%esi, %eax	# _398, i
	jne	.L50	#,
.L46:
	movq	%r13, %r10	# _5, _5
.L33:
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movq	88(%rsp), %rbp	# %sfp, VP
	movl	116(%rsp), %edx	# %sfp, _361
	movq	%r10, 8(%rsp)	# _5, %sfp
	movq	136(%rsp), %rsi	# %sfp,
	salq	$3, %rdx	#, _314
	movq	%rbp, %rdi	# VP,
	call	memcpy@PLT	#
# morse_base.c:50:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);
	movl	%r15d, %r9d	# _170,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	pushq	%r8	#
	.cfi_def_cfa_offset 280
	movl	$101, %edi	#,
	movq	%rbp, %r8	# VP,
	pushq	48(%rsp)	# %sfp
	.cfi_def_cfa_offset 288
	movl	128(%rsp), %ecx	# %sfp,
	call	LAPACKE_dsyev@PLT	#
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	testl	%r15d, %r15d	# _170
	popq	%r9	#
	.cfi_def_cfa_offset 280
	popq	%r10	#
	.cfi_def_cfa_offset 272
	movq	8(%rsp), %r10	# %sfp, _5
	jle	.L14	#,
.L31:
	movl	%r15d, %eax	# _170, _110
	movq	%rbx, %rdi	# _4, _270
	movq	%r10, %r13	# _5, _5
	movq	120(%rsp), %rbp	# %sfp, ivtmp.107
	shrl	%eax	# _110
	movl	112(%rsp), %r10d	# %sfp, _171
	salq	$4, %rdi	#, _270
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movq	%r14, %r11	# P, ivtmp.108
	salq	$4, %rax	#, _110
	xorl	%edx, %edx	# ivtmp.106
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	xorl	%r12d, %r12d	# i
	movq	%rax, %rcx	# _110, _109
	.p2align 4
	.p2align 3
.L15:
	movq	%r13, 8(%rsp)	# _5, %sfp
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movq	%r14, %r9	# P, ivtmp.101
	xorl	%r8d, %r8d	# ivtmp.97
	leaq	(%rcx,%r11), %rsi	#, _107
	movl	%r12d, 16(%rsp)	# i, %sfp
	.p2align 4
	.p2align 3
.L17:
	movl	%r8d, %r13d	# ivtmp.97, j
	cmpl	$1, %r15d	#, _170
	je	.L35	#,
.L21:
# morse_base.c:56:             double sum = 0.0;
	movq	%r11, %r12	# ivtmp.108, ivtmp.94
	movq	%r9, %rax	# ivtmp.101, ivtmp.91
	pxor	%xmm1, %xmm1	# sum
	.p2align 6
	.p2align 4
	.p2align 3
.L19:
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movupd	(%r12), %xmm6	# MEM <vector(2) double> [(double *)_181], tmp481
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movsd	(%rax), %xmm0	# MEM[(double *)_114], MEM[(double *)_114]
	movhpd	(%rax,%rbx,8), %xmm0	# MEM[(double *)_114 + _4 * 8], vect_cst__262
	addq	$16, %r12	#, ivtmp.94
	addq	%rdi, %rax	# _270, ivtmp.91
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	mulpd	%xmm6, %xmm0	# tmp481, vect__40.41
	addsd	%xmm0, %xmm1	# stmp_sum_158.42, stmp_sum_158.42
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	unpckhpd	%xmm0, %xmm0	# stmp_sum_158.42_258
	addsd	%xmm0, %xmm1	# stmp_sum_158.42_258, sum
	cmpq	%r12, %rsi	# ivtmp.94, _107
	jne	.L19	#,
	testb	$1, %r15b	#, _170
	je	.L16	#,
	movl	%r15d, %eax	# _170, k
	andl	$-2, %eax	#, k
.L22:
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movl	%r10d, %r12d	# _171, _302
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	addq	$8, %r9	#, ivtmp.101
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	imull	%eax, %r12d	# k, _302
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	addl	%edx, %eax	# ivtmp.106, _307
	cltq
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	addl	%r13d, %r12d	# j, _301
	movslq	%r12d, %r12	# _301, _300
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movsd	(%r14,%r12,8), %xmm0	# *_298, *_298
	mulsd	(%r14,%rax,8), %xmm0	# *_304, _296
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	addsd	%xmm1, %xmm0	# sum, sum_295
# morse_base.c:60:             T[i * n + j] = sum;
	movsd	%xmm0, 0(%rbp,%r8,8)	# sum_295, MEM[(double *)_98 + ivtmp.97_373 * 8]
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	addq	$1, %r8	#, ivtmp.97
	cmpl	%r8d, %r10d	# ivtmp.97, _171
	jg	.L17	#,
.L47:
	movl	16(%rsp), %r12d	# %sfp, i
	movq	8(%rsp), %r13	# %sfp, _5
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addl	%r15d, %edx	# _170, ivtmp.106
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addl	$1, %r12d	#, i
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addq	%r13, %rbp	# _5, ivtmp.107
	addq	%r13, %r11	# _5, ivtmp.108
	cmpl	%r10d, %r12d	# _171, i
	jl	.L15	#,
	leaq	8(%r13), %rax	#, _243
	movq	88(%rsp), %rdx	# %sfp, VP
	movq	%r13, %r10	# _5, _5
	xorl	%r8d, %r8d	# ivtmp.85
	movq	%rax, 104(%rsp)	# _243, %sfp
	leal	-1(%r15), %eax	#, _234
	movq	80(%rsp), %r12	# %sfp, VMAT
	movq	%rbx, 48(%rsp)	# _4, %sfp
	leaq	8(%rdx,%rax,8), %rbp	#, ivtmp.83
	movl	%r15d, %eax	# _170, _199
	movq	%r15, 144(%rsp)	# _170, %sfp
	movq	%r14, 152(%rsp)	# P, %sfp
	movq	%rax, 96(%rsp)	# _199, %sfp
	xorl	%eax, %eax	# ivtmp.76
	.p2align 4
	.p2align 3
.L26:
	movq	80(%rsp), %rcx	# %sfp, VMAT
	movq	%r10, 56(%rsp)	# _5, %sfp
# morse_base.c:67:             double sum = 0.0;
	xorl	%r15d, %r15d	# ivtmp.74
	movq	%rax, %r14	# ivtmp.76, ivtmp.69
	movq	%r8, 64(%rsp)	# ivtmp.85, %sfp
	addq	%r8, %rcx	# ivtmp.85, _196
	movq	%rax, 72(%rsp)	# ivtmp.76, %sfp
	movq	%rcx, 24(%rsp)	# _196, %sfp
	movq	88(%rsp), %rcx	# %sfp, VP
	addq	%r8, %rcx	# ivtmp.85, ivtmp.61
	movq	%rcx, 32(%rsp)	# ivtmp.61, %sfp
	.p2align 4
	.p2align 3
.L27:
	movq	32(%rsp), %r13	# %sfp, ivtmp.61
	movq	40(%rsp), %rbx	# %sfp, ivtmp.62
	pxor	%xmm2, %xmm2	# sum
	.p2align 4
	.p2align 3
.L24:
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movsd	0(%r13), %xmm5	# MEM[(double *)_76], _51
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	movsd	.LC0(%rip), %xmm0	#, _172
	movsd	%xmm2, 16(%rsp)	# sum, %sfp
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	addq	$8, %rbx	#, ivtmp.62
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	mulsd	-8(%rbx), %xmm0	# MEM[(double *)_75], _172
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movsd	%xmm5, 8(%rsp)	# _51, %sfp
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	call	exp@PLT	#
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	movsd	.LC1(%rip), %xmm1	#, diff
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movsd	16(%rsp), %xmm2	# %sfp, sum
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	subsd	%xmm0, %xmm1	# _173, diff
# morse_base.c:12:     return D * diff * diff;
	movsd	.LC2(%rip), %xmm0	#, _175
	mulsd	%xmm1, %xmm0	# diff, _175
# morse_base.c:12:     return D * diff * diff;
	mulsd	%xmm1, %xmm0	# diff, _176
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	mulsd	8(%rsp), %xmm0	# %sfp, _56
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	mulsd	0(%r13,%r15,8), %xmm0	# MEM[(double *)_76 + ivtmp.74_294 * 8], _152
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	addq	$8, %r13	#, ivtmp.61
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	addsd	%xmm0, %xmm2	# _152, sum
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	cmpq	%rbp, %r13	# ivtmp.83, ivtmp.61
	jne	.L24	#,
# morse_base.c:71:             VMAT[i * n + j] = sum;
	movq	24(%rsp), %rax	# %sfp, _196
	movsd	%xmm2, (%rax,%r14,8)	# sum, MEM[(double *)_292 + ivtmp.69_25 * 8]
# morse_base.c:66:         for (int j = i; j < n; j++) {
	addq	$1, %r14	#, ivtmp.69
# morse_base.c:72:             VMAT[j * n + i] = sum; // Simetría
	movsd	%xmm2, (%r12,%r15,8)	# sum, MEM[(double *)_338 + ivtmp.74_294 * 8]
# morse_base.c:66:         for (int j = i; j < n; j++) {
	addq	48(%rsp), %r15	# %sfp, ivtmp.74
	cmpl	%r14d, 112(%rsp)	# ivtmp.69, %sfp
	jg	.L27	#,
# morse_base.c:65:     for (int i = 0; i < n; i++) {
	movq	56(%rsp), %r10	# %sfp, _5
	movq	64(%rsp), %r8	# %sfp, ivtmp.85
	movq	72(%rsp), %rax	# %sfp, ivtmp.76
	addq	104(%rsp), %r12	# %sfp, ivtmp.81
	addq	%r10, %rbp	# _5, ivtmp.83
	addq	%r10, %r8	# _5, ivtmp.85
	addq	$1, %rax	#, ivtmp.76
	cmpq	%rax, 96(%rsp)	# ivtmp.76, %sfp
	jne	.L26	#,
	movq	144(%rsp), %r15	# %sfp, _170
	movq	152(%rsp), %r14	# %sfp, P
.L14:
	movl	116(%rsp), %eax	# %sfp, n2
	cmpl	$1, %eax	#, n2
	je	.L36	#,
	movl	%eax, %edx	# n2, _31
	movsd	.LC0(%rip), %xmm1	#, tmp349
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	xorl	%eax, %eax	# ivtmp.51
	movq	120(%rsp), %rcx	# %sfp, T
	shrl	%edx	# _31
	movq	80(%rsp), %rsi	# %sfp, VMAT
	movq	128(%rsp), %rdi	# %sfp, H
	salq	$4, %rdx	#, _30
	unpcklpd	%xmm1, %xmm1	# tmp349
	.p2align 5
	.p2align 4
	.p2align 3
.L29:
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movupd	(%rcx,%rax), %xmm0	# MEM <vector(2) double> [(double *)T_125 + ivtmp.51_33 * 1], vect__76.26_349
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movupd	(%rsi,%rax), %xmm7	# MEM <vector(2) double> [(double *)VMAT_127 + ivtmp.51_33 * 1], tmp503
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	mulpd	%xmm1, %xmm0	# tmp349, vect__77.27_348
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	addpd	%xmm7, %xmm0	# tmp503, vect__81.31_344
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movups	%xmm0, (%rdi,%rax)	# vect__81.31_344, MEM <vector(2) double> [(double *)H_129 + ivtmp.51_33 * 1]
	addq	$16, %rax	#, ivtmp.51
	cmpq	%rax, %rdx	# ivtmp.51, _30
	jne	.L29	#,
	movl	116(%rsp), %edx	# %sfp, n2
	movl	%edx, %eax	# n2, i
	andl	$-2, %eax	#, i
	andb	$1, %dl	#, n2
	je	.L32	#,
.L28:
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movq	120(%rsp), %rdx	# %sfp, T
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	cltq
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movsd	.LC0(%rip), %xmm0	#, tmp324
	mulsd	(%rdx,%rax,8), %xmm0	# *_161, _325
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movq	80(%rsp), %rdx	# %sfp, VMAT
	addsd	(%rdx,%rax,8), %xmm0	# *_324, _321
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movq	128(%rsp), %rdx	# %sfp, H
	movsd	%xmm0, (%rdx,%rax,8)	# _321, *_322
.L32:
# morse_base.c:82:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 280
	movl	%r15d, %r9d	# _170,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movq	48(%rsp), %rbx	# %sfp, E
	movl	$101, %edi	#,
	pushq	%rbx	# E
	.cfi_def_cfa_offset 288
	movq	144(%rsp), %rbp	# %sfp, H
	movl	128(%rsp), %r15d	# %sfp, _171
	movq	%rbp, %r8	# H,
	movl	%r15d, %ecx	# _171,
	call	LAPACKE_dsyev@PLT	#
# morse_base.c:84:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	192(%rsp), %rsi	#, tmp326
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# _89
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm4, %xmm4	# _85
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	%r15d, %edx	# _171,
	movsd	(%rbx), %xmm0	# *E_133, *E_133
	movsd	24(%rbx), %xmm3	# MEM[(double *)E_133 + 24B],
	leaq	.LC9(%rip), %rsi	#,
	movl	$2, %edi	#,
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	200(%rsp), %rax	# end.tv_nsec, end.tv_nsec
	subq	184(%rsp), %rax	# start.tv_nsec, _88
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm1	# _88, _89
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	192(%rsp), %rax	# end.tv_sec, end.tv_sec
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movsd	16(%rbx), %xmm2	# MEM[(double *)E_133 + 16B],
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	divsd	.LC8(%rip), %xmm1	#, _90
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	176(%rsp), %rax	# start.tv_sec, _84
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm4	# _84, _85
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	addsd	%xmm1, %xmm4	# _90,
	movsd	8(%rbx), %xmm1	# MEM[(double *)E_133 + 8B],
	movl	$5, %eax	#,
	call	__printf_chk@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	152(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	%r14, %rdi	# P,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	136(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	96(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	%rbp, %rdi	# H,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	104(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	%rbx, %rdi	# E,
	call	free@PLT	#
# morse_base.c:92:     return 0;
	popq	%rsi	#
	.cfi_def_cfa_offset 280
	xorl	%eax, %eax	# <retval>
	popq	%rdi	#
	.cfi_def_cfa_offset 272
.L4:
# morse_base.c:93: }
	movq	200(%rsp), %rdx	# D.57814, tmp377
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp377
	jne	.L51	#,
	addq	$216, %rsp	#,
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
	.p2align 4,,10
	.p2align 3
.L16:
	.cfi_restore_state
# morse_base.c:60:             T[i * n + j] = sum;
	movsd	%xmm1, 0(%rbp,%r8,8)	# sum, MEM[(double *)_385 + ivtmp.97_374 * 8]
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	addq	$1, %r8	#, ivtmp.97
	cmpl	%r8d, %r10d	# ivtmp.97, _171
	jle	.L47	#,
	addq	$8, %r9	#, ivtmp.101
	movl	%r8d, %r13d	# ivtmp.97, j
	jmp	.L21	#
	.p2align 4,,10
	.p2align 3
.L35:
# morse_base.c:57:             for (int k = 0; k < n; k++) {
	xorl	%eax, %eax	# k
# morse_base.c:56:             double sum = 0.0;
	pxor	%xmm1, %xmm1	# sum
	jmp	.L22	#
.L49:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rsi), %rdx	# *argv_117(D),
	movl	$2, %edi	#,
	leaq	.LC4(%rip), %rsi	#,
	call	__printf_chk@PLT	#
# morse_base.c:18:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L4	#
.L36:
# morse_base.c:77:     for (int i = 0; i < n2; i++) {
	xorl	%eax, %eax	# i
	jmp	.L28	#
.L7:
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	cmpl	$0, 116(%rsp)	#, %sfp
	jne	.L33	#,
	movq	%r10, 8(%rsp)	# _5, %sfp
# morse_base.c:50:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);
	movl	%r15d, %ecx	# _170,
	movl	$85, %edx	#,
	movl	%r15d, %r9d	# _170,
	pushq	%rax	#
	.cfi_def_cfa_offset 280
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	pushq	48(%rsp)	# %sfp
	.cfi_def_cfa_offset 288
	movq	104(%rsp), %r8	# %sfp,
	call	LAPACKE_dsyev@PLT	#
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	cmpl	$1, %r15d	#, _170
	popq	%rdx	#
	.cfi_def_cfa_offset 280
	popq	%rcx	#
	.cfi_def_cfa_offset 272
	movq	8(%rsp), %r10	# %sfp, _5
	je	.L31	#,
	jmp	.L32	#
.L43:
	movl	%esi, 24(%rsp)	# _398, %sfp
	movl	%eax, 8(%rsp)	# i, %sfp
	movq	%rdx, 16(%rsp)	# _380, %sfp
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	call	sqrt@PLT	#
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	movl	8(%rsp), %eax	# %sfp, i
	movl	24(%rsp), %esi	# %sfp, _398
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movapd	%xmm0, %xmm1	# val, _186
	xorpd	.LC6(%rip), %xmm1	#, _186
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	movsd	%xmm0, (%r12)	# val, MEM[(double *)_245]
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	movsd	%xmm0, -8(%r12,%rbx,8)	# val, MEM[(double *)_245 + -8B + _4 * 8]
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movsd	%xmm1, 0(%rbp)	# _186, MEM[(double *)_228]
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	movsd	%xmm0, -8(%rbp,%rbx,8)	# val, MEM[(double *)_228 + -8B + _4 * 8]
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	cmpl	%esi, %eax	# _398, i
	je	.L46	#,
	movq	16(%rsp), %rdx	# %sfp, _380
	movsd	.LC5(%rip), %xmm3	#, tmp348
	pxor	%xmm2, %xmm2	# tmp270
	addq	%rdx, %r12	# _380, ivtmp.114
	addq	%rdx, %rbp	# _380, ivtmp.117
	jmp	.L12	#
.L51:
# morse_base.c:93: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE40:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	-1075838976
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	0
	.long	1076101120
	.align 8
.LC5:
	.long	0
	.long	1071644672
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC6:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
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
