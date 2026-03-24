	.file	"morse_base.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O2 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
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
	subq	$168, %rsp	#,
	.cfi_def_cfa_offset 224
# morse_base.c:15: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp219
	movq	%rax, 152(%rsp)	# tmp219, D.57798
	xorl	%eax, %eax	# tmp219
# morse_base.c:16:     if (argc < 2) {
	cmpl	$1, %edi	#, argc
	jle	.L40	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_118(D) + 8B], MEM[(char * *)argv_118(D) + 8B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	__isoc23_strtol@PLT	#
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	%rax, %r13	#, _172
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, %r14d	# _172, _173
# morse_base.c:22:     int n2 = n * n;
	imull	%eax, %eax	# _172, n2
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movslq	%eax, %rbx	# n2, _3
# morse_base.c:22:     int n2 = n * n;
	movl	%eax, 76(%rsp)	# n2, %sfp
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movq	%rbx, %rdi	# _3,
	call	calloc@PLT	#
# morse_base.c:26:     double *P    = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movq	%rax, 104(%rsp)	# X, %sfp
	movq	%rax, %r12	#, X
# morse_base.c:26:     double *P    = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:27:     double *T    = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
# morse_base.c:26:     double *P    = (double *)calloc(n2, sizeof(double));
	movq	%rax, 88(%rsp)	#, %sfp
# morse_base.c:27:     double *T    = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:28:     double *VMAT = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
# morse_base.c:27:     double *T    = (double *)calloc(n2, sizeof(double));
	movq	%rax, 80(%rsp)	#, %sfp
# morse_base.c:28:     double *VMAT = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:29:     double *H    = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
# morse_base.c:28:     double *VMAT = (double *)calloc(n2, sizeof(double));
	movq	%rax, (%rsp)	#, %sfp
# morse_base.c:29:     double *H    = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:30:     double *VP   = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
# morse_base.c:29:     double *H    = (double *)calloc(n2, sizeof(double));
	movq	%rax, 96(%rsp)	#, %sfp
# morse_base.c:30:     double *VP   = (double *)calloc(n2, sizeof(double));
	call	calloc@PLT	#
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movslq	%r13d, %rdx	# _172, _4
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	leaq	0(,%rdx,8), %r15	#, _5
	movq	%rdx, 32(%rsp)	# _4, %sfp
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movq	%r15, %rdi	# _5,
# morse_base.c:30:     double *VP   = (double *)calloc(n2, sizeof(double));
	movq	%rax, 64(%rsp)	#, %sfp
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	call	malloc@PLT	#
# morse_base.c:34:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	112(%rsp), %rsi	#, tmp229
	movl	$1, %edi	#,
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movq	%rax, %rbp	# E, E
# morse_base.c:34:     clock_gettime(CLOCK_MONOTONIC, &start);
	call	clock_gettime@PLT	#
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	cmpl	$1, %r13d	#, _172
	movq	(%rsp), %r10	# %sfp, VMAT
	jle	.L7	#,
	movq	88(%rsp), %rcx	# %sfp, P
	leaq	8(%r12), %rax	#, ivtmp.93
	movq	%r15, (%rsp)	# _5, %sfp
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	xorl	%ebx, %ebx	# i
	movl	%r13d, 16(%rsp)	# _173, %sfp
	leaq	8(%r15), %r14	#, _307
	leal	-1(%r13), %r15d	#, _325
	movsd	.LC5(%rip), %xmm3	#, tmp289
	movq	%r13, 24(%rsp)	# _172, %sfp
	movq	32(%rsp), %r13	# %sfp, _4
	leaq	8(%rcx), %r12	#, ivtmp.96
	pxor	%xmm2, %xmm2	# tmp232
	movq	%rbp, 8(%rsp)	# E, %sfp
	movq	%rax, %rbp	# ivtmp.93, ivtmp.93
	.p2align 4
	.p2align 3
.L11:
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	addl	$1, %ebx	#, i
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	pxor	%xmm0, %xmm0	# _7
	cvtsi2sdl	%ebx, %xmm0	# i, _7
	mulsd	%xmm3, %xmm0	# tmp289, _8
	ucomisd	%xmm0, %xmm2	# _8, tmp232
	ja	.L36	#,
	sqrtsd	%xmm0, %xmm0	# _8, val
.L10:
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movapd	%xmm0, %xmm1	# val, _20
	xorpd	.LC6(%rip), %xmm1	#, _20
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	movsd	%xmm0, 0(%rbp)	# val, MEM[(double *)_317]
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	movsd	%xmm0, -8(%rbp,%r13,8)	# val, MEM[(double *)_317 + -8B + _4 * 8]
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	addq	%r14, %rbp	# _307, ivtmp.93
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movsd	%xmm1, (%r12)	# _20, MEM[(double *)_320]
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	movsd	%xmm0, -8(%r12,%r13,8)	# val, MEM[(double *)_320 + -8B + _4 * 8]
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	addq	%r14, %r12	# _307, ivtmp.96
	cmpl	%r15d, %ebx	# _325, i
	jne	.L11	#,
	movq	(%rsp), %r15	# %sfp, _5
	movq	8(%rsp), %rbp	# %sfp, E
	movl	16(%rsp), %r14d	# %sfp, _173
	movq	24(%rsp), %r13	# %sfp, _172
.L12:
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movq	64(%rsp), %rbx	# %sfp, VP
	movl	76(%rsp), %edx	# %sfp, _287
	movq	%r10, (%rsp)	# VMAT, %sfp
	movq	104(%rsp), %rsi	# %sfp,
	salq	$3, %rdx	#, _286
	movq	%rbx, %rdi	# VP,
	call	memcpy@PLT	#
# morse_base.c:50:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);
	movl	%r13d, %r9d	# _172,
	movl	%r14d, %ecx	# _173,
	movl	$85, %edx	#,
	pushq	%r8	#
	.cfi_def_cfa_offset 232
	movl	$86, %esi	#,
	movq	%rbx, %r8	# VP,
	movl	$101, %edi	#,
	pushq	%rbp	# E
	.cfi_def_cfa_offset 240
	call	LAPACKE_dsyev@PLT	#
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	testl	%r13d, %r13d	# _172
	popq	%r9	#
	.cfi_def_cfa_offset 232
	popq	%r10	#
	.cfi_def_cfa_offset 224
	movq	(%rsp), %r10	# %sfp, VMAT
	jle	.L14	#,
.L26:
# morse_base.c:56:             double sum = 0.0;
	movq	88(%rsp), %rcx	# %sfp, P
	movq	80(%rsp), %r9	# %sfp, ivtmp.86
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	xorl	%edx, %edx	# i
# morse_base.c:56:             double sum = 0.0;
	movq	%rcx, %rsi	# P, ivtmp.87
	.p2align 4
	.p2align 3
.L15:
	movq	%rcx, %r8	# P, ivtmp.80
	xorl	%edi, %edi	# ivtmp.76
	.p2align 4
	.p2align 3
.L19:
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	movq	%r8, %r11	# ivtmp.80, ivtmp.73
	xorl	%eax, %eax	# ivtmp.70
# morse_base.c:56:             double sum = 0.0;
	pxor	%xmm1, %xmm1	# sum
	.p2align 5
	.p2align 4
	.p2align 3
.L16:
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movsd	(%rsi,%rax,8), %xmm0	# MEM[(double *)_115 + ivtmp.70_198 * 8], MEM[(double *)_115 + ivtmp.70_198 * 8]
	mulsd	(%r11), %xmm0	# MEM[(double *)_114], _40
# morse_base.c:57:             for (int k = 0; k < n; k++) {
	addq	$1, %rax	#, ivtmp.70
	addq	%r15, %r11	# _5, ivtmp.73
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	addsd	%xmm0, %xmm1	# _40, sum
# morse_base.c:57:             for (int k = 0; k < n; k++) {
	cmpl	%eax, %r14d	# ivtmp.70, _173
	jg	.L16	#,
# morse_base.c:60:             T[i * n + j] = sum;
	movsd	%xmm1, (%r9,%rdi,8)	# sum, MEM[(double *)_104 + ivtmp.76_112 * 8]
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	addq	$1, %rdi	#, ivtmp.76
	addq	$8, %r8	#, ivtmp.80
	cmpl	%edi, %r14d	# ivtmp.76, _173
	jg	.L19	#,
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addl	$1, %edx	#, i
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addq	%r15, %r9	# _5, ivtmp.86
	addq	%r15, %rsi	# _5, ivtmp.87
	cmpl	%r14d, %edx	# _173, i
	jl	.L15	#,
	xorl	%edi, %edi	# ivtmp.66
	xorl	%r8d, %r8d	# ivtmp.68
# morse_base.c:66:         for (int j = i; j < n; j++) {
	cmpl	%edi, %r14d	# ivtmp.66, _173
	jg	.L37	#,
# morse_base.c:65:     for (int i = 0; i < n; i++) {
	addq	$1, %rdi	#, ivtmp.66
	addl	%r13d, %r8d	# _172, ivtmp.68
	cmpl	%edi, %r14d	# ivtmp.66, _173
	jle	.L14	#,
	.p2align 4
	.p2align 3
.L37:
	movslq	%r8d, %r12	# ivtmp.68, _24
	movq	64(%rsp), %rcx	# %sfp, VP
	movl	%r8d, 72(%rsp)	# ivtmp.68, %sfp
	movq	%r15, %rdx	# _5, _5
	leaq	(%r12,%rdi), %rax	#, _252
	movq	%rdi, 40(%rsp)	# ivtmp.66, %sfp
	leaq	(%r10,%rax,8), %rsi	#, ivtmp.60
	movq	%r10, 56(%rsp)	# VMAT, %sfp
	leaq	0(,%r12,8), %rax	#, _237
	leaq	(%rcx,%rax), %r12	#, ivtmp.63
	addq	%r10, %rax	# VMAT, _227
	movq	%r13, 48(%rsp)	# _172, %sfp
	movq	%rsi, %r13	# ivtmp.60, ivtmp.60
	movq	%rax, 32(%rsp)	# _227, %sfp
	movq	%r12, %rbx	# ivtmp.63, _220
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movq	%rdi, %rax	# ivtmp.66, ivtmp.58
	.p2align 4
	.p2align 3
.L22:
	movq	%rdx, 16(%rsp)	# _5, %sfp
# morse_base.c:67:             double sum = 0.0;
	pxor	%xmm2, %xmm2	# sum
	movq	%rax, %r15	# ivtmp.58, ivtmp.58
	movq	%r13, 24(%rsp)	# ivtmp.60, %sfp
	xorl	%r13d, %r13d	# ivtmp.48
	.p2align 4
	.p2align 3
.L20:
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	movsd	.LC0(%rip), %xmm0	#, _177
	mulsd	0(%rbp,%r13,8), %xmm0	# MEM[(double *)E_134 + ivtmp.48_257 * 8], _177
	movsd	%xmm2, 8(%rsp)	# sum, %sfp
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movsd	(%rbx,%r13,8), %xmm5	# MEM[(double *)_220 + ivtmp.48_257 * 8], _51
	movsd	%xmm5, (%rsp)	# _51, %sfp
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	call	exp@PLT	#
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	movsd	.LC1(%rip), %xmm1	#, diff
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movsd	8(%rsp), %xmm2	# %sfp, sum
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	subsd	%xmm0, %xmm1	# _178, diff
# morse_base.c:12:     return D * diff * diff;
	movsd	.LC2(%rip), %xmm0	#, _180
	mulsd	%xmm1, %xmm0	# diff, _180
# morse_base.c:12:     return D * diff * diff;
	mulsd	%xmm1, %xmm0	# diff, _181
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	mulsd	(%rsp), %xmm0	# %sfp, _57
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	mulsd	(%r12,%r13,8), %xmm0	# MEM[(double *)_82 + ivtmp.48_257 * 8], _154
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	addq	$1, %r13	#, ivtmp.48
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	addsd	%xmm0, %xmm2	# _154, sum
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	cmpl	%r13d, %r14d	# ivtmp.48, _173
	jg	.L20	#,
# morse_base.c:71:             VMAT[i * n + j] = sum;
	movq	16(%rsp), %rdx	# %sfp, _5
	movq	24(%rsp), %r13	# %sfp, ivtmp.60
# morse_base.c:66:         for (int j = i; j < n; j++) {
	leaq	1(%r15), %rax	#, ivtmp.58
# morse_base.c:71:             VMAT[i * n + j] = sum;
	movq	32(%rsp), %rcx	# %sfp, _227
# morse_base.c:66:         for (int j = i; j < n; j++) {
	addq	%rdx, %r12	# _5, ivtmp.63
# morse_base.c:71:             VMAT[i * n + j] = sum;
	movsd	%xmm2, (%rcx,%r15,8)	# sum, MEM[(double *)_227 + ivtmp.58_80 * 8]
# morse_base.c:72:             VMAT[j * n + i] = sum; // Simetría
	movsd	%xmm2, 0(%r13)	# sum, MEM[(double *)_224]
# morse_base.c:66:         for (int j = i; j < n; j++) {
	addq	%rdx, %r13	# _5, ivtmp.60
	cmpl	%eax, %r14d	# ivtmp.58, _173
	jg	.L22	#,
	movq	40(%rsp), %rdi	# %sfp, ivtmp.66
	movl	72(%rsp), %r8d	# %sfp, ivtmp.68
	movq	%rdx, %r15	# _5, _5
	movq	48(%rsp), %r13	# %sfp, _172
	movq	56(%rsp), %r10	# %sfp, VMAT
# morse_base.c:65:     for (int i = 0; i < n; i++) {
	addq	$1, %rdi	#, ivtmp.66
	addl	%r13d, %r8d	# _172, ivtmp.68
	cmpl	%edi, %r14d	# ivtmp.66, _173
	jg	.L37	#,
.L14:
	movl	76(%rsp), %eax	# %sfp, n2
	cmpl	$1, %eax	#, n2
	je	.L30	#,
	movl	%eax, %edx	# n2, _147
	movsd	.LC0(%rip), %xmm1	#, tmp285
	movq	80(%rsp), %rcx	# %sfp, T
	xorl	%eax, %eax	# ivtmp.40
	shrl	%edx	# _147
	movq	96(%rsp), %rsi	# %sfp, H
	salq	$4, %rdx	#, _258
	unpcklpd	%xmm1, %xmm1	# tmp285
	.p2align 5
	.p2align 4
	.p2align 3
.L24:
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movupd	(%rcx,%rax), %xmm0	# MEM <vector(2) double> [(double *)T_126 + ivtmp.40_253 * 1], vect__77.26_269
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movupd	(%r10,%rax), %xmm6	# MEM <vector(2) double> [(double *)VMAT_128 + ivtmp.40_253 * 1], tmp397
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	mulpd	%xmm1, %xmm0	# tmp285, vect__78.27_268
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	addpd	%xmm6, %xmm0	# tmp397, vect__82.31_264
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movups	%xmm0, (%rsi,%rax)	# vect__82.31_264, MEM <vector(2) double> [(double *)H_130 + ivtmp.40_253 * 1]
	addq	$16, %rax	#, ivtmp.40
	cmpq	%rdx, %rax	# _258, ivtmp.40
	jne	.L24	#,
	movl	76(%rsp), %ecx	# %sfp, n2
	movl	%ecx, %eax	# n2, i
	andl	$-2, %eax	#, i
	andb	$1, %cl	#, n2
	je	.L27	#,
.L23:
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movq	80(%rsp), %rcx	# %sfp, T
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	cltq
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movsd	.LC0(%rip), %xmm0	#, tmp266
	mulsd	(%rcx,%rax,8), %xmm0	# *_27, _163
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movq	96(%rsp), %rcx	# %sfp, H
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	addsd	(%r10,%rax,8), %xmm0	# *_284, _281
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movsd	%xmm0, (%rcx,%rax,8)	# _281, *_282
.L27:
	movq	%r10, (%rsp)	# VMAT, %sfp
# morse_base.c:82:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 232
	movl	%r13d, %r9d	# _172,
	movl	%r14d, %ecx	# _173,
	pushq	%rbp	# E
	.cfi_def_cfa_offset 240
	movq	112(%rsp), %rbx	# %sfp, H
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	movq	%rbx, %r8	# H,
	call	LAPACKE_dsyev@PLT	#
# morse_base.c:84:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	144(%rsp), %rsi	#, tmp268
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# _90
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm4, %xmm4	# _86
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	%r14d, %edx	# _173,
	movsd	0(%rbp), %xmm0	# *E_134, *E_134
	movsd	24(%rbp), %xmm3	# MEM[(double *)E_134 + 24B],
	leaq	.LC9(%rip), %rsi	#,
	movl	$2, %edi	#,
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	152(%rsp), %rax	# end.tv_nsec, end.tv_nsec
	subq	136(%rsp), %rax	# start.tv_nsec, _89
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm1	# _89, _90
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	144(%rsp), %rax	# end.tv_sec, end.tv_sec
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movsd	16(%rbp), %xmm2	# MEM[(double *)E_134 + 16B],
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	divsd	.LC8(%rip), %xmm1	#, _91
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	128(%rsp), %rax	# start.tv_sec, _85
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm4	# _85, _86
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	addsd	%xmm1, %xmm4	# _91,
	movsd	8(%rbp), %xmm1	# MEM[(double *)E_134 + 8B],
	movl	$5, %eax	#,
	call	__printf_chk@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	120(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	104(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	96(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	16(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	%rbx, %rdi	# H,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	80(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	%rbp, %rdi	# E,
	call	free@PLT	#
# morse_base.c:92:     return 0;
	popq	%rsi	#
	.cfi_def_cfa_offset 232
	xorl	%eax, %eax	# <retval>
	popq	%rdi	#
	.cfi_def_cfa_offset 224
.L4:
# morse_base.c:93: }
	movq	152(%rsp), %rdx	# D.57798, tmp306
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp306
	jne	.L41	#,
	addq	$168, %rsp	#,
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
.L40:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rsi), %rdx	# *argv_118(D),
	movl	$2, %edi	#,
	leaq	.LC4(%rip), %rsi	#,
	call	__printf_chk@PLT	#
# morse_base.c:18:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L4	#
.L30:
# morse_base.c:77:     for (int i = 0; i < n2; i++) {
	xorl	%eax, %eax	# i
	jmp	.L23	#
.L7:
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	cmpl	$0, 76(%rsp)	#, %sfp
	jne	.L12	#,
	movq	%r10, (%rsp)	# VMAT, %sfp
# morse_base.c:50:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);
	movl	%r13d, %ecx	# _173,
	movl	$85, %edx	#,
	movl	%r13d, %r9d	# _172,
	pushq	%rax	#
	.cfi_def_cfa_offset 232
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	pushq	%rbp	# E
	.cfi_def_cfa_offset 240
	movq	80(%rsp), %r8	# %sfp,
	call	LAPACKE_dsyev@PLT	#
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	cmpl	$1, %r13d	#, _172
	popq	%rdx	#
	.cfi_def_cfa_offset 232
	popq	%rcx	#
	.cfi_def_cfa_offset 224
	movq	(%rsp), %r10	# %sfp, VMAT
	je	.L26	#,
	jmp	.L27	#
.L36:
	movq	%r10, 32(%rsp)	# VMAT, %sfp
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	call	sqrt@PLT	#
	movq	32(%rsp), %r10	# %sfp, VMAT
	pxor	%xmm2, %xmm2	# tmp232
	movsd	.LC5(%rip), %xmm3	#, tmp289
	jmp	.L10	#
.L41:
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
