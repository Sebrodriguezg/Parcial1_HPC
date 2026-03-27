	.file	"morse_base.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O1 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
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
	movapd	%xmm1, %xmm0	# diff, _3
	mulsd	.LC2(%rip), %xmm0	#, _3
# morse_base.c:12:     return D * diff * diff;
	mulsd	%xmm1, %xmm0	# diff, _8
# morse_base.c:13: }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE39:
	.size	v_func, .-v_func
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC4:
	.string	"Uso: %s <N>\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC8:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.text
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
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp215
	movq	%rax, 200(%rsp)	# tmp215, D.57772
	xorl	%eax, %eax	# tmp215
# morse_base.c:16:     if (argc < 2) {
	cmpl	$1, %edi	#, argc
	jle	.L37	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_118(D) + 8B], MEM[(char * *)argv_118(D) + 8B]
	movl	$10, %edx	#,
	movl	$0, %esi	#,
	call	__isoc23_strtol@PLT	#
	movq	%rax, %r14	# _172, _172
	movq	%rax, 152(%rsp)	# _172, %sfp
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, 96(%rsp)	# tmp358, %sfp
# morse_base.c:22:     int n2 = n * n;
	imull	%eax, %eax	# tmp360, n2
	movl	%eax, 8(%rsp)	# n2, %sfp
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movslq	%eax, %rbx	# n2, _3
	movq	%rbx, 120(%rsp)	# _3, %sfp
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
	call	calloc@PLT	#
	movq	%rax, %rbp	# X, X
	movq	%rax, 128(%rsp)	# X, %sfp
# morse_base.c:26:     double *P    = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
	call	calloc@PLT	#
	movq	%rax, %r12	# P, P
	movq	%rax, 136(%rsp)	# P, %sfp
# morse_base.c:27:     double *T    = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
	call	calloc@PLT	#
	movq	%rax, 112(%rsp)	# T, %sfp
# morse_base.c:28:     double *VMAT = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
	call	calloc@PLT	#
	movq	%rax, 80(%rsp)	# VMAT, %sfp
# morse_base.c:29:     double *H    = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
	call	calloc@PLT	#
	movq	%rax, 144(%rsp)	# H, %sfp
# morse_base.c:30:     double *VP   = (double *)calloc(n2, sizeof(double));
	movl	$8, %esi	#,
	movq	%rbx, %rdi	# _3,
	call	calloc@PLT	#
	movq	%rax, 88(%rsp)	# VP, %sfp
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movslq	%r14d, %r15	# _172, _4
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	leaq	0(,%r15,8), %rbx	#, _5
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movq	%rbx, %rdi	# _5,
	call	malloc@PLT	#
	movq	%rax, 48(%rsp)	# E, %sfp
# morse_base.c:34:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	160(%rsp), %rsi	#, tmp225
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	movq	%r14, %rdx	# _172, _172
	cmpl	$1, %r14d	#, _172
	jle	.L6	#,
	leaq	8(%rbx), %r14	#, _364
	leaq	8(%rbp), %r13	#, ivtmp.83
	addq	$8, %r12	#, ivtmp.86
	movl	%edx, %eax	# _172, tmp366
	subl	$1, %eax	#, _382
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	movl	$0, %ebp	#, i
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movq	%rbx, 16(%rsp)	# _5, %sfp
	movl	%eax, %ebx	# _382, _382
.L10:
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	addl	$1, %ebp	#, i
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	pxor	%xmm0, %xmm0	# _7
	cvtsi2sdl	%ebp, %xmm0	# i, _7
	mulsd	.LC5(%rip), %xmm0	#, _8
	pxor	%xmm2, %xmm2	# tmp367
	ucomisd	%xmm0, %xmm2	# _8, tmp367
	ja	.L34	#,
	sqrtsd	%xmm0, %xmm0	# _8, val
.L9:
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	movsd	%xmm0, 0(%r13)	# val, MEM[(double *)_374]
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	movsd	%xmm0, -8(%r13,%r15,8)	# val, MEM[(double *)_374 + -8B + _4 * 8]
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movapd	%xmm0, %xmm1	# val, _20
	xorpd	.LC6(%rip), %xmm1	#, _20
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movsd	%xmm1, (%r12)	# _20, MEM[(double *)_377]
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	movsd	%xmm0, -8(%r12,%r15,8)	# val, MEM[(double *)_377 + -8B + _4 * 8]
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	addq	%r14, %r13	# _364, ivtmp.83
	addq	%r14, %r12	# _364, ivtmp.86
	cmpl	%ebx, %ebp	# _382, i
	jne	.L10	#,
	movq	16(%rsp), %rbx	# %sfp, _5
.L11:
	movq	120(%rsp), %rax	# %sfp, _3
	leaq	0(,%rax,8), %rdx	#, _359
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	movl	$0, %eax	#, ivtmp.78
	movq	128(%rsp), %rcx	# %sfp, X
	movq	88(%rsp), %rsi	# %sfp, VP
	.p2align 5
.L13:
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movsd	(%rcx,%rax), %xmm0	# MEM[(double *)X_122 + ivtmp.78_356 * 1], MEM[(double *)X_122 + ivtmp.78_356 * 1]
	movsd	%xmm0, (%rsi,%rax)	# MEM[(double *)X_122 + ivtmp.78_356 * 1], MEM[(double *)VP_132 + ivtmp.78_356 * 1]
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	addq	$8, %rax	#, ivtmp.78
	cmpq	%rdx, %rax	# _359, ivtmp.78
	jne	.L13	#,
.L12:
# morse_base.c:50:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 280
	pushq	56(%rsp)	# %sfp
	.cfi_def_cfa_offset 288
	movq	168(%rsp), %r14	# %sfp, _172
	movl	%r14d, %r9d	# _172,
	movq	104(%rsp), %r8	# %sfp,
	movl	112(%rsp), %r13d	# %sfp, _173
	movl	%r13d, %ecx	# _173,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addq	$16, %rsp	#,
	.cfi_def_cfa_offset 272
	testl	%r14d, %r14d	# _172
	jle	.L14	#,
	movq	112(%rsp), %r10	# %sfp, ivtmp.67
	leal	-1(%r14), %r12d	#, _350
	movl	%r12d, %r8d	# _350, _351
	movq	136(%rsp), %rsi	# %sfp, P
	leaq	8(%rsi,%r8,8), %rcx	#, ivtmp.69
	movq	%rsi, %r9	# P, ivtmp.68
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	movl	$0, %edx	#, i
	movl	$0, %r11d	#, ivtmp.57
	jmp	.L15	#
.L37:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rsi), %rdx	# *argv_118(D),
	leaq	.LC4(%rip), %rsi	#,
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
# morse_base.c:18:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L3	#
.L34:
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	call	sqrt@PLT	#
	jmp	.L9	#
.L6:
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	cmpl	$0, 8(%rsp)	#, %sfp
	jle	.L12	#,
	jmp	.L11	#
.L17:
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addl	$1, %edx	#, i
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addq	%rbx, %r10	# _5, ivtmp.67
	addq	%rbx, %r9	# _5, ivtmp.68
	addq	%rbx, %rcx	# _5, ivtmp.69
	cmpl	%r13d, %edx	# _173, i
	je	.L27	#,
.L15:
	movq	%rsi, %rbp	# P, ivtmp.61
	movq	%r11, %rdi	# ivtmp.57, ivtmp.57
.L19:
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	movq	%rbp, %r14	# ivtmp.61, ivtmp.54
	movq	%r9, %rax	# ivtmp.68, ivtmp.53
# morse_base.c:56:             double sum = 0.0;
	pxor	%xmm1, %xmm1	# sum
	.p2align 5
.L16:
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movsd	(%rax), %xmm0	# MEM[(double *)_307], MEM[(double *)_307]
	mulsd	(%r14), %xmm0	# MEM[(double *)_308], _40
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	addsd	%xmm0, %xmm1	# _40, sum
# morse_base.c:57:             for (int k = 0; k < n; k++) {
	addq	$8, %rax	#, ivtmp.53
	addq	%rbx, %r14	# _5, ivtmp.54
	cmpq	%rcx, %rax	# ivtmp.69, ivtmp.53
	jne	.L16	#,
# morse_base.c:60:             T[i * n + j] = sum;
	movsd	%xmm1, (%r10,%rdi,8)	# sum, MEM[(double *)_325 + ivtmp.57_318 * 8]
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	leaq	1(%rdi), %rax	#, ivtmp.57
	addq	$8, %rbp	#, ivtmp.61
	cmpq	%r8, %rdi	# _351, ivtmp.57
	je	.L17	#,
	movq	%rax, %rdi	# ivtmp.57, ivtmp.57
	jmp	.L19	#
.L23:
	movq	48(%rsp), %r15	# %sfp, ivtmp.30
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	movq	24(%rsp), %rbx	# %sfp, ivtmp.29
# morse_base.c:67:             double sum = 0.0;
	movq	$0x000000000, 8(%rsp)	#, %sfp
	movq	%rax, 16(%rsp)	# ivtmp.38, %sfp
.L20:
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movq	(%rbx), %r12	# MEM[(double *)_101], _51
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movsd	(%r15), %xmm0	# MEM[(double *)_100], MEM[(double *)_100]
	call	v_func	#
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movq	%r12, %xmm5	# _51, _51
	mulsd	%xmm0, %xmm5	# _56, _51
	movapd	%xmm5, %xmm0	# _51, _57
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	mulsd	(%rbx,%rbp,8), %xmm0	# MEM[(double *)_101 + ivtmp.42_235 * 8], _154
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	addsd	8(%rsp), %xmm0	# %sfp, _154
	movsd	%xmm0, 8(%rsp)	# _154, %sfp
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	addq	$8, %rbx	#, ivtmp.29
	addq	$8, %r15	#, ivtmp.30
	cmpq	%r14, %rbx	# _187, ivtmp.29
	jne	.L20	#,
# morse_base.c:71:             VMAT[i * n + j] = sum;
	movq	16(%rsp), %rax	# %sfp, ivtmp.38
	movsd	%xmm0, (%rax)	# sum, MEM[(double *)_242]
# morse_base.c:72:             VMAT[j * n + i] = sum; // Simetría
	movq	32(%rsp), %rsi	# %sfp, _247
	movsd	%xmm0, (%rsi,%rbp,8)	# sum, MEM[(double *)_247 + ivtmp.42_235 * 8]
# morse_base.c:66:         for (int j = i; j < n; j++) {
	addq	$8, %rax	#, ivtmp.38
	addq	%r13, %rbp	# _4, ivtmp.42
	movq	40(%rsp), %rdx	# %sfp, _261
	cmpq	%rdx, %rax	# _261, ivtmp.38
	jne	.L23	#,
	movq	56(%rsp), %rdx	# %sfp, ivtmp.44
	movq	64(%rsp), %r15	# %sfp, ivtmp.47
	movq	72(%rsp), %r8	# %sfp, _351
.L21:
# morse_base.c:65:     for (int i = 0; i < n; i++) {
	leaq	1(%rdx), %rax	#, ivtmp.44
	addq	%r13, %r15	# _4, ivtmp.47
	cmpq	%r8, %rdx	# _351, ivtmp.44
	je	.L22	#,
	movq	%rax, %rdx	# ivtmp.44, ivtmp.44
.L18:
# morse_base.c:66:         for (int j = i; j < n; j++) {
	cmpl	%edx, 96(%rsp)	# ivtmp.44, %sfp
	jle	.L21	#,
	movslq	%r15d, %rax	# ivtmp.47, _230
	leaq	(%rax,%rdx), %rdi	#, _232
	movq	80(%rsp), %rsi	# %sfp, VMAT
	leaq	(%rsi,%rdi,8), %rcx	#, ivtmp.38
	movl	100(%rsp), %esi	# %sfp, _256
	subl	%edx, %esi	# ivtmp.44, _256
	addq	%rdi, %rsi	# _232, _257
	movq	104(%rsp), %rdi	# %sfp, _186
	leaq	(%rdi,%rsi,8), %rsi	#, _261
	movq	%rsi, 40(%rsp)	# _261, %sfp
	movq	88(%rsp), %rsi	# %sfp, VP
	leaq	(%rsi,%rax,8), %rdi	#, ivtmp.29
	movq	%rdi, 24(%rsp)	# ivtmp.29, %sfp
	addq	%r8, %rax	# _351, _194
	leaq	8(%rsi,%rax,8), %r14	#, _187
	movq	%rcx, 32(%rsp)	# ivtmp.38, %sfp
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movl	$0, %r12d	#, ivtmp.42
	movq	%rcx, %rax	# ivtmp.38, ivtmp.38
	movq	%r12, %rbp	# ivtmp.42, ivtmp.42
	movq	%rdx, 56(%rsp)	# ivtmp.44, %sfp
	movq	%r15, 64(%rsp)	# ivtmp.47, %sfp
	movq	%r8, 72(%rsp)	# _351, %sfp
	jmp	.L23	#
.L27:
	movl	$0, %edx	#, ivtmp.47
	movq	80(%rsp), %rax	# %sfp, VMAT
	leaq	8(%rax), %rbx	#, _186
	movq	%r15, %r13	# _4, _4
	movq	%rdx, %r15	# ivtmp.47, ivtmp.47
	movl	%r12d, 100(%rsp)	# _350, %sfp
	movq	%rbx, 104(%rsp)	# _186, %sfp
	jmp	.L18	#
.L14:
# morse_base.c:77:     for (int i = 0; i < n2; i++) {
	cmpl	$0, 8(%rsp)	#, %sfp
	jle	.L24	#,
.L22:
	movq	120(%rsp), %rdx	# %sfp, _3
	salq	$3, %rdx	#, _3
	movl	$0, %eax	#, ivtmp.24
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movsd	.LC0(%rip), %xmm1	#, tmp250
	movq	112(%rsp), %rcx	# %sfp, T
	movq	80(%rsp), %rsi	# %sfp, VMAT
	movq	144(%rsp), %rdi	# %sfp, H
	.p2align 5
.L25:
	movapd	%xmm1, %xmm0	# tmp250, _78
	mulsd	(%rcx,%rax), %xmm0	# MEM[(double *)T_126 + ivtmp.24_115 * 1], _78
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	addsd	(%rsi,%rax), %xmm0	# MEM[(double *)VMAT_128 + ivtmp.24_115 * 1], _82
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movsd	%xmm0, (%rdi,%rax)	# _82, MEM[(double *)H_130 + ivtmp.24_115 * 1]
# morse_base.c:77:     for (int i = 0; i < n2; i++) {
	addq	$8, %rax	#, ivtmp.24
	cmpq	%rax, %rdx	# ivtmp.24, _102
	jne	.L25	#,
.L24:
# morse_base.c:82:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 280
	movq	56(%rsp), %rbx	# %sfp, E
	pushq	%rbx	# E
	.cfi_def_cfa_offset 288
	movl	168(%rsp), %r9d	# %sfp,
	movq	160(%rsp), %r14	# %sfp, H
	movq	%r14, %r8	# H,
	movl	112(%rsp), %r15d	# %sfp, _173
	movl	%r15d, %ecx	# _173,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
# morse_base.c:84:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	192(%rsp), %rsi	#, tmp252
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	200(%rsp), %rax	# end.tv_nsec, end.tv_nsec
	subq	184(%rsp), %rax	# start.tv_nsec, _89
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# _90
	cvtsi2sdq	%rax, %xmm1	# _89, _90
	divsd	.LC7(%rip), %xmm1	#, _91
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	192(%rsp), %rax	# end.tv_sec, end.tv_sec
	subq	176(%rsp), %rax	# start.tv_sec, _85
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm4, %xmm4	# _86
	cvtsi2sdq	%rax, %xmm4	# _85, _86
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movsd	(%rbx), %xmm0	# *E_134, *E_134
	addsd	%xmm1, %xmm4	# _91,
	movsd	24(%rbx), %xmm3	# MEM[(double *)E_134 + 24B],
	movsd	16(%rbx), %xmm2	# MEM[(double *)E_134 + 16B],
	movsd	8(%rbx), %xmm1	# MEM[(double *)E_134 + 8B],
	movl	%r15d, %edx	# _173,
	leaq	.LC8(%rip), %rsi	#,
	movl	$2, %edi	#,
	movl	$5, %eax	#,
	call	__printf_chk@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	144(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	152(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	128(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	96(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	%r14, %rdi	# H,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	104(%rsp), %rdi	# %sfp,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	%rbx, %rdi	# E,
	call	free@PLT	#
# morse_base.c:92:     return 0;
	addq	$16, %rsp	#,
	.cfi_def_cfa_offset 272
	movl	$0, %eax	#, <retval>
.L3:
# morse_base.c:93: }
	movq	200(%rsp), %rdx	# D.57772, tmp283
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp283
	jne	.L38	#,
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
.L38:
	.cfi_restore_state
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
.LC7:
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
