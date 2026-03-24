	.file	"morse_fdm.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O0 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.section	.rodata
.LC0:
	.string	"Uso: %s <N>\n"
	.align 8
.LC10:
	.string	"Error: LAPACK no pudo converger.\n"
	.align 8
.LC11:
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
	subq	$176, %rsp	#,
	movl	%edi, -164(%rbp)	# argc, argc
	movq	%rsi, -176(%rbp)	# argv, argv
# morse_fdm.c:7: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp155
	movq	%rax, -8(%rbp)	# tmp155, D.57294
	xorl	%eax, %eax	# tmp155
# morse_fdm.c:8:     if (argc < 2) {
	cmpl	$1, -164(%rbp)	#, argc
	jg	.L2	#,
# morse_fdm.c:9:         printf("Uso: %s <N>\n", argv[0]);
	movq	-176(%rbp), %rax	# argv, tmp156
	movq	(%rax), %rax	# *argv_62(D), _1
	leaq	.LC0(%rip), %rdx	#, tmp157
	movq	%rax, %rsi	# _1,
	movq	%rdx, %rdi	# tmp157,
	movl	$0, %eax	#,
	call	printf@PLT	#
# morse_fdm.c:10:         return 1;
	movl	$1, %eax	#, _57
	jmp	.L8	#
.L2:
# morse_fdm.c:13:     int n = atoi(argv[1]);
	movq	-176(%rbp), %rax	# argv, tmp158
	addq	$8, %rax	#, _2
# morse_fdm.c:13:     int n = atoi(argv[1]);
	movq	(%rax), %rax	# *_2, _3
	movq	%rax, %rdi	# _3,
	call	atoi@PLT	#
	movl	%eax, -156(%rbp)	# tmp159, n
# morse_fdm.c:14:     int n2 = n * n;
	movl	-156(%rbp), %eax	# n, tmp161
	imull	%eax, %eax	# tmp161, n2_65
	movl	%eax, -152(%rbp)	# n2_65, n2
# morse_fdm.c:17:     double D_POT = 10.0;
	movsd	.LC1(%rip), %xmm0	#, tmp162
	movsd	%xmm0, -144(%rbp)	# tmp162, D_POT
# morse_fdm.c:18:     double ALPHA = 0.5;
	movsd	.LC2(%rip), %xmm0	#, tmp163
	movsd	%xmm0, -136(%rbp)	# tmp163, ALPHA
# morse_fdm.c:19:     double XMIN  = -2.0;
	movsd	.LC3(%rip), %xmm0	#, tmp164
	movsd	%xmm0, -128(%rbp)	# tmp164, XMIN
# morse_fdm.c:20:     double XMAX  = 15.0;
	movsd	.LC4(%rip), %xmm0	#, tmp165
	movsd	%xmm0, -120(%rbp)	# tmp165, XMAX
# morse_fdm.c:23:     double dx = (XMAX - XMIN) / (double)(n + 1);
	movsd	-120(%rbp), %xmm0	# XMAX, tmp166
	subsd	-128(%rbp), %xmm0	# XMIN, _4
# morse_fdm.c:23:     double dx = (XMAX - XMIN) / (double)(n + 1);
	movl	-156(%rbp), %eax	# n, tmp167
	addl	$1, %eax	#, _5
# morse_fdm.c:23:     double dx = (XMAX - XMIN) / (double)(n + 1);
	pxor	%xmm1, %xmm1	# _6
	cvtsi2sdl	%eax, %xmm1	# _5, _6
# morse_fdm.c:23:     double dx = (XMAX - XMIN) / (double)(n + 1);
	divsd	%xmm1, %xmm0	# _6, dx_70
	movsd	%xmm0, -112(%rbp)	# dx_70, dx
# morse_fdm.c:24:     double dx2 = dx * dx;
	movsd	-112(%rbp), %xmm0	# dx, tmp170
	mulsd	%xmm0, %xmm0	# tmp170, dx2_71
	movsd	%xmm0, -104(%rbp)	# dx2_71, dx2
# morse_fdm.c:27:     double *H = (double *)calloc(n2, sizeof(double));
	movl	-152(%rbp), %eax	# n2, tmp171
	cltq
	movl	$8, %esi	#,
	movq	%rax, %rdi	# _7,
	call	calloc@PLT	#
	movq	%rax, -96(%rbp)	# tmp172, H
# morse_fdm.c:28:     double *E = (double *)malloc(n * sizeof(double));
	movl	-156(%rbp), %eax	# n, tmp173
	cltq
# morse_fdm.c:28:     double *E = (double *)malloc(n * sizeof(double));
	salq	$3, %rax	#, _9
# morse_fdm.c:28:     double *E = (double *)malloc(n * sizeof(double));
	movq	%rax, %rdi	# _9,
	call	malloc@PLT	#
	movq	%rax, -88(%rbp)	# tmp174, E
# morse_fdm.c:31:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	-48(%rbp), %rax	#, tmp175
	movq	%rax, %rsi	# tmp175,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_fdm.c:34:     for (int i = 0; i < n; i++) {
	movl	$0, -160(%rbp)	#, i
# morse_fdm.c:34:     for (int i = 0; i < n; i++) {
	jmp	.L4	#
.L6:
# morse_fdm.c:35:         double x_i = XMIN + (double)(i + 1) * dx;
	movl	-160(%rbp), %eax	# i, tmp176
	addl	$1, %eax	#, _10
# morse_fdm.c:35:         double x_i = XMIN + (double)(i + 1) * dx;
	pxor	%xmm0, %xmm0	# _11
	cvtsi2sdl	%eax, %xmm0	# _10, _11
# morse_fdm.c:35:         double x_i = XMIN + (double)(i + 1) * dx;
	mulsd	-112(%rbp), %xmm0	# dx, _12
# morse_fdm.c:35:         double x_i = XMIN + (double)(i + 1) * dx;
	movsd	-128(%rbp), %xmm1	# XMIN, tmp178
	addsd	%xmm1, %xmm0	# tmp178, x_i_88
	movsd	%xmm0, -72(%rbp)	# x_i_88, x_i
# morse_fdm.c:36:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	-136(%rbp), %xmm0	# ALPHA, tmp179
	movq	.LC5(%rip), %xmm1	#, tmp180
	xorpd	%xmm1, %xmm0	# tmp180, _13
# morse_fdm.c:36:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	mulsd	-72(%rbp), %xmm0	# x_i, _13
	movq	%xmm0, %rax	# _13, _14
	movq	%rax, %xmm0	# _14,
	call	exp@PLT	#
# morse_fdm.c:36:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	.LC6(%rip), %xmm1	#, tmp181
	subsd	%xmm0, %xmm1	# _15, tmp181
	movq	%xmm1, %rax	# tmp181, _16
	movsd	.LC7(%rip), %xmm0	#, tmp182
	movapd	%xmm0, %xmm1	# tmp182,
	movq	%rax, %xmm0	# _16,
	call	pow@PLT	#
# morse_fdm.c:36:         double v_i = D_POT * pow(1.0 - exp(-ALPHA * x_i), 2);
	movsd	-144(%rbp), %xmm1	# D_POT, tmp184
	mulsd	%xmm1, %xmm0	# tmp184, v_i_91
	movsd	%xmm0, -64(%rbp)	# v_i_91, v_i
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	movsd	.LC6(%rip), %xmm0	#, tmp185
	divsd	-104(%rbp), %xmm0	# dx2, _18
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	movl	-160(%rbp), %eax	# i, tmp186
	imull	-156(%rbp), %eax	# n, tmp186
	movl	%eax, %edx	# tmp186, _19
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	movl	-160(%rbp), %eax	# i, tmp187
	addl	%edx, %eax	# _19, _20
	cltq
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	leaq	0(,%rax,8), %rdx	#, _22
	movq	-96(%rbp), %rax	# H, tmp188
	addq	%rdx, %rax	# _22, _23
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	addsd	-64(%rbp), %xmm0	# v_i, _24
# morse_fdm.c:39:         H[i * n + i] = (1.0 / dx2) + v_i;
	movsd	%xmm0, (%rax)	# _24, *_23
# morse_fdm.c:42:         if (i < n - 1) {
	movl	-156(%rbp), %eax	# n, tmp189
	subl	$1, %eax	#, _25
# morse_fdm.c:42:         if (i < n - 1) {
	cmpl	%eax, -160(%rbp)	# _25, i
	jge	.L5	#,
# morse_fdm.c:43:             double off_diag = -1.0 / (2.0 * dx2);
	movsd	-104(%rbp), %xmm0	# dx2, tmp190
	movapd	%xmm0, %xmm1	# tmp190, tmp190
	addsd	%xmm0, %xmm1	# tmp190, tmp190
# morse_fdm.c:43:             double off_diag = -1.0 / (2.0 * dx2);
	movsd	.LC8(%rip), %xmm0	#, tmp192
	divsd	%xmm1, %xmm0	# _26, off_diag_93
	movsd	%xmm0, -56(%rbp)	# off_diag_93, off_diag
# morse_fdm.c:44:             H[i * n + (i + 1)] = off_diag;
	movl	-160(%rbp), %eax	# i, tmp193
	imull	-156(%rbp), %eax	# n, _27
# morse_fdm.c:44:             H[i * n + (i + 1)] = off_diag;
	movl	-160(%rbp), %edx	# i, tmp194
	addl	$1, %edx	#, _28
# morse_fdm.c:44:             H[i * n + (i + 1)] = off_diag;
	addl	%edx, %eax	# _28, _29
	cltq
# morse_fdm.c:44:             H[i * n + (i + 1)] = off_diag;
	leaq	0(,%rax,8), %rdx	#, _31
	movq	-96(%rbp), %rax	# H, tmp195
	addq	%rdx, %rax	# _31, _32
# morse_fdm.c:44:             H[i * n + (i + 1)] = off_diag;
	movsd	-56(%rbp), %xmm0	# off_diag, tmp196
	movsd	%xmm0, (%rax)	# tmp196, *_32
# morse_fdm.c:45:             H[(i + 1) * n + i] = off_diag;
	movl	-160(%rbp), %eax	# i, tmp197
	addl	$1, %eax	#, _33
# morse_fdm.c:45:             H[(i + 1) * n + i] = off_diag;
	imull	-156(%rbp), %eax	# n, _33
	movl	%eax, %edx	# _33, _34
# morse_fdm.c:45:             H[(i + 1) * n + i] = off_diag;
	movl	-160(%rbp), %eax	# i, tmp198
	addl	%edx, %eax	# _34, _35
	cltq
# morse_fdm.c:45:             H[(i + 1) * n + i] = off_diag;
	leaq	0(,%rax,8), %rdx	#, _37
	movq	-96(%rbp), %rax	# H, tmp199
	addq	%rdx, %rax	# _37, _38
# morse_fdm.c:45:             H[(i + 1) * n + i] = off_diag;
	movsd	-56(%rbp), %xmm0	# off_diag, tmp200
	movsd	%xmm0, (%rax)	# tmp200, *_38
.L5:
# morse_fdm.c:34:     for (int i = 0; i < n; i++) {
	addl	$1, -160(%rbp)	#, i
.L4:
# morse_fdm.c:34:     for (int i = 0; i < n; i++) {
	movl	-160(%rbp), %eax	# i, tmp201
	cmpl	-156(%rbp), %eax	# n, tmp201
	jl	.L6	#,
# morse_fdm.c:51:     int info = LAPACKE_dsyev(LAPACK_ROW_MAJOR, 'V', 'U', n, H, n, E);
	movl	-156(%rbp), %ecx	# n, tmp202
	movq	-96(%rbp), %rdx	# H, tmp203
	movl	-156(%rbp), %eax	# n, tmp204
	subq	$8, %rsp	#,
	pushq	-88(%rbp)	# E
	movl	%ecx, %r9d	# tmp202,
	movq	%rdx, %r8	# tmp203,
	movl	%eax, %ecx	# tmp204,
	movl	$85, %edx	#,
	movl	$86, %esi	#,
	movl	$101, %edi	#,
	call	LAPACKE_dsyev@PLT	#
	addq	$16, %rsp	#,
	movl	%eax, -148(%rbp)	# tmp205, info
# morse_fdm.c:53:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	-32(%rbp), %rax	#, tmp206
	movq	%rax, %rsi	# tmp206,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-32(%rbp), %rdx	# end.tv_sec, _39
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-48(%rbp), %rax	# start.tv_sec, _40
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	%rax, %rdx	# _40, _41
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# _42
	cvtsi2sdq	%rdx, %xmm1	# _41, _42
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-24(%rbp), %rdx	# end.tv_nsec, _43
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-40(%rbp), %rax	# start.tv_nsec, _44
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	%rax, %rdx	# _44, _45
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _46
	cvtsi2sdq	%rdx, %xmm0	# _45, _46
	movsd	.LC9(%rip), %xmm2	#, tmp207
	divsd	%xmm2, %xmm0	# tmp207, _47
# morse_fdm.c:54:     double time_used = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
	addsd	%xmm1, %xmm0	# _42, time_used_81
	movsd	%xmm0, -80(%rbp)	# time_used_81, time_used
# morse_fdm.c:56:     if (info > 0) {
	cmpl	$0, -148(%rbp)	#, info
	jle	.L7	#,
# morse_fdm.c:57:         fprintf(stderr, "Error: LAPACK no pudo converger.\n");
	movq	stderr(%rip), %rax	# stderr, stderr.0_48
	leaq	.LC10(%rip), %rdi	#, tmp209
	movq	%rax, %rcx	# stderr.0_48,
	movl	$33, %edx	#,
	movl	$1, %esi	#,
	call	fwrite@PLT	#
# morse_fdm.c:58:         return 1;
	movl	$1, %eax	#, _57
	jmp	.L8	#
.L7:
# morse_fdm.c:63:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-88(%rbp), %rax	# E, tmp210
	addq	$24, %rax	#, _49
# morse_fdm.c:62:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm2	# *_49, _50
# morse_fdm.c:63:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-88(%rbp), %rax	# E, tmp211
	addq	$16, %rax	#, _51
# morse_fdm.c:62:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm1	# *_51, _52
# morse_fdm.c:63:             n, E[0], E[1], E[2], E[3], time_used);
	movq	-88(%rbp), %rax	# E, tmp212
	addq	$8, %rax	#, _53
# morse_fdm.c:62:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	(%rax), %xmm0	# *_53, _54
	movq	-88(%rbp), %rax	# E, tmp213
	movq	(%rax), %rdx	# *E_75, _55
	movsd	-80(%rbp), %xmm3	# time_used, tmp214
	movl	-156(%rbp), %eax	# n, tmp215
	leaq	.LC11(%rip), %rcx	#, tmp216
	movapd	%xmm3, %xmm4	# tmp214,
	movapd	%xmm2, %xmm3	# _50,
	movapd	%xmm1, %xmm2	# _52,
	movapd	%xmm0, %xmm1	# _54,
	movq	%rdx, %xmm0	# _55,
	movl	%eax, %esi	# tmp215,
	movq	%rcx, %rdi	# tmp216,
	movl	$5, %eax	#,
	call	printf@PLT	#
# morse_fdm.c:65:     free(H);
	movq	-96(%rbp), %rax	# H, tmp217
	movq	%rax, %rdi	# tmp217,
	call	free@PLT	#
# morse_fdm.c:66:     free(E);
	movq	-88(%rbp), %rax	# E, tmp218
	movq	%rax, %rdi	# tmp218,
	call	free@PLT	#
# morse_fdm.c:67:     return 0;
	movl	$0, %eax	#, _57
.L8:
# morse_fdm.c:68: }
	movq	-8(%rbp), %rdx	# D.57294, tmp220
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp220
	je	.L9	#,
	call	__stack_chk_fail@PLT	#
.L9:
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
	.long	-1073741824
	.align 8
.LC4:
	.long	0
	.long	1076756480
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
	.long	-1074790400
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
