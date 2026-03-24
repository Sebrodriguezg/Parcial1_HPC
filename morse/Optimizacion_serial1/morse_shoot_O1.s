	.file	"morse_shoot.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O1 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.globl	fun_wave
	.type	fun_wave, @function
fun_wave:
.LFB40:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$104, %rsp	#,
	.cfi_def_cfa_offset 128
	movsd	%xmm0, 24(%rsp)	# en, %sfp
	movsd	%xmm1, 16(%rsp)	# x0, %sfp
	movsd	%xmm3, 32(%rsp)	# h, %sfp
	movsd	%xmm4, 40(%rsp)	# D, %sfp
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	testl	%edi, %edi	# n
	jle	.L6	#,
	movl	%edi, %ebp	# n, n
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	movl	$0, %ebx	#, i
# morse_shoot.c:15:     double phi = 1e-6;
	movsd	.LC0(%rip), %xmm4	#, phi
	movsd	%xmm4, 8(%rsp)	# phi, %sfp
# morse_shoot.c:14:     double psi = 0.0;
	movq	$0x000000000, (%rsp)	#, %sfp
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	xorpd	.LC2(%rip), %xmm5	#, alpha
	movsd	%xmm5, 48(%rsp)	# alpha, %sfp
	jmp	.L5	#
.L3:
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	addl	$1, %ebx	#, i
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	cmpl	%ebx, %ebp	# i, n
	je	.L1	#,
.L5:
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	48(%rsp), %xmm0	# %sfp, _70
	mulsd	16(%rsp), %xmm0	# %sfp, _70
	call	exp@PLT	#
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC3(%rip), %xmm3	#, tmp
	subsd	%xmm0, %xmm3	# _71, tmp
	movapd	%xmm3, %xmm0	# tmp, tmp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	40(%rsp), %xmm1	# %sfp, _73
	mulsd	%xmm3, %xmm1	# tmp, _73
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm1, %xmm0	# _73, _74
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	subsd	24(%rsp), %xmm0	# %sfp, _1
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	addsd	%xmm0, %xmm0	# _1, _2
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movapd	%xmm0, %xmm7	# _2, _2
	mulsd	(%rsp), %xmm7	# %sfp, _2
	movsd	%xmm7, 64(%rsp)	# _2, %sfp
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	.LC4(%rip), %xmm6	#, _3
	mulsd	32(%rsp), %xmm6	# %sfp, _3
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	%xmm6, 56(%rsp)	# _3, %sfp
	movapd	%xmm6, %xmm0	# _3, xm2_44
	addsd	16(%rsp), %xmm0	# %sfp, xm2_44
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	mulsd	48(%rsp), %xmm0	# %sfp, _64
	call	exp@PLT	#
	movapd	%xmm0, %xmm1	#, _65
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC3(%rip), %xmm0	#, tmp
	subsd	%xmm1, %xmm0	# _65, tmp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	40(%rsp), %xmm1	# %sfp, _67
	mulsd	%xmm0, %xmm1	# tmp, _67
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm1, %xmm0	# _67, _68
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	subsd	24(%rsp), %xmm0	# %sfp, _4
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	addsd	%xmm0, %xmm0	# _4, v_m
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	56(%rsp), %xmm6	# %sfp, _3
	movapd	%xmm6, %xmm1	# _3, _5
	mulsd	64(%rsp), %xmm1	# %sfp, _5
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movapd	%xmm1, %xmm2	# _5, _5
	movsd	8(%rsp), %xmm5	# %sfp, phi
	addsd	%xmm5, %xmm2	# phi, _5
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movapd	%xmm6, %xmm1	# _3, _6
	mulsd	%xmm5, %xmm1	# phi, _6
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movsd	(%rsp), %xmm3	# %sfp, <retval>
	addsd	%xmm3, %xmm1	# <retval>, _7
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movapd	%xmm1, %xmm8	# _7, _7
	mulsd	%xmm0, %xmm8	# v_m, _7
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movapd	%xmm6, %xmm1	# _3, _8
	movsd	%xmm8, 72(%rsp)	# rk2_phi, %sfp
	mulsd	%xmm8, %xmm1	#, _8
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movapd	%xmm1, %xmm9	# _8, _8
	addsd	%xmm5, %xmm9	#, _8
	movsd	%xmm9, 80(%rsp)	# _8, %sfp
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	movsd	%xmm2, 56(%rsp)	# rk2_psi, %sfp
	mulsd	%xmm2, %xmm6	#, _3
	movapd	%xmm6, %xmm1	# _3, _9
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	addsd	%xmm3, %xmm1	#, _10
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	movapd	%xmm1, %xmm10	# _10, _10
	mulsd	%xmm0, %xmm10	# v_m, _10
	movsd	%xmm10, 88(%rsp)	# _10, %sfp
# morse_shoot.c:30:         double xf1 = x + h;
	movsd	16(%rsp), %xmm4	# %sfp, x0
	addsd	32(%rsp), %xmm4	# %sfp, x0
	movsd	%xmm4, 16(%rsp)	# x0, %sfp
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm4, %xmm0	# x0, _59
	mulsd	48(%rsp), %xmm0	# %sfp, _59
	call	exp@PLT	#
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC3(%rip), %xmm14	#, tmp
	subsd	%xmm0, %xmm14	# _60, tmp
	movapd	%xmm14, %xmm0	# tmp, tmp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	40(%rsp), %xmm1	# %sfp, _62
	mulsd	%xmm14, %xmm1	# tmp, _62
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm1, %xmm0	# _62, _63
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	subsd	24(%rsp), %xmm0	# %sfp, _11
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	addsd	%xmm0, %xmm0	# _11, v_e_51
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	32(%rsp), %xmm7	# %sfp, h
	movapd	%xmm7, %xmm1	# h, _13
	movsd	80(%rsp), %xmm6	# %sfp, rk3_psi
	mulsd	%xmm6, %xmm1	# rk3_psi, _13
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	(%rsp), %xmm4	# %sfp, <retval>
	addsd	%xmm4, %xmm1	# <retval>, _14
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movapd	%xmm0, %xmm3	# v_e_51, v_e_51
	mulsd	%xmm1, %xmm3	# _14, v_e_51
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	56(%rsp), %xmm0	# %sfp, rk2_psi
	addsd	%xmm0, %xmm0	# rk2_psi, rk2_psi
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	8(%rsp), %xmm5	# %sfp, phi
	addsd	%xmm5, %xmm0	# phi, _17
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm6, %xmm6	# rk3_psi, rk3_psi
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm6, %xmm0	# _18, _19
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	movapd	%xmm7, %xmm2	# h, _12
	movsd	88(%rsp), %xmm6	# %sfp, rk3_phi
	mulsd	%xmm6, %xmm2	# rk3_phi, _12
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	addsd	%xmm5, %xmm2	# phi, rk4_psi_52
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm2, %xmm0	# rk4_psi_52, _20
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	divsd	.LC5(%rip), %xmm7	#, _15
	movapd	%xmm7, %xmm2	# _15, _15
	mulsd	%xmm7, %xmm0	# _15, _21
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movapd	%xmm0, %xmm7	# _21, _21
	addsd	%xmm4, %xmm7	# <retval>, _21
	movsd	%xmm7, (%rsp)	# <retval>, %sfp
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	72(%rsp), %xmm1	# %sfp, rk2_phi
	addsd	%xmm1, %xmm1	# rk2_phi, rk2_phi
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	64(%rsp), %xmm1	# %sfp, _23
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movapd	%xmm6, %xmm0	# rk3_phi, rk3_phi
	addsd	%xmm6, %xmm0	# rk3_phi, rk3_phi
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm0, %xmm1	# _24, _25
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm3, %xmm1	# rk4_phi, _26
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	mulsd	%xmm2, %xmm1	# _15, _27
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movapd	%xmm1, %xmm3	# _27, _27
	addsd	%xmm5, %xmm3	# phi, _27
	movsd	%xmm3, 8(%rsp)	# phi, %sfp
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	movapd	%xmm7, %xmm0	# <retval>, _28
	andpd	.LC6(%rip), %xmm0	#, _28
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	comisd	.LC7(%rip), %xmm0	#, _28
	jbe	.L3	#,
# morse_shoot.c:40:             psi /= 1e15;
	movsd	.LC7(%rip), %xmm0	#, tmp208
	divsd	%xmm0, %xmm7	# tmp208, <retval>
	movsd	%xmm7, (%rsp)	# <retval>, %sfp
# morse_shoot.c:41:             phi /= 1e15;
	divsd	%xmm0, %xmm3	# tmp208, phi
	movsd	%xmm3, 8(%rsp)	# phi, %sfp
	jmp	.L3	#
.L6:
# morse_shoot.c:14:     double psi = 0.0;
	movq	$0x000000000, (%rsp)	#, %sfp
.L1:
# morse_shoot.c:45: }
	movsd	(%rsp), %xmm0	# %sfp,
	addq	$104, %rsp	#,
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE40:
	.size	fun_wave, .-fun_wave
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC8:
	.string	"Uso: %s <NSTEPS>\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC15:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB41:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$144, %rsp	#,
	.cfi_def_cfa_offset 176
# morse_shoot.c:47: int main(int argc, char *argv[]) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp137
	movq	%rax, 136(%rsp)	# tmp137, D.6041
	xorl	%eax, %eax	# tmp137
# morse_shoot.c:48:     if (argc < 2) {
	cmpl	$1, %edi	#, argc
	jle	.L29	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_40(D) + 8B], MEM[(char * *)argv_40(D) + 8B]
	movl	$10, %edx	#,
	movl	$0, %esi	#,
	call	__isoc23_strtol@PLT	#
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, %ebp	# _64, _65
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	pxor	%xmm0, %xmm0	# _3
	cvtsi2sdl	%eax, %xmm0	# _64, _3
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	movsd	.LC9(%rip), %xmm1	#, tmp141
	divsd	%xmm0, %xmm1	# _3, tmp141
	movsd	%xmm1, 40(%rsp)	# tmp141, %sfp
# morse_shoot.c:59:     double en_levels[5] = {0};
	pxor	%xmm0, %xmm0	# tmp142
	movaps	%xmm0, 96(%rsp)	# tmp142, en_levels
	movaps	%xmm0, 112(%rsp)	# tmp142, en_levels
# morse_shoot.c:63:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	64(%rsp), %rsi	#, tmp143
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_shoot.c:66:     double f_prev = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	.LC4(%rip), %xmm5	#,
	movsd	.LC10(%rip), %xmm4	#,
	movl	%ebp, %edi	# _65,
	movsd	40(%rsp), %xmm3	# %sfp,
	movsd	.LC11(%rip), %xmm2	#,
	movsd	.LC12(%rip), %xmm1	#,
	pxor	%xmm0, %xmm0	#
	call	fun_wave	#
# morse_shoot.c:65:     double e_cur = e_min;
	movq	$0x000000000, 48(%rsp)	#, %sfp
# morse_shoot.c:60:     int level = 0;
	movl	$0, %r12d	#, level
	jmp	.L18	#
.L29:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rsi), %rdx	# *argv_40(D),
	leaq	.LC8(%rip), %rsi	#,
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
# morse_shoot.c:50:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L10	#
.L31:
# morse_shoot.c:82:                     eb = emid;
	movsd	8(%rsp), %xmm1	# %sfp, emid
	movsd	%xmm1, 32(%rsp)	# emid, %sfp
.L15:
# morse_shoot.c:78:             for (int iter = 0; iter < 100; iter++) {
	subl	$1, %ebx	#, ivtmp_20
	je	.L30	#,
.L17:
# morse_shoot.c:79:                 emid = 0.5 * (ea + eb);
	movsd	24(%rsp), %xmm1	# %sfp, _5
	addsd	32(%rsp), %xmm1	# %sfp, _5
# morse_shoot.c:79:                 emid = 0.5 * (ea + eb);
	mulsd	.LC4(%rip), %xmm1	#, _5
	movapd	%xmm1, %xmm7	# _5, emid
# morse_shoot.c:80:                 double fmid = fun_wave(emid, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	.LC4(%rip), %xmm5	#,
	movsd	.LC10(%rip), %xmm4	#,
	movl	%ebp, %edi	# _65,
	movsd	40(%rsp), %xmm3	# %sfp,
	movsd	.LC11(%rip), %xmm2	#,
	movsd	.LC12(%rip), %xmm1	#,
	movsd	%xmm7, 8(%rsp)	# emid, %sfp
	movapd	%xmm7, %xmm0	# emid,
	call	fun_wave	#
# morse_shoot.c:81:                 if (fa * fmid < 0.0) {
	movsd	16(%rsp), %xmm1	# %sfp, _6
	mulsd	%xmm0, %xmm1	# fmid, _6
# morse_shoot.c:81:                 if (fa * fmid < 0.0) {
	pxor	%xmm4, %xmm4	# tmp164
	comisd	%xmm1, %xmm4	# _6, tmp164
	ja	.L31	#,
# morse_shoot.c:85:                     fa = fmid;
	movsd	%xmm0, 16(%rsp)	# fmid, %sfp
# morse_shoot.c:84:                     ea = emid;
	movsd	8(%rsp), %xmm5	# %sfp, emid
	movsd	%xmm5, 24(%rsp)	# emid, %sfp
	jmp	.L15	#
.L30:
# morse_shoot.c:88:             if (level < 5) en_levels[level] = emid;
	movsd	56(%rsp), %xmm0	# %sfp, f_prev
	movslq	%r12d, %rax	# level, level
	movsd	8(%rsp), %xmm2	# %sfp, emid
	movsd	%xmm2, 96(%rsp,%rax,8)	# emid, en_levels[level_87]
# morse_shoot.c:89:             level++;
	addl	$1, %r12d	#, level
.L13:
# morse_shoot.c:68:     while (e_cur < e_max && level < 5) {
	movsd	.LC10(%rip), %xmm1	#, tmp169
	comisd	48(%rsp), %xmm1	# %sfp, tmp169
	jbe	.L24	#,
	cmpl	$4, %r12d	#, level
	jg	.L24	#,
.L18:
# morse_shoot.c:69:         e_cur += de;
	movsd	.LC13(%rip), %xmm3	#, e_cur
	addsd	48(%rsp), %xmm3	# %sfp, e_cur
	movapd	%xmm3, %xmm7	# e_cur, e_cur
	movsd	%xmm3, 48(%rsp)	# e_cur, %sfp
	movsd	%xmm0, 16(%rsp)	# f_prev, %sfp
# morse_shoot.c:70:         double f_cur = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	.LC4(%rip), %xmm5	#,
	movsd	.LC10(%rip), %xmm4	#,
	movl	%ebp, %edi	# _65,
	movsd	40(%rsp), %xmm3	# %sfp,
	movsd	.LC11(%rip), %xmm2	#,
	movsd	.LC12(%rip), %xmm1	#,
	movapd	%xmm7, %xmm0	# e_cur,
	call	fun_wave	#
# morse_shoot.c:72:         if (f_prev * f_cur < 0.0) {
	movsd	16(%rsp), %xmm1	# %sfp, _4
	mulsd	%xmm0, %xmm1	# f_prev, _4
# morse_shoot.c:72:         if (f_prev * f_cur < 0.0) {
	pxor	%xmm2, %xmm2	# tmp155
	comisd	%xmm1, %xmm2	# _4, tmp155
	jbe	.L13	#,
# morse_shoot.c:73:             double ea = e_cur - de;
	movsd	48(%rsp), %xmm2	# %sfp, e_cur
	movapd	%xmm2, %xmm3	# e_cur, ea
	subsd	.LC13(%rip), %xmm3	#, ea
	movsd	%xmm3, 24(%rsp)	# ea, %sfp
# morse_shoot.c:74:             double eb = e_cur;
	movsd	%xmm2, 32(%rsp)	# e_cur, %sfp
# morse_shoot.c:73:             double ea = e_cur - de;
	movl	$100, %ebx	#, ivtmp_20
# morse_shoot.c:80:                 double fmid = fun_wave(emid, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	%xmm0, 56(%rsp)	# f_prev, %sfp
	jmp	.L17	#
.L24:
# morse_shoot.c:94:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	80(%rsp), %rsi	#, tmp172
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	88(%rsp), %rax	# end.tv_nsec, end.tv_nsec
	subq	72(%rsp), %rax	# start.tv_nsec, _13
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm4, %xmm4	# _14
	cvtsi2sdq	%rax, %xmm4	# _13, _14
	divsd	.LC14(%rip), %xmm4	#, _15
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	movq	80(%rsp), %rax	# end.tv_sec, end.tv_sec
	subq	64(%rsp), %rax	# start.tv_sec, _9
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	pxor	%xmm0, %xmm0	# _10
	cvtsi2sdq	%rax, %xmm0	# _9, _10
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	addsd	%xmm0, %xmm4	# _10,
	movsd	120(%rsp), %xmm3	# en_levels[3],
	movsd	112(%rsp), %xmm2	# en_levels[2],
	movsd	104(%rsp), %xmm1	# en_levels[1],
	movsd	96(%rsp), %xmm0	# en_levels[0],
	movl	%ebp, %edx	# _65,
	leaq	.LC15(%rip), %rsi	#,
	movl	$2, %edi	#,
	movl	$5, %eax	#,
	call	__printf_chk@PLT	#
# morse_shoot.c:102:     return 0;
	movl	$0, %eax	#, <retval>
.L10:
# morse_shoot.c:103: }
	movq	136(%rsp), %rdx	# D.6041, tmp213
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp213
	jne	.L32	#,
	addq	$144, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
.L32:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-1598689907
	.long	1051772663
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC2:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC3:
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	0
	.long	1071644672
	.align 8
.LC5:
	.long	0
	.long	1075314688
	.section	.rodata.cst16
	.align 16
.LC6:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC7:
	.long	640942080
	.long	1124887541
	.align 8
.LC9:
	.long	0
	.long	1077608448
	.align 8
.LC10:
	.long	0
	.long	1076101120
	.align 8
.LC11:
	.long	0
	.long	1077477376
	.align 8
.LC12:
	.long	0
	.long	-1073741824
	.align 8
.LC13:
	.long	-755914244
	.long	1062232653
	.align 8
.LC14:
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
