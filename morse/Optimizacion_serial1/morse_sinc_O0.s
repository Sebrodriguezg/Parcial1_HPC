	.file	"morse_sinc.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O0 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.section	.rodata
.LC0:
	.string	"Uso: %s <N>\n"
	.align 8
.LC12:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$192, %rsp	#,
	movl	%edi, -180(%rbp)	# argc, argc
	movq	%rsi, -192(%rbp)	# argv, argv
# morse_sinc.c:11: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp152
	movq	%rax, -8(%rbp)	# tmp152, D.57304
	xorl	%eax, %eax	# tmp152
# morse_sinc.c:12:     if (argc < 2) {
	cmpl	$1, -180(%rbp)	#, argc
	jg	.L2	#,
# morse_sinc.c:13:         printf("Uso: %s <N>\n", argv[0]);
	movq	-192(%rbp), %rax	# argv, tmp153
	movq	(%rax), %rax	# *argv_62(D), _1
	leaq	.LC0(%rip), %rdx	#, tmp154
	movq	%rax, %rsi	# _1,
	movq	%rdx, %rdi	# tmp154,
	movl	$0, %eax	#,
	call	printf@PLT	#
# morse_sinc.c:14:         return 1;
	movl	$1, %eax	#, _56
	jmp	.L13	#
.L2:
# morse_sinc.c:17:     int n = atoi(argv[1]);
	movq	-192(%rbp), %rax	# argv, tmp155
	addq	$8, %rax	#, _2
# morse_sinc.c:17:     int n = atoi(argv[1]);
	movq	(%rax), %rax	# *_2, _3
	movq	%rax, %rdi	# _3,
	call	atoi@PLT	#
	movl	%eax, -160(%rbp)	# tmp156, n
# morse_sinc.c:18:     int n2 = n * n;
	movl	-160(%rbp), %eax	# n, tmp158
	imull	%eax, %eax	# tmp158, n2_65
	movl	%eax, -156(%rbp)	# n2_65, n2
# morse_sinc.c:21:     double D_POT = 10.0;
	movsd	.LC1(%rip), %xmm0	#, tmp159
	movsd	%xmm0, -136(%rbp)	# tmp159, D_POT
# morse_sinc.c:22:     double ALPHA = 0.5;
	movsd	.LC2(%rip), %xmm0	#, tmp160
	movsd	%xmm0, -128(%rbp)	# tmp160, ALPHA
# morse_sinc.c:23:     double XMIN  = -3.0;
	movsd	.LC3(%rip), %xmm0	#, tmp161
	movsd	%xmm0, -120(%rbp)	# tmp161, XMIN
# morse_sinc.c:24:     double XMAX  = 20.0;
	movsd	.LC4(%rip), %xmm0	#, tmp162
	movsd	%xmm0, -112(%rbp)	# tmp162, XMAX
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	movsd	-112(%rbp), %xmm0	# XMAX, tmp163
	subsd	-120(%rbp), %xmm0	# XMIN, _4
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	pxor	%xmm1, %xmm1	# _5
	cvtsi2sdl	-160(%rbp), %xmm1	# n, _5
# morse_sinc.c:25:     double dx    = (XMAX - XMIN) / (double)n;
	divsd	%xmm1, %xmm0	# _5, dx_70
	movsd	%xmm0, -104(%rbp)	# dx_70, dx
# morse_sinc.c:26:     double dx2   = dx * dx;
	movsd	-104(%rbp), %xmm0	# dx, tmp166
	mulsd	%xmm0, %xmm0	# tmp166, dx2_71
	movsd	%xmm0, -96(%rbp)	# dx2_71, dx2
# morse_sinc.c:29:     double *H = (double *)calloc(n2, sizeof(double));
	movl	-156(%rbp), %eax	# n2, tmp167
	cltq
	movl	$8, %esi	#,
	movq	%rax, %rdi	# _6,
	call	calloc@PLT	#
	movq	%rax, -88(%rbp)	# tmp168, H
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	movl	-160(%rbp), %eax	# n, tmp169
	cltq
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	salq	$3, %rax	#, _8
# morse_sinc.c:30:     double *E = (double *)malloc(n * sizeof(double));
	movq	%rax, %rdi	# _8,
	call	malloc@PLT	#
	movq	%rax, -80(%rbp)	# tmp170, E
# morse_sinc.c:33:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	-48(%rbp), %rax	#, tmp171
	movq	%rax, %rsi	# tmp171,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_sinc.c:36:     for (int i = 0; i < n; i++) {
	movl	$0, -168(%rbp)	#, i
# morse_sinc.c:36:     for (int i = 0; i < n; i++) {
	jmp	.L4	#
.L11:
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	movl	-168(%rbp), %eax	# i, tmp172
	addl	$1, %eax	#, _9
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	pxor	%xmm0, %xmm0	# _10
	cvtsi2sdl	%eax, %xmm0	# _9, _10
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	mulsd	-104(%rbp), %xmm0	# dx, _11
# morse_sinc.c:37:         double x_i = XMIN + (double)(i + 1) * dx;
	movsd	-120(%rbp), %xmm1	# XMIN, tmp174
	addsd	%xmm1, %xmm0	# tmp174, x_i_87
	movsd	%xmm0, -64(%rbp)	# x_i_87, x_i
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	-128(%rbp), %xmm0	# ALPHA, tmp175
	movq	.LC5(%rip), %xmm1	#, tmp176
	xorpd	%xmm1, %xmm0	# tmp176, _12
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	mulsd	-64(%rbp), %xmm0	# x_i, _12
	movq	%xmm0, %rax	# _12, _13
	movq	%rax, %xmm0	# _13,
	call	exp@PLT	#
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	.LC6(%rip), %xmm1	#, tmp177
	subsd	%xmm0, %xmm1	# _14, tmp177
	movq	%xmm1, %rax	# tmp177, _15
	movsd	.LC7(%rip), %xmm0	#, tmp178
	movapd	%xmm0, %xmm1	# tmp178,
	movq	%rax, %xmm0	# _15,
	call	pow@PLT	#
# morse_sinc.c:38:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	-136(%rbp), %xmm1	# D_POT, tmp180
	mulsd	%xmm1, %xmm0	# tmp180, v_i_90
	movsd	%xmm0, -56(%rbp)	# v_i_90, v_i
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	movl	$0, -164(%rbp)	#, j
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	jmp	.L5	#
.L10:
# morse_sinc.c:41:             if (i == j) {
	movl	-168(%rbp), %eax	# i, tmp181
	cmpl	-164(%rbp), %eax	# j, tmp181
	jne	.L6	#,
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	-96(%rbp), %xmm1	# dx2, tmp182
	movsd	.LC8(%rip), %xmm0	#, tmp183
	mulsd	%xmm0, %xmm1	# tmp183, _17
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	.LC9(%rip), %xmm0	#, tmp184
	divsd	%xmm1, %xmm0	# _17, _18
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movl	-168(%rbp), %eax	# i, tmp185
	imull	-160(%rbp), %eax	# n, tmp185
	movl	%eax, %edx	# tmp185, _19
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movl	-164(%rbp), %eax	# j, tmp186
	addl	%edx, %eax	# _19, _20
	cltq
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	leaq	0(,%rax,8), %rdx	#, _22
	movq	-88(%rbp), %rax	# H, tmp187
	addq	%rdx, %rax	# _22, _23
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	addsd	-56(%rbp), %xmm0	# v_i, _24
# morse_sinc.c:43:                 H[i * n + j] = (M_PI * M_PI) / (6.0 * dx2) + v_i;
	movsd	%xmm0, (%rax)	# _24, *_23
	jmp	.L7	#
.L6:
# morse_sinc.c:46:                 int diff = (i + 1) - (j + 1);
	movl	-168(%rbp), %eax	# i, tmp191
	subl	-164(%rbp), %eax	# j, diff_93
	movl	%eax, -148(%rbp)	# diff_93, diff
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	movl	-148(%rbp), %eax	# diff, diff.0_25
	andl	$1, %eax	#, _26
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	testl	%eax, %eax	# _26
	jne	.L8	#,
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	movsd	.LC6(%rip), %xmm0	#, tmp192
	movsd	%xmm0, -144(%rbp)	# tmp192, sign
	jmp	.L9	#
.L8:
# morse_sinc.c:47:                 double sign = (diff % 2 == 0) ? 1.0 : -1.0;
	movsd	.LC10(%rip), %xmm0	#, tmp193
	movsd	%xmm0, -144(%rbp)	# tmp193, sign
.L9:
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	pxor	%xmm0, %xmm0	# _27
	cvtsi2sdl	-148(%rbp), %xmm0	# diff, _27
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	movapd	%xmm0, %xmm1	# _27, _27
	mulsd	-96(%rbp), %xmm1	# dx2, _27
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	pxor	%xmm0, %xmm0	# _29
	cvtsi2sdl	-148(%rbp), %xmm0	# diff, _29
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	mulsd	%xmm0, %xmm1	# _29, _30
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	movl	-168(%rbp), %eax	# i, tmp194
	imull	-160(%rbp), %eax	# n, tmp194
	movl	%eax, %edx	# tmp194, _31
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	movl	-164(%rbp), %eax	# j, tmp195
	addl	%edx, %eax	# _31, _32
	cltq
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	leaq	0(,%rax,8), %rdx	#, _34
	movq	-88(%rbp), %rax	# H, tmp196
	addq	%rdx, %rax	# _34, _35
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	movsd	-144(%rbp), %xmm0	# sign, tmp197
	divsd	%xmm1, %xmm0	# _30, _36
# morse_sinc.c:48:                 H[i * n + j] = sign / (dx2 * (double)diff * (double)diff);
	movsd	%xmm0, (%rax)	# _36, *_35
.L7:
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	addl	$1, -164(%rbp)	#, j
.L5:
# morse_sinc.c:40:         for (int j = 0; j < n; j++) {
	movl	-164(%rbp), %eax	# j, tmp198
	cmpl	-160(%rbp), %eax	# n, tmp198
	jl	.L10	#,
# morse_sinc.c:36:     for (int i = 0; i < n; i++) {
	addl	$1, -168(%rbp)	#, i
.L4:
# morse_sinc.c:36:     for (int i = 0; i < n; i++) {
	movl	-168(%rbp), %eax	# i, tmp199
	cmpl	-160(%rbp), %eax	# n, tmp199
	jl	.L11	#,
# morse_sinc.c:54:     int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	movl	-160(%rbp), %ecx	# n, tmp200
	movq	-88(%rbp), %rdx	# H, tmp201
	movl	-160(%rbp), %eax	# n, tmp202
	subq	$8, %rsp	#,
	pushq	-80(%rbp)	# E
	movl	%ecx, %r9d	# tmp200,
	movq	%rdx, %r8	# tmp201,
	movl	%eax, %ecx	# tmp202,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
	addq	$16, %rsp	#,
	movl	%eax, -152(%rbp)	# tmp203, info
# morse_sinc.c:56:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	-32(%rbp), %rax	#, tmp204
	movq	%rax, %rsi	# tmp204,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-32(%rbp), %rdx	# end.tv_sec, _37
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-48(%rbp), %rax	# start.tv_sec, _38
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	%rax, %rdx	# _38, _39
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# _40
	cvtsi2sdq	%rdx, %xmm1	# _39, _40
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-24(%rbp), %rdx	# end.tv_nsec, _41
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-40(%rbp), %rax	# start.tv_nsec, _42
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	%rax, %rdx	# _42, _43
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _44
	cvtsi2sdq	%rdx, %xmm0	# _43, _44
	movsd	.LC11(%rip), %xmm2	#, tmp205
	divsd	%xmm2, %xmm0	# tmp205, _45
# morse_sinc.c:57:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	addsd	%xmm1, %xmm0	# _40, time_used_81
	movsd	%xmm0, -72(%rbp)	# time_used_81, time_used
# morse_sinc.c:59:     if (info > 0) return 1;
	cmpl	$0, -152(%rbp)	#, info
	jle	.L12	#,
# morse_sinc.c:59:     if (info > 0) return 1;
	movl	$1, %eax	#, _56
# morse_sinc.c:59:     if (info > 0) return 1;
	jmp	.L13	#
.L12:
# morse_sinc.c:63:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-80(%rbp), %rax	# E, tmp207
	addq	$24, %rax	#, _46
# morse_sinc.c:62:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm2	# *_46, _47
# morse_sinc.c:63:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-80(%rbp), %rax	# E, tmp208
	addq	$16, %rax	#, _48
# morse_sinc.c:62:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm1	# *_48, _49
# morse_sinc.c:63:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-80(%rbp), %rax	# E, tmp209
	addq	$8, %rax	#, _50
# morse_sinc.c:62:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm0	# *_50, _51
	movq	-80(%rbp), %rax	# E, tmp210
	movq	(%rax), %rdx	# *E_75, _52
	movsd	-72(%rbp), %xmm3	# time_used, tmp211
	movl	-160(%rbp), %eax	# n, tmp212
	leaq	.LC12(%rip), %rcx	#, tmp213
	movapd	%xmm3, %xmm4	# tmp211,
	movapd	%xmm2, %xmm3	# _47,
	movapd	%xmm1, %xmm2	# _49,
	movapd	%xmm0, %xmm1	# _51,
	movq	%rdx, %xmm0	# _52,
	movl	%eax, %esi	# tmp212,
	movq	%rcx, %rdi	# tmp213,
	movl	$5, %eax	#,
	call	printf@PLT	#
# morse_sinc.c:65:     free(H); free(E);
	movq	-88(%rbp), %rax	# H, tmp214
	movq	%rax, %rdi	# tmp214,
	call	free@PLT	#
# morse_sinc.c:65:     free(H); free(E);
	movq	-80(%rbp), %rax	# E, tmp215
	movq	%rax, %rdi	# tmp215,
	call	free@PLT	#
# morse_sinc.c:66:     return 0;
	movl	$0, %eax	#, _56
.L13:
# morse_sinc.c:67: }
	movq	-8(%rbp), %rdx	# D.57304, tmp217
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp217
	je	.L14	#,
	call	__stack_chk_fail@PLT	#
.L14:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	1076101120
	.align 8
.LC2:
	.long	0
	.long	1071644672
	.align 8
.LC3:
	.long	0
	.long	-1073217536
	.align 8
.LC4:
	.long	0
	.long	1077149696
	.align 16
.LC5:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC6:
	.long	0
	.long	1072693248
	.align 8
.LC7:
	.long	0
	.long	1073741824
	.align 8
.LC8:
	.long	0
	.long	1075314688
	.align 8
.LC9:
	.long	-910277154
	.long	1076084028
	.align 8
.LC10:
	.long	0
	.long	-1074790400
	.align 8
.LC11:
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
