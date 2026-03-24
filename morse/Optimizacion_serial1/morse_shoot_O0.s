	.file	"morse_shoot.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O0 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.type	v_morse, @function
v_morse:
.LFB6:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$48, %rsp	#,
	movsd	%xmm0, -24(%rbp)	# x, x
	movsd	%xmm1, -32(%rbp)	# D, D
	movsd	%xmm2, -40(%rbp)	# alpha, alpha
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	-40(%rbp), %xmm0	# alpha, tmp104
	movq	.LC0(%rip), %xmm1	#, tmp105
	xorpd	%xmm1, %xmm0	# tmp105, _1
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	mulsd	-24(%rbp), %xmm0	# x, _1
	movq	%xmm0, %rax	# _1, _2
	movq	%rax, %xmm0	# _2,
	call	exp@PLT	#
	movapd	%xmm0, %xmm1	#, _3
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC1(%rip), %xmm0	#, tmp107
	subsd	%xmm1, %xmm0	# _3, tmp_9
	movsd	%xmm0, -8(%rbp)	# tmp_9, tmp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	-32(%rbp), %xmm0	# D, tmp108
	mulsd	-8(%rbp), %xmm0	# tmp, _4
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	-8(%rbp), %xmm0	# tmp, _11
# morse_shoot.c:10: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6:
	.size	v_morse, .-v_morse
	.globl	fun_wave
	.type	fun_wave, @function
fun_wave:
.LFB7:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$192, %rsp	#,
	movsd	%xmm0, -136(%rbp)	# en, en
	movsd	%xmm1, -144(%rbp)	# x0, x0
	movsd	%xmm2, -152(%rbp)	# xf, xf
	movsd	%xmm3, -160(%rbp)	# h, h
	movl	%edi, -164(%rbp)	# n, n
	movsd	%xmm4, -176(%rbp)	# D, D
	movsd	%xmm5, -184(%rbp)	# alpha, alpha
# morse_shoot.c:14:     double psi = 0.0;
	pxor	%xmm0, %xmm0	# tmp136
	movsd	%xmm0, -120(%rbp)	# tmp136, psi
# morse_shoot.c:15:     double phi = 1e-6;
	movsd	.LC3(%rip), %xmm0	#, tmp137
	movsd	%xmm0, -112(%rbp)	# tmp137, phi
# morse_shoot.c:16:     double x = x0;
	movsd	-144(%rbp), %xmm0	# x0, tmp138
	movsd	%xmm0, -104(%rbp)	# tmp138, x
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	movl	$0, -124(%rbp)	#, i
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	jmp	.L4	#
.L7:
# morse_shoot.c:19:         double rk1_psi = phi;
	movsd	-112(%rbp), %xmm0	# phi, tmp139
	movsd	%xmm0, -96(%rbp)	# tmp139, rk1_psi
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movsd	-184(%rbp), %xmm1	# alpha, tmp140
	movsd	-176(%rbp), %xmm0	# D, tmp141
	movq	-104(%rbp), %rax	# x, tmp142
	movapd	%xmm1, %xmm2	# tmp140,
	movapd	%xmm0, %xmm1	# tmp141,
	movq	%rax, %xmm0	# tmp142,
	call	v_morse	#
	movq	%xmm0, %rax	#, _1
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movq	%rax, %xmm0	# _1, _1
	subsd	-136(%rbp), %xmm0	# en, _1
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	addsd	%xmm0, %xmm0	# _2, _3
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movsd	-120(%rbp), %xmm1	# psi, tmp144
	mulsd	%xmm1, %xmm0	# tmp144, rk1_phi_57
	movsd	%xmm0, -88(%rbp)	# rk1_phi_57, rk1_phi
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	-160(%rbp), %xmm1	# h, tmp145
	movsd	.LC4(%rip), %xmm0	#, tmp146
	mulsd	%xmm1, %xmm0	# tmp145, _4
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	-104(%rbp), %xmm1	# x, tmp148
	addsd	%xmm1, %xmm0	# tmp148, xm2_59
	movsd	%xmm0, -80(%rbp)	# xm2_59, xm2
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	movsd	-184(%rbp), %xmm1	# alpha, tmp149
	movsd	-176(%rbp), %xmm0	# D, tmp150
	movq	-80(%rbp), %rax	# xm2, tmp151
	movapd	%xmm1, %xmm2	# tmp149,
	movapd	%xmm0, %xmm1	# tmp150,
	movq	%rax, %xmm0	# tmp151,
	call	v_morse	#
	movq	%xmm0, %rax	#, _5
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	movq	%rax, %xmm0	# _5, _5
	subsd	-136(%rbp), %xmm0	# en, _5
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	addsd	%xmm0, %xmm0	# _6, v_m_61
	movsd	%xmm0, -72(%rbp)	# v_m_61, v_m
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	-160(%rbp), %xmm1	# h, tmp153
	movsd	.LC4(%rip), %xmm0	#, tmp154
	mulsd	%xmm1, %xmm0	# tmp153, _7
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	mulsd	-88(%rbp), %xmm0	# rk1_phi, _8
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	-112(%rbp), %xmm1	# phi, tmp156
	addsd	%xmm1, %xmm0	# tmp156, rk2_psi_62
	movsd	%xmm0, -64(%rbp)	# rk2_psi_62, rk2_psi
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movsd	-160(%rbp), %xmm1	# h, tmp157
	movsd	.LC4(%rip), %xmm0	#, tmp158
	mulsd	%xmm1, %xmm0	# tmp157, _9
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	mulsd	-96(%rbp), %xmm0	# rk1_psi, _10
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	addsd	-120(%rbp), %xmm0	# psi, _11
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movsd	-72(%rbp), %xmm1	# v_m, tmp160
	mulsd	%xmm1, %xmm0	# tmp160, rk2_phi_63
	movsd	%xmm0, -56(%rbp)	# rk2_phi_63, rk2_phi
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movsd	-160(%rbp), %xmm1	# h, tmp161
	movsd	.LC4(%rip), %xmm0	#, tmp162
	mulsd	%xmm1, %xmm0	# tmp161, _12
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	mulsd	-56(%rbp), %xmm0	# rk2_phi, _13
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movsd	-112(%rbp), %xmm1	# phi, tmp164
	addsd	%xmm1, %xmm0	# tmp164, rk3_psi_64
	movsd	%xmm0, -48(%rbp)	# rk3_psi_64, rk3_psi
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	movsd	-160(%rbp), %xmm1	# h, tmp165
	movsd	.LC4(%rip), %xmm0	#, tmp166
	mulsd	%xmm1, %xmm0	# tmp165, _14
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	mulsd	-64(%rbp), %xmm0	# rk2_psi, _15
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	addsd	-120(%rbp), %xmm0	# psi, _16
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	movsd	-72(%rbp), %xmm1	# v_m, tmp168
	mulsd	%xmm1, %xmm0	# tmp168, rk3_phi_65
	movsd	%xmm0, -40(%rbp)	# rk3_phi_65, rk3_phi
# morse_shoot.c:30:         double xf1 = x + h;
	movsd	-104(%rbp), %xmm0	# x, tmp170
	addsd	-160(%rbp), %xmm0	# h, xf1_66
	movsd	%xmm0, -32(%rbp)	# xf1_66, xf1
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	movsd	-184(%rbp), %xmm1	# alpha, tmp171
	movsd	-176(%rbp), %xmm0	# D, tmp172
	movq	-32(%rbp), %rax	# xf1, tmp173
	movapd	%xmm1, %xmm2	# tmp171,
	movapd	%xmm0, %xmm1	# tmp172,
	movq	%rax, %xmm0	# tmp173,
	call	v_morse	#
	movq	%xmm0, %rax	#, _17
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	movq	%rax, %xmm0	# _17, _17
	subsd	-136(%rbp), %xmm0	# en, _17
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	addsd	%xmm0, %xmm0	# _18, v_e_68
	movsd	%xmm0, -24(%rbp)	# v_e_68, v_e
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	movsd	-160(%rbp), %xmm0	# h, tmp175
	mulsd	-40(%rbp), %xmm0	# rk3_phi, _19
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	movsd	-112(%rbp), %xmm1	# phi, tmp177
	addsd	%xmm1, %xmm0	# tmp177, rk4_psi_69
	movsd	%xmm0, -16(%rbp)	# rk4_psi_69, rk4_psi
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	-160(%rbp), %xmm0	# h, tmp178
	mulsd	-48(%rbp), %xmm0	# rk3_psi, _20
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	addsd	-120(%rbp), %xmm0	# psi, _21
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	-24(%rbp), %xmm1	# v_e, tmp180
	mulsd	%xmm1, %xmm0	# tmp180, rk4_phi_70
	movsd	%xmm0, -8(%rbp)	# rk4_phi_70, rk4_phi
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	-160(%rbp), %xmm0	# h, tmp181
	movsd	.LC5(%rip), %xmm2	#, tmp182
	movapd	%xmm0, %xmm1	# tmp181, tmp181
	divsd	%xmm2, %xmm1	# tmp182, tmp181
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	-64(%rbp), %xmm0	# rk2_psi, tmp183
	addsd	%xmm0, %xmm0	# tmp183, _23
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movapd	%xmm0, %xmm2	# _23, _23
	addsd	-96(%rbp), %xmm2	# rk1_psi, _23
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	-48(%rbp), %xmm0	# rk3_psi, tmp184
	addsd	%xmm0, %xmm0	# tmp184, _25
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm2, %xmm0	# _24, _26
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	-16(%rbp), %xmm0	# rk4_psi, _27
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	mulsd	%xmm1, %xmm0	# _22, _28
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	-120(%rbp), %xmm1	# psi, tmp186
	addsd	%xmm1, %xmm0	# tmp186, psi_71
	movsd	%xmm0, -120(%rbp)	# psi_71, psi
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	-160(%rbp), %xmm0	# h, tmp187
	movsd	.LC5(%rip), %xmm2	#, tmp188
	movapd	%xmm0, %xmm1	# tmp187, tmp187
	divsd	%xmm2, %xmm1	# tmp188, tmp187
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	-56(%rbp), %xmm0	# rk2_phi, tmp189
	addsd	%xmm0, %xmm0	# tmp189, _30
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movapd	%xmm0, %xmm2	# _30, _30
	addsd	-88(%rbp), %xmm2	# rk1_phi, _30
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	-40(%rbp), %xmm0	# rk3_phi, tmp190
	addsd	%xmm0, %xmm0	# tmp190, _32
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm2, %xmm0	# _31, _33
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	-8(%rbp), %xmm0	# rk4_phi, _34
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	mulsd	%xmm1, %xmm0	# _29, _35
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	-112(%rbp), %xmm1	# phi, tmp192
	addsd	%xmm1, %xmm0	# tmp192, phi_72
	movsd	%xmm0, -112(%rbp)	# phi_72, phi
# morse_shoot.c:37:         x += h;
	movsd	-104(%rbp), %xmm0	# x, tmp194
	addsd	-160(%rbp), %xmm0	# h, x_73
	movsd	%xmm0, -104(%rbp)	# x_73, x
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	movsd	-120(%rbp), %xmm0	# psi, tmp195
	movq	.LC6(%rip), %xmm1	#, tmp196
	andpd	%xmm1, %xmm0	# tmp196, _36
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	comisd	.LC7(%rip), %xmm0	#, _36
	jbe	.L5	#,
# morse_shoot.c:40:             psi /= 1e15;
	movsd	-120(%rbp), %xmm0	# psi, tmp198
	movsd	.LC7(%rip), %xmm1	#, tmp199
	divsd	%xmm1, %xmm0	# tmp199, psi_74
	movsd	%xmm0, -120(%rbp)	# psi_74, psi
# morse_shoot.c:41:             phi /= 1e15;
	movsd	-112(%rbp), %xmm0	# phi, tmp201
	movsd	.LC7(%rip), %xmm1	#, tmp202
	divsd	%xmm1, %xmm0	# tmp202, phi_75
	movsd	%xmm0, -112(%rbp)	# phi_75, phi
.L5:
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	addl	$1, -124(%rbp)	#, i
.L4:
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	movl	-124(%rbp), %eax	# i, tmp203
	cmpl	-164(%rbp), %eax	# n, tmp203
	jl	.L7	#,
# morse_shoot.c:44:     return psi;
	movsd	-120(%rbp), %xmm0	# psi, _51
# morse_shoot.c:45: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE7:
	.size	fun_wave, .-fun_wave
	.section	.rodata
.LC8:
	.string	"Uso: %s <NSTEPS>\n"
	.align 8
.LC14:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$256, %rsp	#,
	movl	%edi, -244(%rbp)	# argc, argc
	movq	%rsi, -256(%rbp)	# argv, argv
# morse_shoot.c:47: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp121
	movq	%rax, -8(%rbp)	# tmp121, D.5675
	xorl	%eax, %eax	# tmp121
# morse_shoot.c:48:     if (argc < 2) {
	cmpl	$1, -244(%rbp)	#, argc
	jg	.L11	#,
# morse_shoot.c:49:         printf("Uso: %s <NSTEPS>\n", argv[0]);
	movq	-256(%rbp), %rax	# argv, tmp122
	movq	(%rax), %rax	# *argv_43(D), _1
	leaq	.LC8(%rip), %rdx	#, tmp123
	movq	%rax, %rsi	# _1,
	movq	%rdx, %rdi	# tmp123,
	movl	$0, %eax	#,
	call	printf@PLT	#
# morse_shoot.c:50:         return 1;
	movl	$1, %eax	#, _36
	jmp	.L25	#
.L11:
# morse_shoot.c:53:     int nsteps = atoi(argv[1]);
	movq	-256(%rbp), %rax	# argv, tmp124
	addq	$8, %rax	#, _2
# morse_shoot.c:53:     int nsteps = atoi(argv[1]);
	movq	(%rax), %rax	# *_2, _3
	movq	%rax, %rdi	# _3,
	call	atoi@PLT	#
	movl	%eax, -220(%rbp)	# tmp125, nsteps
# morse_shoot.c:54:     double d_pot = 10.0, alpha = 0.5;
	movsd	.LC9(%rip), %xmm0	#, tmp126
	movsd	%xmm0, -168(%rbp)	# tmp126, d_pot
# morse_shoot.c:54:     double d_pot = 10.0, alpha = 0.5;
	movsd	.LC4(%rip), %xmm0	#, tmp127
	movsd	%xmm0, -160(%rbp)	# tmp127, alpha
# morse_shoot.c:55:     double xmin = -2.0, xmax = 25.0;
	movsd	.LC10(%rip), %xmm0	#, tmp128
	movsd	%xmm0, -152(%rbp)	# tmp128, xmin
# morse_shoot.c:55:     double xmin = -2.0, xmax = 25.0;
	movsd	.LC11(%rip), %xmm0	#, tmp129
	movsd	%xmm0, -144(%rbp)	# tmp129, xmax
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	movsd	-144(%rbp), %xmm0	# xmax, tmp130
	subsd	-152(%rbp), %xmm0	# xmin, _4
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	pxor	%xmm1, %xmm1	# _5
	cvtsi2sdl	-220(%rbp), %xmm1	# nsteps, _5
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	divsd	%xmm1, %xmm0	# _5, dx_50
	movsd	%xmm0, -136(%rbp)	# dx_50, dx
# morse_shoot.c:58:     double e_min = 0.0, e_max = 10.0, de = 0.001;
	pxor	%xmm0, %xmm0	# tmp132
	movsd	%xmm0, -128(%rbp)	# tmp132, e_min
# morse_shoot.c:58:     double e_min = 0.0, e_max = 10.0, de = 0.001;
	movsd	.LC9(%rip), %xmm0	#, tmp133
	movsd	%xmm0, -120(%rbp)	# tmp133, e_max
# morse_shoot.c:58:     double e_min = 0.0, e_max = 10.0, de = 0.001;
	movsd	.LC12(%rip), %xmm0	#, tmp134
	movsd	%xmm0, -112(%rbp)	# tmp134, de
# morse_shoot.c:59:     double en_levels[5] = {0};
	pxor	%xmm0, %xmm0	# tmp135
	movaps	%xmm0, -48(%rbp)	# tmp135, en_levels
	movaps	%xmm0, -32(%rbp)	# tmp135, en_levels
	movq	%xmm0, -16(%rbp)	# tmp135, en_levels
# morse_shoot.c:60:     int level = 0;
	movl	$0, -228(%rbp)	#, level
# morse_shoot.c:63:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	-80(%rbp), %rax	#, tmp136
	movq	%rax, %rsi	# tmp136,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_shoot.c:65:     double e_cur = e_min;
	movsd	-128(%rbp), %xmm0	# e_min, tmp137
	movsd	%xmm0, -216(%rbp)	# tmp137, e_cur
# morse_shoot.c:66:     double f_prev = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	-160(%rbp), %xmm4	# alpha, tmp138
	movsd	-168(%rbp), %xmm3	# d_pot, tmp139
	movl	-220(%rbp), %edx	# nsteps, tmp140
	movsd	-136(%rbp), %xmm2	# dx, tmp141
	movsd	-144(%rbp), %xmm1	# xmax, tmp142
	movsd	-152(%rbp), %xmm0	# xmin, tmp143
	movq	-216(%rbp), %rax	# e_cur, tmp144
	movapd	%xmm4, %xmm5	# tmp138,
	movapd	%xmm3, %xmm4	# tmp139,
	movl	%edx, %edi	# tmp140,
	movapd	%xmm2, %xmm3	# tmp141,
	movapd	%xmm1, %xmm2	# tmp142,
	movapd	%xmm0, %xmm1	# tmp143,
	movq	%rax, %xmm0	# tmp144,
	call	fun_wave	#
	movq	%xmm0, %rax	#, tmp145
	movq	%rax, -208(%rbp)	# tmp145, f_prev
# morse_shoot.c:68:     while (e_cur < e_max && level < 5) {
	jmp	.L13	#
.L24:
# morse_shoot.c:69:         e_cur += de;
	movsd	-216(%rbp), %xmm0	# e_cur, tmp147
	addsd	-112(%rbp), %xmm0	# de, e_cur_61
	movsd	%xmm0, -216(%rbp)	# e_cur_61, e_cur
# morse_shoot.c:70:         double f_cur = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	-160(%rbp), %xmm4	# alpha, tmp148
	movsd	-168(%rbp), %xmm3	# d_pot, tmp149
	movl	-220(%rbp), %edx	# nsteps, tmp150
	movsd	-136(%rbp), %xmm2	# dx, tmp151
	movsd	-144(%rbp), %xmm1	# xmax, tmp152
	movsd	-152(%rbp), %xmm0	# xmin, tmp153
	movq	-216(%rbp), %rax	# e_cur, tmp154
	movapd	%xmm4, %xmm5	# tmp148,
	movapd	%xmm3, %xmm4	# tmp149,
	movl	%edx, %edi	# tmp150,
	movapd	%xmm2, %xmm3	# tmp151,
	movapd	%xmm1, %xmm2	# tmp152,
	movapd	%xmm0, %xmm1	# tmp153,
	movq	%rax, %xmm0	# tmp154,
	call	fun_wave	#
	movq	%xmm0, %rax	#, tmp155
	movq	%rax, -104(%rbp)	# tmp155, f_cur
# morse_shoot.c:72:         if (f_prev * f_cur < 0.0) {
	movsd	-208(%rbp), %xmm0	# f_prev, tmp156
	movapd	%xmm0, %xmm1	# tmp156, tmp156
	mulsd	-104(%rbp), %xmm1	# f_cur, tmp156
# morse_shoot.c:72:         if (f_prev * f_cur < 0.0) {
	pxor	%xmm0, %xmm0	# tmp157
	comisd	%xmm1, %xmm0	# _6, tmp157
	jbe	.L14	#,
# morse_shoot.c:73:             double ea = e_cur - de;
	movsd	-216(%rbp), %xmm0	# e_cur, tmp159
	subsd	-112(%rbp), %xmm0	# de, ea_64
	movsd	%xmm0, -200(%rbp)	# ea_64, ea
# morse_shoot.c:74:             double eb = e_cur;
	movsd	-216(%rbp), %xmm0	# e_cur, tmp160
	movsd	%xmm0, -192(%rbp)	# tmp160, eb
# morse_shoot.c:75:             double fa = f_prev;
	movsd	-208(%rbp), %xmm0	# f_prev, tmp161
	movsd	%xmm0, -184(%rbp)	# tmp161, fa
# morse_shoot.c:78:             for (int iter = 0; iter < 100; iter++) {
	movl	$0, -224(%rbp)	#, iter
# morse_shoot.c:78:             for (int iter = 0; iter < 100; iter++) {
	jmp	.L16	#
.L20:
# morse_shoot.c:79:                 emid = 0.5 * (ea + eb);
	movsd	-200(%rbp), %xmm0	# ea, tmp162
	movapd	%xmm0, %xmm1	# tmp162, tmp162
	addsd	-192(%rbp), %xmm1	# eb, tmp162
# morse_shoot.c:79:                 emid = 0.5 * (ea + eb);
	movsd	.LC4(%rip), %xmm0	#, tmp164
	mulsd	%xmm1, %xmm0	# _7, emid_70
	movsd	%xmm0, -176(%rbp)	# emid_70, emid
# morse_shoot.c:80:                 double fmid = fun_wave(emid, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	-160(%rbp), %xmm4	# alpha, tmp165
	movsd	-168(%rbp), %xmm3	# d_pot, tmp166
	movl	-220(%rbp), %edx	# nsteps, tmp167
	movsd	-136(%rbp), %xmm2	# dx, tmp168
	movsd	-144(%rbp), %xmm1	# xmax, tmp169
	movsd	-152(%rbp), %xmm0	# xmin, tmp170
	movq	-176(%rbp), %rax	# emid, tmp171
	movapd	%xmm4, %xmm5	# tmp165,
	movapd	%xmm3, %xmm4	# tmp166,
	movl	%edx, %edi	# tmp167,
	movapd	%xmm2, %xmm3	# tmp168,
	movapd	%xmm1, %xmm2	# tmp169,
	movapd	%xmm0, %xmm1	# tmp170,
	movq	%rax, %xmm0	# tmp171,
	call	fun_wave	#
	movq	%xmm0, %rax	#, tmp172
	movq	%rax, -96(%rbp)	# tmp172, fmid
# morse_shoot.c:81:                 if (fa * fmid < 0.0) {
	movsd	-184(%rbp), %xmm0	# fa, tmp173
	movapd	%xmm0, %xmm1	# tmp173, tmp173
	mulsd	-96(%rbp), %xmm1	# fmid, tmp173
# morse_shoot.c:81:                 if (fa * fmid < 0.0) {
	pxor	%xmm0, %xmm0	# tmp174
	comisd	%xmm1, %xmm0	# _8, tmp174
	jbe	.L30	#,
# morse_shoot.c:82:                     eb = emid;
	movsd	-176(%rbp), %xmm0	# emid, tmp175
	movsd	%xmm0, -192(%rbp)	# tmp175, eb
	jmp	.L19	#
.L30:
# morse_shoot.c:84:                     ea = emid;
	movsd	-176(%rbp), %xmm0	# emid, tmp176
	movsd	%xmm0, -200(%rbp)	# tmp176, ea
# morse_shoot.c:85:                     fa = fmid;
	movsd	-96(%rbp), %xmm0	# fmid, tmp177
	movsd	%xmm0, -184(%rbp)	# tmp177, fa
.L19:
# morse_shoot.c:78:             for (int iter = 0; iter < 100; iter++) {
	addl	$1, -224(%rbp)	#, iter
.L16:
# morse_shoot.c:78:             for (int iter = 0; iter < 100; iter++) {
	cmpl	$99, -224(%rbp)	#, iter
	jle	.L20	#,
# morse_shoot.c:88:             if (level < 5) en_levels[level] = emid;
	cmpl	$4, -228(%rbp)	#, level
	jg	.L21	#,
# morse_shoot.c:88:             if (level < 5) en_levels[level] = emid;
	movl	-228(%rbp), %eax	# level, tmp179
	cltq
	movsd	-176(%rbp), %xmm0	# emid, tmp180
	movsd	%xmm0, -48(%rbp,%rax,8)	# tmp180, en_levels[level_23]
.L21:
# morse_shoot.c:89:             level++;
	addl	$1, -228(%rbp)	#, level
.L14:
# morse_shoot.c:91:         f_prev = f_cur;
	movsd	-104(%rbp), %xmm0	# f_cur, tmp181
	movsd	%xmm0, -208(%rbp)	# tmp181, f_prev
.L13:
# morse_shoot.c:68:     while (e_cur < e_max && level < 5) {
	movsd	-120(%rbp), %xmm0	# e_max, tmp182
	comisd	-216(%rbp), %xmm0	# e_cur, tmp182
	jbe	.L22	#,
# morse_shoot.c:68:     while (e_cur < e_max && level < 5) {
	cmpl	$4, -228(%rbp)	#, level
	jle	.L24	#,
.L22:
# morse_shoot.c:94:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	-64(%rbp), %rax	#, tmp183
	movq	%rax, %rsi	# tmp183,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	movq	-64(%rbp), %rdx	# end.tv_sec, _9
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	movq	-80(%rbp), %rax	# start.tv_sec, _10
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	subq	%rax, %rdx	# _10, _11
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	pxor	%xmm1, %xmm1	# _12
	cvtsi2sdq	%rdx, %xmm1	# _11, _12
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-56(%rbp), %rdx	# end.tv_nsec, _13
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	-72(%rbp), %rax	# start.tv_nsec, _14
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	%rax, %rdx	# _14, _15
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _16
	cvtsi2sdq	%rdx, %xmm0	# _15, _16
	movsd	.LC13(%rip), %xmm2	#, tmp184
	divsd	%xmm2, %xmm0	# tmp184, _17
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	addsd	%xmm1, %xmm0	# _12, time_used_79
	movsd	%xmm0, -88(%rbp)	# time_used_79, time_used
# morse_shoot.c:98:     printf("%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n", 
	movsd	-24(%rbp), %xmm2	# en_levels[3], _18
	movsd	-32(%rbp), %xmm1	# en_levels[2], _19
	movsd	-40(%rbp), %xmm0	# en_levels[1], _20
	movq	-48(%rbp), %rdx	# en_levels[0], _21
	movsd	-88(%rbp), %xmm3	# time_used, tmp186
	movl	-220(%rbp), %eax	# nsteps, tmp187
	leaq	.LC14(%rip), %rcx	#, tmp188
	movapd	%xmm3, %xmm4	# tmp186,
	movapd	%xmm2, %xmm3	# _18,
	movapd	%xmm1, %xmm2	# _19,
	movapd	%xmm0, %xmm1	# _20,
	movq	%rdx, %xmm0	# _21,
	movl	%eax, %esi	# tmp187,
	movq	%rcx, %rdi	# tmp188,
	movl	$5, %eax	#,
	call	printf@PLT	#
# morse_shoot.c:102:     return 0;
	movl	$0, %eax	#, _36
.L25:
# morse_shoot.c:103: }
	movq	-8(%rbp), %rdx	# D.5675, tmp190
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp190
	je	.L26	#,
	call	__stack_chk_fail@PLT	#
.L26:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.section	.rodata
	.align 16
.LC0:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC3:
	.long	-1598689907
	.long	1051772663
	.align 8
.LC4:
	.long	0
	.long	1071644672
	.align 8
.LC5:
	.long	0
	.long	1075314688
	.align 16
.LC6:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC7:
	.long	640942080
	.long	1124887541
	.align 8
.LC9:
	.long	0
	.long	1076101120
	.align 8
.LC10:
	.long	0
	.long	-1073741824
	.align 8
.LC11:
	.long	0
	.long	1077477376
	.align 8
.LC12:
	.long	-755914244
	.long	1062232653
	.align 8
.LC13:
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
