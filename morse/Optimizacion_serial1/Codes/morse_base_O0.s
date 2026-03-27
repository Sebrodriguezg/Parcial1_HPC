	.file	"morse_base.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O0 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.globl	v_func
	.type	v_func, @function
v_func:
.LFB6:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$48, %rsp	#,
	movsd	%xmm0, -40(%rbp)	# x, x
# morse_base.c:9:     double D = 10.0;
	movsd	.LC0(%rip), %xmm0	#, tmp104
	movsd	%xmm0, -24(%rbp)	# tmp104, D
# morse_base.c:10:     double beta = 0.5;
	movsd	.LC1(%rip), %xmm0	#, tmp105
	movsd	%xmm0, -16(%rbp)	# tmp105, beta
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	movsd	-16(%rbp), %xmm0	# beta, tmp106
	movq	.LC2(%rip), %xmm1	#, tmp107
	xorpd	%xmm1, %xmm0	# tmp107, _1
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	mulsd	-40(%rbp), %xmm0	# x, _1
	movq	%xmm0, %rax	# _1, _2
	movq	%rax, %xmm0	# _2,
	call	exp@PLT	#
	movapd	%xmm0, %xmm1	#, _3
# morse_base.c:11:     double diff = 1.0 - exp(-beta * x);
	movsd	.LC3(%rip), %xmm0	#, tmp109
	subsd	%xmm1, %xmm0	# _3, diff_10
	movsd	%xmm0, -8(%rbp)	# diff_10, diff
# morse_base.c:12:     return D * diff * diff;
	movsd	-24(%rbp), %xmm0	# D, tmp110
	mulsd	-8(%rbp), %xmm0	# diff, _4
# morse_base.c:12:     return D * diff * diff;
	mulsd	-8(%rbp), %xmm0	# diff, _11
# morse_base.c:13: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6:
	.size	v_func, .-v_func
	.section	.rodata
.LC4:
	.string	"Uso: %s <N>\n"
	.align 8
.LC9:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$224, %rsp	#,
	movl	%edi, -196(%rbp)	# argc, argc
	movq	%rsi, -208(%rbp)	# argv, argv
# morse_base.c:15: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp223
	movq	%rax, -8(%rbp)	# tmp223, D.57338
	xorl	%eax, %eax	# tmp223
# morse_base.c:16:     if (argc < 2) {
	cmpl	$1, -196(%rbp)	#, argc
	jg	.L4	#,
# morse_base.c:17:         printf("Uso: %s <N>\n", argv[0]);
	movq	-208(%rbp), %rax	# argv, tmp224
	movq	(%rax), %rax	# *argv_145(D), _1
	leaq	.LC4(%rip), %rdx	#, tmp225
	movq	%rax, %rsi	# _1,
	movq	%rdx, %rdi	# tmp225,
	movl	$0, %eax	#,
	call	printf@PLT	#
# morse_base.c:18:         return 1;
	movl	$1, %eax	#, _134
	jmp	.L24	#
.L4:
# morse_base.c:21:     int n = atoi(argv[1]);
	movq	-208(%rbp), %rax	# argv, tmp226
	addq	$8, %rax	#, _2
# morse_base.c:21:     int n = atoi(argv[1]);
	movq	(%rax), %rax	# *_2, _3
	movq	%rax, %rdi	# _3,
	call	atoi@PLT	#
	movl	%eax, -144(%rbp)	# tmp227, n
# morse_base.c:22:     int n2 = n * n;
	movl	-144(%rbp), %eax	# n, tmp229
	imull	%eax, %eax	# tmp229, n2_148
	movl	%eax, -140(%rbp)	# n2_148, n2
# morse_base.c:25:     double *X    = (double *)calloc(n2, sizeof(double));
	movl	-140(%rbp), %eax	# n2, tmp230
	cltq
	movl	$8, %esi	#,
	movq	%rax, %rdi	# _4,
	call	calloc@PLT	#
	movq	%rax, -120(%rbp)	# tmp231, X
# morse_base.c:26:     double *P    = (double *)calloc(n2, sizeof(double));
	movl	-140(%rbp), %eax	# n2, tmp232
	cltq
	movl	$8, %esi	#,
	movq	%rax, %rdi	# _5,
	call	calloc@PLT	#
	movq	%rax, -112(%rbp)	# tmp233, P
# morse_base.c:27:     double *T    = (double *)calloc(n2, sizeof(double));
	movl	-140(%rbp), %eax	# n2, tmp234
	cltq
	movl	$8, %esi	#,
	movq	%rax, %rdi	# _6,
	call	calloc@PLT	#
	movq	%rax, -104(%rbp)	# tmp235, T
# morse_base.c:28:     double *VMAT = (double *)calloc(n2, sizeof(double));
	movl	-140(%rbp), %eax	# n2, tmp236
	cltq
	movl	$8, %esi	#,
	movq	%rax, %rdi	# _7,
	call	calloc@PLT	#
	movq	%rax, -96(%rbp)	# tmp237, VMAT
# morse_base.c:29:     double *H    = (double *)calloc(n2, sizeof(double));
	movl	-140(%rbp), %eax	# n2, tmp238
	cltq
	movl	$8, %esi	#,
	movq	%rax, %rdi	# _8,
	call	calloc@PLT	#
	movq	%rax, -88(%rbp)	# tmp239, H
# morse_base.c:30:     double *VP   = (double *)calloc(n2, sizeof(double));
	movl	-140(%rbp), %eax	# n2, tmp240
	cltq
	movl	$8, %esi	#,
	movq	%rax, %rdi	# _9,
	call	calloc@PLT	#
	movq	%rax, -80(%rbp)	# tmp241, VP
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movl	-144(%rbp), %eax	# n, tmp242
	cltq
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	salq	$3, %rax	#, _11
# morse_base.c:31:     double *E    = (double *)malloc(n * sizeof(double));
	movq	%rax, %rdi	# _11,
	call	malloc@PLT	#
	movq	%rax, -72(%rbp)	# tmp243, E
# morse_base.c:34:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	-48(%rbp), %rax	#, tmp244
	movq	%rax, %rsi	# tmp244,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	movl	$0, -180(%rbp)	#, i
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	jmp	.L6	#
.L7:
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	movl	-180(%rbp), %eax	# i, tmp245
	addl	$1, %eax	#, _12
# morse_base.c:38:         double val = sqrt((i + 1) / 2.0);
	pxor	%xmm0, %xmm0	# _13
	cvtsi2sdl	%eax, %xmm0	# _12, _13
	movsd	.LC5(%rip), %xmm1	#, tmp246
	divsd	%xmm1, %xmm0	# tmp246, _13
	movq	%xmm0, %rax	# _13, _14
	movq	%rax, %xmm0	# _14,
	call	sqrt@PLT	#
	movq	%xmm0, %rax	#, tmp247
	movq	%rax, -56(%rbp)	# tmp247, val
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	movl	-180(%rbp), %eax	# i, tmp248
	imull	-144(%rbp), %eax	# n, _15
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	movl	-180(%rbp), %edx	# i, tmp249
	addl	$1, %edx	#, _16
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	addl	%edx, %eax	# _16, _17
	cltq
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	leaq	0(,%rax,8), %rdx	#, _19
	movq	-120(%rbp), %rax	# X, tmp250
	addq	%rdx, %rax	# _19, _20
# morse_base.c:40:         X[i * n + (i + 1)] = val;
	movsd	-56(%rbp), %xmm0	# val, tmp251
	movsd	%xmm0, (%rax)	# tmp251, *_20
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	movl	-180(%rbp), %eax	# i, tmp252
	addl	$1, %eax	#, _21
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	imull	-144(%rbp), %eax	# n, _21
	movl	%eax, %edx	# _21, _22
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	movl	-180(%rbp), %eax	# i, tmp253
	addl	%edx, %eax	# _22, _23
	cltq
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	leaq	0(,%rax,8), %rdx	#, _25
	movq	-120(%rbp), %rax	# X, tmp254
	addq	%rdx, %rax	# _25, _26
# morse_base.c:41:         X[(i + 1) * n + i] = val;
	movsd	-56(%rbp), %xmm0	# val, tmp255
	movsd	%xmm0, (%rax)	# tmp255, *_26
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movl	-180(%rbp), %eax	# i, tmp256
	imull	-144(%rbp), %eax	# n, _27
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movl	-180(%rbp), %edx	# i, tmp257
	addl	$1, %edx	#, _28
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	addl	%edx, %eax	# _28, _29
	cltq
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	leaq	0(,%rax,8), %rdx	#, _31
	movq	-112(%rbp), %rax	# P, tmp258
	addq	%rdx, %rax	# _31, _32
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movsd	-56(%rbp), %xmm0	# val, tmp259
	movq	.LC2(%rip), %xmm1	#, tmp260
	xorpd	%xmm1, %xmm0	# tmp260, _33
# morse_base.c:42:         P[i * n + (i + 1)] = -val;
	movsd	%xmm0, (%rax)	# _33, *_32
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	movl	-180(%rbp), %eax	# i, tmp261
	addl	$1, %eax	#, _34
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	imull	-144(%rbp), %eax	# n, _34
	movl	%eax, %edx	# _34, _35
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	movl	-180(%rbp), %eax	# i, tmp262
	addl	%edx, %eax	# _35, _36
	cltq
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	leaq	0(,%rax,8), %rdx	#, _38
	movq	-112(%rbp), %rax	# P, tmp263
	addq	%rdx, %rax	# _38, _39
# morse_base.c:43:         P[(i + 1) * n + i] = val;
	movsd	-56(%rbp), %xmm0	# val, tmp264
	movsd	%xmm0, (%rax)	# tmp264, *_39
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	addl	$1, -180(%rbp)	#, i
.L6:
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	movl	-144(%rbp), %eax	# n, tmp265
	subl	$1, %eax	#, _40
# morse_base.c:37:     for (int i = 0; i < n - 1; i++) {
	cmpl	%eax, -180(%rbp)	# _40, i
	jl	.L7	#,
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movl	$0, -176(%rbp)	#, i
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	jmp	.L8	#
.L9:
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movl	-176(%rbp), %eax	# i, tmp266
	cltq
	leaq	0(,%rax,8), %rdx	#, _42
	movq	-120(%rbp), %rax	# X, tmp267
	addq	%rax, %rdx	# tmp267, _43
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movl	-176(%rbp), %eax	# i, tmp268
	cltq
	leaq	0(,%rax,8), %rcx	#, _45
	movq	-80(%rbp), %rax	# VP, tmp269
	addq	%rcx, %rax	# _45, _46
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movsd	(%rdx), %xmm0	# *_43, _47
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movsd	%xmm0, (%rax)	# _47, *_46
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	addl	$1, -176(%rbp)	#, i
.L8:
# morse_base.c:48:     for(int i=0; i<n2; i++) VP[i] = X[i];
	movl	-176(%rbp), %eax	# i, tmp270
	cmpl	-140(%rbp), %eax	# n2, tmp270
	jl	.L9	#,
# morse_base.c:50:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, VP, n, E);
	movl	-144(%rbp), %ecx	# n, tmp271
	movq	-80(%rbp), %rdx	# VP, tmp272
	movl	-144(%rbp), %eax	# n, tmp273
	subq	$8, %rsp	#,
	pushq	-72(%rbp)	# E
	movl	%ecx, %r9d	# tmp271,
	movq	%rdx, %r8	# tmp272,
	movl	%eax, %ecx	# tmp273,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
	addq	$16, %rsp	#,
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	movl	$0, -172(%rbp)	#, i
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	jmp	.L10	#
.L15:
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	movl	$0, -168(%rbp)	#, j
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	jmp	.L11	#
.L14:
# morse_base.c:56:             double sum = 0.0;
	pxor	%xmm0, %xmm0	# tmp274
	movsd	%xmm0, -136(%rbp)	# tmp274, sum
# morse_base.c:57:             for (int k = 0; k < n; k++) {
	movl	$0, -164(%rbp)	#, k
# morse_base.c:57:             for (int k = 0; k < n; k++) {
	jmp	.L12	#
.L13:
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movl	-172(%rbp), %eax	# i, tmp275
	imull	-144(%rbp), %eax	# n, tmp275
	movl	%eax, %edx	# tmp275, _48
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movl	-164(%rbp), %eax	# k, tmp276
	addl	%edx, %eax	# _48, _49
	cltq
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	leaq	0(,%rax,8), %rdx	#, _51
	movq	-112(%rbp), %rax	# P, tmp277
	addq	%rdx, %rax	# _51, _52
	movsd	(%rax), %xmm1	# *_52, _53
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movl	-164(%rbp), %eax	# k, tmp278
	imull	-144(%rbp), %eax	# n, tmp278
	movl	%eax, %edx	# tmp278, _54
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movl	-168(%rbp), %eax	# j, tmp279
	addl	%edx, %eax	# _54, _55
	cltq
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	leaq	0(,%rax,8), %rdx	#, _57
	movq	-112(%rbp), %rax	# P, tmp280
	addq	%rdx, %rax	# _57, _58
	movsd	(%rax), %xmm0	# *_58, _59
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	mulsd	%xmm1, %xmm0	# _53, _60
# morse_base.c:58:                 sum += P[i * n + k] * P[k * n + j];
	movsd	-136(%rbp), %xmm1	# sum, tmp282
	addsd	%xmm1, %xmm0	# tmp282, sum_201
	movsd	%xmm0, -136(%rbp)	# sum_201, sum
# morse_base.c:57:             for (int k = 0; k < n; k++) {
	addl	$1, -164(%rbp)	#, k
.L12:
# morse_base.c:57:             for (int k = 0; k < n; k++) {
	movl	-164(%rbp), %eax	# k, tmp283
	cmpl	-144(%rbp), %eax	# n, tmp283
	jl	.L13	#,
# morse_base.c:60:             T[i * n + j] = sum;
	movl	-172(%rbp), %eax	# i, tmp284
	imull	-144(%rbp), %eax	# n, tmp284
	movl	%eax, %edx	# tmp284, _61
# morse_base.c:60:             T[i * n + j] = sum;
	movl	-168(%rbp), %eax	# j, tmp285
	addl	%edx, %eax	# _61, _62
	cltq
# morse_base.c:60:             T[i * n + j] = sum;
	leaq	0(,%rax,8), %rdx	#, _64
	movq	-104(%rbp), %rax	# T, tmp286
	addq	%rdx, %rax	# _64, _65
# morse_base.c:60:             T[i * n + j] = sum;
	movsd	-136(%rbp), %xmm0	# sum, tmp287
	movsd	%xmm0, (%rax)	# tmp287, *_65
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	addl	$1, -168(%rbp)	#, j
.L11:
# morse_base.c:55:         for (int j = 0; j < n; j++) {
	movl	-168(%rbp), %eax	# j, tmp288
	cmpl	-144(%rbp), %eax	# n, tmp288
	jl	.L14	#,
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	addl	$1, -172(%rbp)	#, i
.L10:
# morse_base.c:54:     for (int i = 0; i < n; i++) {
	movl	-172(%rbp), %eax	# i, tmp289
	cmpl	-144(%rbp), %eax	# n, tmp289
	jl	.L15	#,
# morse_base.c:65:     for (int i = 0; i < n; i++) {
	movl	$0, -160(%rbp)	#, i
# morse_base.c:65:     for (int i = 0; i < n; i++) {
	jmp	.L16	#
.L21:
# morse_base.c:66:         for (int j = i; j < n; j++) {
	movl	-160(%rbp), %eax	# i, tmp290
	movl	%eax, -156(%rbp)	# tmp290, j
# morse_base.c:66:         for (int j = i; j < n; j++) {
	jmp	.L17	#
.L20:
# morse_base.c:67:             double sum = 0.0;
	pxor	%xmm0, %xmm0	# tmp291
	movsd	%xmm0, -128(%rbp)	# tmp291, sum
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	movl	$0, -152(%rbp)	#, k
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	jmp	.L18	#
.L19:
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movl	-160(%rbp), %eax	# i, tmp292
	imull	-144(%rbp), %eax	# n, tmp292
	movl	%eax, %edx	# tmp292, _66
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movl	-152(%rbp), %eax	# k, tmp293
	addl	%edx, %eax	# _66, _67
	cltq
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	leaq	0(,%rax,8), %rdx	#, _69
	movq	-80(%rbp), %rax	# VP, tmp294
	addq	%rdx, %rax	# _69, _70
	movsd	(%rax), %xmm5	# *_70, _71
	movsd	%xmm5, -216(%rbp)	# _71, %sfp
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movl	-152(%rbp), %eax	# k, tmp295
	cltq
	leaq	0(,%rax,8), %rdx	#, _73
	movq	-72(%rbp), %rax	# E, tmp296
	addq	%rdx, %rax	# _73, _74
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movq	(%rax), %rax	# *_74, _75
	movq	%rax, %xmm0	# _75,
	call	v_func	#
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movsd	-216(%rbp), %xmm1	# %sfp, _71
	mulsd	%xmm0, %xmm1	# _76, _71
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movl	-156(%rbp), %eax	# j, tmp297
	imull	-144(%rbp), %eax	# n, tmp297
	movl	%eax, %edx	# tmp297, _78
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movl	-152(%rbp), %eax	# k, tmp298
	addl	%edx, %eax	# _78, _79
	cltq
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	leaq	0(,%rax,8), %rdx	#, _81
	movq	-80(%rbp), %rax	# VP, tmp299
	addq	%rdx, %rax	# _81, _82
	movsd	(%rax), %xmm0	# *_82, _83
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	mulsd	%xmm1, %xmm0	# _77, _192
# morse_base.c:69:                 sum += VP[i * n + k] * v_func(E[k]) * VP[j * n + k];
	movsd	-128(%rbp), %xmm1	# sum, tmp301
	addsd	%xmm1, %xmm0	# tmp301, sum_193
	movsd	%xmm0, -128(%rbp)	# sum_193, sum
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	addl	$1, -152(%rbp)	#, k
.L18:
# morse_base.c:68:             for (int k = 0; k < n; k++) {
	movl	-152(%rbp), %eax	# k, tmp302
	cmpl	-144(%rbp), %eax	# n, tmp302
	jl	.L19	#,
# morse_base.c:71:             VMAT[i * n + j] = sum;
	movl	-160(%rbp), %eax	# i, tmp303
	imull	-144(%rbp), %eax	# n, tmp303
	movl	%eax, %edx	# tmp303, _84
# morse_base.c:71:             VMAT[i * n + j] = sum;
	movl	-156(%rbp), %eax	# j, tmp304
	addl	%edx, %eax	# _84, _85
	cltq
# morse_base.c:71:             VMAT[i * n + j] = sum;
	leaq	0(,%rax,8), %rdx	#, _87
	movq	-96(%rbp), %rax	# VMAT, tmp305
	addq	%rdx, %rax	# _87, _88
# morse_base.c:71:             VMAT[i * n + j] = sum;
	movsd	-128(%rbp), %xmm0	# sum, tmp306
	movsd	%xmm0, (%rax)	# tmp306, *_88
# morse_base.c:72:             VMAT[j * n + i] = sum; // Simetría
	movl	-156(%rbp), %eax	# j, tmp307
	imull	-144(%rbp), %eax	# n, tmp307
	movl	%eax, %edx	# tmp307, _89
# morse_base.c:72:             VMAT[j * n + i] = sum; // Simetría
	movl	-160(%rbp), %eax	# i, tmp308
	addl	%edx, %eax	# _89, _90
	cltq
# morse_base.c:72:             VMAT[j * n + i] = sum; // Simetría
	leaq	0(,%rax,8), %rdx	#, _92
	movq	-96(%rbp), %rax	# VMAT, tmp309
	addq	%rdx, %rax	# _92, _93
# morse_base.c:72:             VMAT[j * n + i] = sum; // Simetría
	movsd	-128(%rbp), %xmm0	# sum, tmp310
	movsd	%xmm0, (%rax)	# tmp310, *_93
# morse_base.c:66:         for (int j = i; j < n; j++) {
	addl	$1, -156(%rbp)	#, j
.L17:
# morse_base.c:66:         for (int j = i; j < n; j++) {
	movl	-156(%rbp), %eax	# j, tmp311
	cmpl	-144(%rbp), %eax	# n, tmp311
	jl	.L20	#,
# morse_base.c:65:     for (int i = 0; i < n; i++) {
	addl	$1, -160(%rbp)	#, i
.L16:
# morse_base.c:65:     for (int i = 0; i < n; i++) {
	movl	-160(%rbp), %eax	# i, tmp312
	cmpl	-144(%rbp), %eax	# n, tmp312
	jl	.L21	#,
# morse_base.c:77:     for (int i = 0; i < n2; i++) {
	movl	$0, -148(%rbp)	#, i
# morse_base.c:77:     for (int i = 0; i < n2; i++) {
	jmp	.L22	#
.L23:
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movl	-148(%rbp), %eax	# i, tmp313
	cltq
	leaq	0(,%rax,8), %rdx	#, _95
	movq	-104(%rbp), %rax	# T, tmp314
	addq	%rdx, %rax	# _95, _96
	movsd	(%rax), %xmm1	# *_96, _97
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movsd	.LC7(%rip), %xmm0	#, tmp315
	mulsd	%xmm0, %xmm1	# tmp315, _98
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movl	-148(%rbp), %eax	# i, tmp316
	cltq
	leaq	0(,%rax,8), %rdx	#, _100
	movq	-96(%rbp), %rax	# VMAT, tmp317
	addq	%rdx, %rax	# _100, _101
	movsd	(%rax), %xmm0	# *_101, _102
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movl	-148(%rbp), %eax	# i, tmp318
	cltq
	leaq	0(,%rax,8), %rdx	#, _104
	movq	-88(%rbp), %rax	# H, tmp319
	addq	%rdx, %rax	# _104, _105
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	addsd	%xmm1, %xmm0	# _98, _106
# morse_base.c:78:         H[i] = -0.5 * T[i] + VMAT[i];
	movsd	%xmm0, (%rax)	# _106, *_105
# morse_base.c:77:     for (int i = 0; i < n2; i++) {
	addl	$1, -148(%rbp)	#, i
.L22:
# morse_base.c:77:     for (int i = 0; i < n2; i++) {
	movl	-148(%rbp), %eax	# i, tmp320
	cmpl	-140(%rbp), %eax	# n2, tmp320
	jl	.L23	#,
# morse_base.c:82:     LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	movl	-144(%rbp), %ecx	# n, tmp321
	movq	-88(%rbp), %rdx	# H, tmp322
	movl	-144(%rbp), %eax	# n, tmp323
	subq	$8, %rsp	#,
	pushq	-72(%rbp)	# E
	movl	%ecx, %r9d	# tmp321,
	movq	%rdx, %r8	# tmp322,
	movl	%eax, %ecx	# tmp323,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
	addq	$16, %rsp	#,
# morse_base.c:84:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	-32(%rbp), %rax	#, tmp324
	movq	%rax, %rsi	# tmp324,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-32(%rbp), %rdx	# end.tv_sec, _107
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-48(%rbp), %rax	# start.tv_sec, _108
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	%rax, %rdx	# _108, _109
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# _110
	cvtsi2sdq	%rdx, %xmm1	# _109, _110
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-24(%rbp), %rdx	# end.tv_nsec, _111
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-40(%rbp), %rax	# start.tv_nsec, _112
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	%rax, %rdx	# _112, _113
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _114
	cvtsi2sdq	%rdx, %xmm0	# _113, _114
	movsd	.LC8(%rip), %xmm2	#, tmp325
	divsd	%xmm2, %xmm0	# tmp325, _115
# morse_base.c:85:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	addsd	%xmm1, %xmm0	# _110, time_used_172
	movsd	%xmm0, -64(%rbp)	# time_used_172, time_used
# morse_base.c:89:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-72(%rbp), %rax	# E, tmp327
	addq	$24, %rax	#, _116
# morse_base.c:88:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm2	# *_116, _117
# morse_base.c:89:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-72(%rbp), %rax	# E, tmp328
	addq	$16, %rax	#, _118
# morse_base.c:88:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm1	# *_118, _119
# morse_base.c:89:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-72(%rbp), %rax	# E, tmp329
	addq	$8, %rax	#, _120
# morse_base.c:88:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm0	# *_120, _121
	movq	-72(%rbp), %rax	# E, tmp330
	movq	(%rax), %rdx	# *E_162, _122
	movsd	-64(%rbp), %xmm3	# time_used, tmp331
	movl	-144(%rbp), %eax	# n, tmp332
	leaq	.LC9(%rip), %rcx	#, tmp333
	movapd	%xmm3, %xmm4	# tmp331,
	movapd	%xmm2, %xmm3	# _117,
	movapd	%xmm1, %xmm2	# _119,
	movapd	%xmm0, %xmm1	# _121,
	movq	%rdx, %xmm0	# _122,
	movl	%eax, %esi	# tmp332,
	movq	%rcx, %rdi	# tmp333,
	movl	$5, %eax	#,
	call	printf@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	-120(%rbp), %rax	# X, tmp334
	movq	%rax, %rdi	# tmp334,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	-112(%rbp), %rax	# P, tmp335
	movq	%rax, %rdi	# tmp335,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	-104(%rbp), %rax	# T, tmp336
	movq	%rax, %rdi	# tmp336,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	-96(%rbp), %rax	# VMAT, tmp337
	movq	%rax, %rdi	# tmp337,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	-88(%rbp), %rax	# H, tmp338
	movq	%rax, %rdi	# tmp338,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	-80(%rbp), %rax	# VP, tmp339
	movq	%rax, %rdi	# tmp339,
	call	free@PLT	#
# morse_base.c:91:     free(X); free(P); free(T); free(VMAT); free(H); free(VP); free(E);
	movq	-72(%rbp), %rax	# E, tmp340
	movq	%rax, %rdi	# tmp340,
	call	free@PLT	#
# morse_base.c:92:     return 0;
	movl	$0, %eax	#, _134
.L24:
# morse_base.c:93: }
	movq	-8(%rbp), %rdx	# D.57338, tmp342
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp342
	je	.L25	#,
	call	__stack_chk_fail@PLT	#
.L25:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1076101120
	.align 8
.LC1:
	.long	0
	.long	1071644672
	.align 16
.LC2:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC3:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1073741824
	.align 8
.LC7:
	.long	0
	.long	-1075838976
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
