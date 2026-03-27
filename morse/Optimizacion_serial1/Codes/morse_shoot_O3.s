	.file	"morse_shoot.c"
# GNU C23 (Ubuntu 15.2.0-4ubuntu4) version 15.2.0 (x86_64-linux-gnu)
#	compiled by GNU C version 15.2.0, GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.27-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -D_FORTIFY_SOURCE=3 -mtune=generic -march=x86-64 -O3 -foffload-options=-l_GCC_m -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection -fzero-init-padding-bits=all
	.text
	.p2align 4
	.type	fun_wave.constprop.0, @function
fun_wave.constprop.0:
.LFB42:
	.cfi_startproc
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	testl	%edi, %edi	# n
	jle	.L6	#,
# morse_shoot.c:13: double fun_wave(double en, double x0, double xf, double h, int n, double D, double alpha) {
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# morse_shoot.c:14:     double psi = 0.0;
	pxor	%xmm4, %xmm4	# <retval>
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	xorl	%ebp, %ebp	# i
# morse_shoot.c:13: double fun_wave(double en, double x0, double xf, double h, int n, double D, double alpha) {
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%edi, %ebx	# n, n
	subq	$88, %rsp	#,
	.cfi_def_cfa_offset 112
# morse_shoot.c:16:     double x = x0;
	movsd	.LC2(%rip), %xmm3	#, x
# morse_shoot.c:15:     double phi = 1e-6;
	movsd	.LC0(%rip), %xmm5	#, phi
	movsd	%xmm0, 8(%rsp)	# en, %sfp
# morse_shoot.c:16:     double x = x0;
	movsd	%xmm3, (%rsp)	# x, %sfp
	movsd	%xmm1, 16(%rsp)	# h, %sfp
	.p2align 4
	.p2align 3
.L5:
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC3(%rip), %xmm7	#, _3
	mulsd	(%rsp), %xmm7	# %sfp, _3
	movsd	%xmm5, 48(%rsp)	# phi, %sfp
	movsd	%xmm4, 24(%rsp)	# <retval>, %sfp
	movapd	%xmm7, %xmm0	# _3, _3
	call	exp@PLT	#
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC4(%rip), %xmm6	#, tmp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	.LC5(%rip), %xmm1	#, _6
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movsd	24(%rsp), %xmm4	# %sfp, <retval>
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	subsd	%xmm0, %xmm6	#, tmp
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movsd	%xmm4, 40(%rsp)	# <retval>, %sfp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm6, %xmm1	# tmp, _6
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm6, %xmm0	# tmp, tmp
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	.LC6(%rip), %xmm6	#, _14
	mulsd	16(%rsp), %xmm6	# %sfp, _14
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm1, %xmm0	# _6, _7
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	subsd	8(%rsp), %xmm0	# %sfp, _9
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	%xmm6, 32(%rsp)	# _14, %sfp
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	addsd	%xmm0, %xmm0	# _9, _10
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movapd	%xmm0, %xmm1	# _10, _10
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	(%rsp), %xmm0	# %sfp, xm2_15
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	mulsd	%xmm4, %xmm1	# <retval>, _10
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	addsd	%xmm6, %xmm0	# _14, xm2_15
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	mulsd	.LC3(%rip), %xmm0	#, _16
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movsd	%xmm1, 24(%rsp)	# _10, %sfp
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	call	exp@PLT	#
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC4(%rip), %xmm7	#, tmp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	.LC5(%rip), %xmm1	#, _19
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	32(%rsp), %xmm6	# %sfp, _14
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	48(%rsp), %xmm5	# %sfp, phi
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	subsd	%xmm0, %xmm7	#, tmp
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	24(%rsp), %xmm3	# %sfp, _23
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movsd	40(%rsp), %xmm4	# %sfp, <retval>
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movsd	%xmm5, 64(%rsp)	# phi, %sfp
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	mulsd	%xmm6, %xmm3	# _14, _23
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm7, %xmm1	# tmp, _19
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm7, %xmm0	# tmp, tmp
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movapd	%xmm6, %xmm7	# _14, _26
	mulsd	%xmm5, %xmm7	# phi, _26
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	addsd	%xmm5, %xmm3	# phi, rk2_psi
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm1, %xmm0	# _19, _20
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	subsd	8(%rsp), %xmm0	# %sfp, _21
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movapd	%xmm7, %xmm2	# _26, _26
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movapd	%xmm6, %xmm7	# _14, _29
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	addsd	%xmm4, %xmm2	# <retval>, _27
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	mulsd	%xmm3, %xmm6	# rk2_psi, _31
	movsd	%xmm3, 48(%rsp)	# rk2_psi, %sfp
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	addsd	%xmm0, %xmm0	# _21, v_m
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	mulsd	%xmm0, %xmm2	# v_m, rk2_phi
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	addsd	%xmm4, %xmm6	# <retval>, _32
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	mulsd	%xmm0, %xmm6	# v_m, rk3_phi
# morse_shoot.c:30:         double xf1 = x + h;
	movsd	(%rsp), %xmm0	# %sfp, x
	addsd	16(%rsp), %xmm0	# %sfp, x
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	mulsd	%xmm2, %xmm7	# rk2_phi, _29
	movsd	%xmm2, 72(%rsp)	# rk2_phi, %sfp
# morse_shoot.c:30:         double xf1 = x + h;
	movsd	%xmm0, (%rsp)	# x, %sfp
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	movsd	%xmm6, 32(%rsp)	# rk3_phi, %sfp
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	addsd	%xmm5, %xmm7	# phi, rk3_psi
# morse_shoot.c:30:         double xf1 = x + h;
	movapd	%xmm0, %xmm5	# x, x
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC3(%rip), %xmm0	#, _35
	mulsd	%xmm5, %xmm0	# x, _35
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movsd	%xmm7, 56(%rsp)	# rk3_psi, %sfp
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	call	exp@PLT	#
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	.LC5(%rip), %xmm5	#, _38
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	48(%rsp), %xmm3	# %sfp, rk2_psi
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm0, %xmm1	#, _36
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC4(%rip), %xmm0	#, tmp
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	16(%rsp), %xmm2	# %sfp, h
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm3, %xmm3	# rk2_psi, _48
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	56(%rsp), %xmm7	# %sfp, rk3_psi
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	movsd	32(%rsp), %xmm6	# %sfp, rk3_phi
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	subsd	%xmm1, %xmm0	# _36, tmp
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movapd	%xmm2, %xmm8	# h, _44
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	40(%rsp), %xmm4	# %sfp, <retval>
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	mulsd	%xmm7, %xmm8	# rk3_psi, _44
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm7, %xmm7	# rk3_psi, _50
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm0, %xmm5	# tmp, _38
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	addsd	%xmm4, %xmm8	# <retval>, _45
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm5, %xmm0	# _38, _39
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	64(%rsp), %xmm5	# %sfp, phi
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	subsd	8(%rsp), %xmm0	# %sfp, _40
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm5, %xmm3	# phi, _49
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	addsd	%xmm0, %xmm0	# _40, v_e_41
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm7, %xmm3	# _50, _51
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	movapd	%xmm2, %xmm7	# h, _42
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	divsd	.LC7(%rip), %xmm2	#, _47
	movapd	%xmm2, %xmm1	# _47, _47
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	mulsd	%xmm6, %xmm7	# rk3_phi, _42
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm6, %xmm6	# rk3_phi, _57
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	mulsd	%xmm8, %xmm0	# _45, rk4_phi
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	24(%rsp), %xmm8	# %sfp, rk1_phi
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	addsd	%xmm5, %xmm7	# phi, rk4_psi_43
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm7, %xmm3	# rk4_psi_43, _52
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	mulsd	%xmm2, %xmm3	# _47, _53
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	72(%rsp), %xmm2	# %sfp, rk2_phi
	addsd	%xmm2, %xmm2	# rk2_phi, _55
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm2, %xmm8	# _55, rk1_phi
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm3, %xmm4	# _53, <retval>
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm6, %xmm8	# _57, _58
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm0, %xmm8	# rk4_phi, _59
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	movapd	%xmm4, %xmm0	# <retval>, _62
	andpd	.LC8(%rip), %xmm0	#, _62
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	comisd	.LC9(%rip), %xmm0	#, _62
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	mulsd	%xmm1, %xmm8	# _47, _60
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm8, %xmm5	# _60, phi
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	jbe	.L3	#,
# morse_shoot.c:40:             psi /= 1e15;
	divsd	.LC9(%rip), %xmm4	#, <retval>
# morse_shoot.c:41:             phi /= 1e15;
	divsd	.LC9(%rip), %xmm5	#, phi
.L3:
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	addl	$1, %ebp	#, i
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	cmpl	%ebx, %ebp	# n, i
	jne	.L5	#,
# morse_shoot.c:45: }
	addq	$88, %rsp	#,
	.cfi_def_cfa_offset 24
	movapd	%xmm4, %xmm0	# <retval>,
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L6:
	.cfi_restore 3
	.cfi_restore 6
# morse_shoot.c:14:     double psi = 0.0;
	pxor	%xmm4, %xmm4	# <retval>
# morse_shoot.c:45: }
	movapd	%xmm4, %xmm0	# <retval>,
	ret	
	.cfi_endproc
.LFE42:
	.size	fun_wave.constprop.0, .-fun_wave.constprop.0
	.p2align 4
	.globl	fun_wave
	.type	fun_wave, @function
fun_wave:
.LFB40:
	.cfi_startproc
	endbr64	
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	testl	%edi, %edi	# n
	jle	.L19	#,
# morse_shoot.c:13: double fun_wave(double en, double x0, double xf, double h, int n, double D, double alpha) {
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# morse_shoot.c:14:     double psi = 0.0;
	pxor	%xmm7, %xmm7	# <retval>
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	xorl	%ebp, %ebp	# i
# morse_shoot.c:13: double fun_wave(double en, double x0, double xf, double h, int n, double D, double alpha) {
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%edi, %ebx	# n, n
	subq	$120, %rsp	#,
	.cfi_def_cfa_offset 144
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	xorpd	.LC10(%rip), %xmm5	#, _34
# morse_shoot.c:15:     double phi = 1e-6;
	movsd	.LC0(%rip), %xmm8	#, phi
	movsd	%xmm4, 16(%rsp)	# D, %sfp
	movapd	%xmm5, %xmm11	# _34, _70
	movsd	%xmm0, 8(%rsp)	# en, %sfp
	mulsd	%xmm1, %xmm11	# x0, _70
	movsd	%xmm5, 48(%rsp)	# _34, %sfp
	movsd	%xmm1, 24(%rsp)	# x0, %sfp
	movsd	%xmm3, 32(%rsp)	# h, %sfp
	.p2align 4
	.p2align 3
.L18:
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm11, %xmm0	# _70,
	movsd	%xmm8, 72(%rsp)	# phi, %sfp
	movsd	%xmm7, 40(%rsp)	# <retval>, %sfp
	call	exp@PLT	#
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movsd	40(%rsp), %xmm7	# %sfp, <retval>
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	.LC6(%rip), %xmm6	#, _3
	mulsd	32(%rsp), %xmm6	# %sfp, _3
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm0, %xmm1	#, _71
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	movsd	24(%rsp), %xmm5	# %sfp, xm2_44
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC4(%rip), %xmm0	#, tmp
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	movsd	%xmm7, 64(%rsp)	# <retval>, %sfp
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	subsd	%xmm1, %xmm0	# _71, tmp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	16(%rsp), %xmm1	# %sfp, _73
# morse_shoot.c:22:         double xm2 = x + 0.5 * h;
	addsd	%xmm6, %xmm5	# _3, xm2_44
	movsd	%xmm6, 56(%rsp)	# _3, %sfp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm0, %xmm1	# tmp, _73
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm1, %xmm0	# _73, _74
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	subsd	8(%rsp), %xmm0	# %sfp, _1
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	addsd	%xmm0, %xmm0	# _1, _2
# morse_shoot.c:20:         double rk1_phi = 2.0 * (v_morse(x, D, alpha) - en) * psi;
	mulsd	%xmm7, %xmm0	# <retval>, _2
	movsd	%xmm0, 40(%rsp)	# _2, %sfp
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	48(%rsp), %xmm0	# %sfp, xm2_44
	mulsd	%xmm5, %xmm0	# xm2_44, xm2_44
	call	exp@PLT	#
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC4(%rip), %xmm7	#, tmp
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	16(%rsp), %xmm1	# %sfp, _67
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	56(%rsp), %xmm6	# %sfp, _3
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	72(%rsp), %xmm8	# %sfp, phi
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	subsd	%xmm0, %xmm7	#, tmp
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	movsd	40(%rsp), %xmm4	# %sfp, _5
# morse_shoot.c:30:         double xf1 = x + h;
	movsd	24(%rsp), %xmm5	# %sfp, x0
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movapd	%xmm6, %xmm9	# _3, _8
# morse_shoot.c:30:         double xf1 = x + h;
	addsd	32(%rsp), %xmm5	# %sfp, x0
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	48(%rsp), %xmm11	# %sfp, _70
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	movsd	%xmm8, 96(%rsp)	# phi, %sfp
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	mulsd	%xmm6, %xmm4	# _3, _5
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm7, %xmm1	# tmp, _67
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm7, %xmm0	# tmp, tmp
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movapd	%xmm6, %xmm7	# _3, _6
	mulsd	%xmm8, %xmm7	# phi, _6
# morse_shoot.c:30:         double xf1 = x + h;
	movsd	%xmm5, 24(%rsp)	# x0, %sfp
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	mulsd	%xmm5, %xmm11	# x0, _70
# morse_shoot.c:24:         double rk2_psi = phi + 0.5 * h * rk1_phi;
	addsd	%xmm8, %xmm4	# phi, rk2_psi
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm1, %xmm0	# _67, _68
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	subsd	8(%rsp), %xmm0	# %sfp, _4
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movapd	%xmm7, %xmm2	# _6, _6
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	movsd	64(%rsp), %xmm7	# %sfp, <retval>
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	mulsd	%xmm4, %xmm6	# rk2_psi, _9
	movsd	%xmm4, 80(%rsp)	# rk2_psi, %sfp
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	addsd	%xmm7, %xmm2	# <retval>, _7
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	movsd	%xmm7, 72(%rsp)	# <retval>, %sfp
# morse_shoot.c:23:         double v_m = 2.0 * (v_morse(xm2, D, alpha) - en);
	addsd	%xmm0, %xmm0	# _4, v_m
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	%xmm11, 56(%rsp)	# _70, %sfp
# morse_shoot.c:25:         double rk2_phi = v_m * (psi + 0.5 * h * rk1_psi);
	mulsd	%xmm0, %xmm2	# v_m, rk2_phi
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	addsd	%xmm7, %xmm6	# <retval>, _10
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	mulsd	%xmm0, %xmm6	# v_m, rk3_phi
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm11, %xmm0	# _70,
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	mulsd	%xmm2, %xmm9	# rk2_phi, _8
	movsd	%xmm2, 104(%rsp)	# rk2_phi, %sfp
# morse_shoot.c:28:         double rk3_phi = v_m * (psi + 0.5 * h * rk2_psi);
	movsd	%xmm6, 64(%rsp)	# rk3_phi, %sfp
# morse_shoot.c:27:         double rk3_psi = phi + 0.5 * h * rk2_phi;
	addsd	%xmm8, %xmm9	# phi, rk3_psi
	movsd	%xmm9, 88(%rsp)	# rk3_psi, %sfp
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	call	exp@PLT	#
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	movsd	16(%rsp), %xmm10	# %sfp, _62
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	80(%rsp), %xmm4	# %sfp, rk2_psi
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movapd	%xmm0, %xmm1	#, _60
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	movsd	.LC4(%rip), %xmm0	#, tmp
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	32(%rsp), %xmm3	# %sfp, h
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm4, %xmm4	# rk2_psi, _16
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	movsd	96(%rsp), %xmm8	# %sfp, phi
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	88(%rsp), %xmm9	# %sfp, rk3_psi
# morse_shoot.c:8:     double tmp = 1.0 - exp(-alpha * x);
	subsd	%xmm1, %xmm0	# _60, tmp
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	movsd	64(%rsp), %xmm6	# %sfp, rk3_phi
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movsd	72(%rsp), %xmm7	# %sfp, <retval>
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	104(%rsp), %xmm2	# %sfp, rk2_phi
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	movsd	56(%rsp), %xmm11	# %sfp, _70
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm8, %xmm4	# phi, _17
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm0, %xmm10	# tmp, _62
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm2, %xmm2	# rk2_phi, _22
# morse_shoot.c:9:     return D * tmp * tmp;  // más eficiente que pow
	mulsd	%xmm10, %xmm0	# _62, _63
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	movapd	%xmm3, %xmm10	# h, _13
	mulsd	%xmm9, %xmm10	# rk3_psi, _13
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm9, %xmm9	# rk3_psi, _18
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	subsd	8(%rsp), %xmm0	# %sfp, _11
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm9, %xmm4	# _18, _19
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	movapd	%xmm3, %xmm9	# h, _12
# morse_shoot.c:31:         double v_e = 2.0 * (v_morse(xf1, D, alpha) - en);
	addsd	%xmm0, %xmm0	# _11, v_e_51
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	divsd	.LC7(%rip), %xmm3	#, _15
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	mulsd	%xmm6, %xmm9	# rk3_phi, _12
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm6, %xmm6	# rk3_phi, _24
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	addsd	%xmm7, %xmm10	# <retval>, _14
# morse_shoot.c:33:         double rk4_phi = v_e * (psi + h * rk3_psi);
	mulsd	%xmm10, %xmm0	# _14, rk4_phi
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	movsd	40(%rsp), %xmm10	# %sfp, rk1_phi
# morse_shoot.c:32:         double rk4_psi = phi + h * rk3_phi;
	addsd	%xmm8, %xmm9	# phi, rk4_psi_52
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm2, %xmm10	# _22, rk1_phi
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm9, %xmm4	# rk4_psi_52, _20
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm6, %xmm10	# _24, _25
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	mulsd	%xmm3, %xmm4	# _15, _21
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm0, %xmm10	# rk4_phi, _26
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	mulsd	%xmm3, %xmm10	# _15, _27
# morse_shoot.c:35:         psi += (h / 6.0) * (rk1_psi + 2.0 * rk2_psi + 2.0 * rk3_psi + rk4_psi);
	addsd	%xmm4, %xmm7	# _21, <retval>
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	movapd	%xmm7, %xmm0	# <retval>, _28
	andpd	.LC8(%rip), %xmm0	#, _28
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	comisd	.LC9(%rip), %xmm0	#, _28
# morse_shoot.c:36:         phi += (h / 6.0) * (rk1_phi + 2.0 * rk2_phi + 2.0 * rk3_phi + rk4_phi);
	addsd	%xmm10, %xmm8	# _27, phi
# morse_shoot.c:39:         if (fabs(psi) > 1e15) {
	jbe	.L16	#,
# morse_shoot.c:40:             psi /= 1e15;
	divsd	.LC9(%rip), %xmm7	#, <retval>
# morse_shoot.c:41:             phi /= 1e15;
	divsd	.LC9(%rip), %xmm8	#, phi
.L16:
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	addl	$1, %ebp	#, i
# morse_shoot.c:18:     for (int i = 0; i < n; i++) {
	cmpl	%ebp, %ebx	# i, n
	jne	.L18	#,
# morse_shoot.c:45: }
	addq	$120, %rsp	#,
	.cfi_def_cfa_offset 24
	movapd	%xmm7, %xmm0	# <retval>,
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L19:
	.cfi_restore 3
	.cfi_restore 6
# morse_shoot.c:14:     double psi = 0.0;
	pxor	%xmm7, %xmm7	# <retval>
# morse_shoot.c:45: }
	movapd	%xmm7, %xmm0	# <retval>,
	ret	
	.cfi_endproc
.LFE40:
	.size	fun_wave, .-fun_wave
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC11:
	.string	"Uso: %s <NSTEPS>\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC15:
	.string	"%8d %20.12f %20.12f %20.12f %20.12f %20.12f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
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
	movq	%rax, 136(%rsp)	# tmp137, D.6079
	xorl	%eax, %eax	# tmp137
# morse_shoot.c:48:     if (argc < 2) {
	cmpl	$1, %edi	#, argc
	jle	.L48	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_38(D) + 8B], MEM[(char * *)argv_38(D) + 8B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
# morse_shoot.c:60:     int level = 0;
	xorl	%r12d, %r12d	# level
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	call	__isoc23_strtol@PLT	#
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	pxor	%xmm0, %xmm0	# _3
# morse_shoot.c:63:     clock_gettime(CLOCK_MONOTONIC, &start);
	leaq	64(%rsp), %rsi	#, tmp143
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	movsd	.LC12(%rip), %xmm1	#, tmp141
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	cvtsi2sdl	%eax, %xmm0	# _62, _3
# morse_shoot.c:63:     clock_gettime(CLOCK_MONOTONIC, &start);
	movl	$1, %edi	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, %ebp	# _62, _63
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	divsd	%xmm0, %xmm1	# _3, dx
# morse_shoot.c:59:     double en_levels[5] = {0};
	pxor	%xmm0, %xmm0	# tmp142
	movaps	%xmm0, 96(%rsp)	# tmp142, en_levels
	movaps	%xmm0, 112(%rsp)	# tmp142, en_levels
# morse_shoot.c:56:     double dx = (xmax - xmin) / (double)nsteps;
	movsd	%xmm1, 8(%rsp)	# dx, %sfp
# morse_shoot.c:63:     clock_gettime(CLOCK_MONOTONIC, &start);
	call	clock_gettime@PLT	#
# morse_shoot.c:66:     double f_prev = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	8(%rsp), %xmm1	# %sfp, dx
	movl	%ebp, %edi	# _63,
	pxor	%xmm0, %xmm0	#
	call	fun_wave.constprop.0	#
# morse_shoot.c:60:     int level = 0;
	movsd	8(%rsp), %xmm1	# %sfp, dx
# morse_shoot.c:65:     double e_cur = e_min;
	movq	$0x000000000, 48(%rsp)	#, %sfp
# morse_shoot.c:66:     double f_prev = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	%xmm0, 56(%rsp)	# f_prev, %sfp
	jmp	.L34	#
	.p2align 4,,10
	.p2align 3
.L29:
# morse_shoot.c:68:     while (e_cur < e_max && level < 5) {
	movsd	.LC5(%rip), %xmm4	#, tmp218
	comisd	48(%rsp), %xmm4	# %sfp, tmp218
	jbe	.L40	#,
.L50:
	cmpl	$5, %r12d	#, level
	je	.L40	#,
.L34:
# morse_shoot.c:69:         e_cur += de;
	movsd	.LC13(%rip), %xmm0	#, e_cur
	addsd	48(%rsp), %xmm0	# %sfp, e_cur
# morse_shoot.c:70:         double f_cur = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	movl	%ebp, %edi	# _63,
	movsd	%xmm1, 8(%rsp)	# dx, %sfp
	movsd	56(%rsp), %xmm7	# %sfp, f_prev
# morse_shoot.c:69:         e_cur += de;
	movsd	%xmm0, 48(%rsp)	# e_cur, %sfp
	movsd	%xmm7, 24(%rsp)	# f_prev, %sfp
# morse_shoot.c:70:         double f_cur = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	call	fun_wave.constprop.0	#
# morse_shoot.c:72:         if (f_prev * f_cur < 0.0) {
	pxor	%xmm2, %xmm2	# tmp147
	movsd	8(%rsp), %xmm1	# %sfp, dx
# morse_shoot.c:70:         double f_cur = fun_wave(e_cur, xmin, xmax, dx, nsteps, d_pot, alpha);
	movsd	%xmm0, 56(%rsp)	# f_prev, %sfp
# morse_shoot.c:72:         if (f_prev * f_cur < 0.0) {
	mulsd	24(%rsp), %xmm0	# %sfp, _4
# morse_shoot.c:72:         if (f_prev * f_cur < 0.0) {
	comisd	%xmm0, %xmm2	# _4, tmp147
	jbe	.L29	#,
# morse_shoot.c:73:             double ea = e_cur - de;
	movsd	48(%rsp), %xmm4	# %sfp, e_cur
	movl	$100, %ebx	#, ivtmp_70
	movapd	%xmm4, %xmm7	# e_cur, ea
	subsd	.LC13(%rip), %xmm7	#, ea
# morse_shoot.c:74:             double eb = e_cur;
	movsd	%xmm4, 40(%rsp)	# e_cur, %sfp
# morse_shoot.c:73:             double ea = e_cur - de;
	movsd	%xmm7, 32(%rsp)	# ea, %sfp
	jmp	.L33	#
	.p2align 4,,10
	.p2align 3
.L46:
# morse_shoot.c:85:                     fa = fmid;
	movsd	%xmm0, 24(%rsp)	# fmid, %sfp
# morse_shoot.c:84:                     ea = emid;
	movsd	%xmm2, 32(%rsp)	# emid, %sfp
# morse_shoot.c:78:             for (int iter = 0; iter < 100; iter++) {
	subl	$1, %ebx	#, ivtmp_70
	je	.L49	#,
.L33:
# morse_shoot.c:79:                 emid = 0.5 * (ea + eb);
	movsd	32(%rsp), %xmm2	# %sfp, _5
	addsd	40(%rsp), %xmm2	# %sfp, _5
# morse_shoot.c:80:                 double fmid = fun_wave(emid, xmin, xmax, dx, nsteps, d_pot, alpha);
	movl	%ebp, %edi	# _63,
	movsd	%xmm1, 16(%rsp)	# dx, %sfp
# morse_shoot.c:79:                 emid = 0.5 * (ea + eb);
	mulsd	.LC6(%rip), %xmm2	#, emid
# morse_shoot.c:80:                 double fmid = fun_wave(emid, xmin, xmax, dx, nsteps, d_pot, alpha);
	movapd	%xmm2, %xmm0	# emid,
	movsd	%xmm2, 8(%rsp)	# emid, %sfp
	call	fun_wave.constprop.0	#
# morse_shoot.c:81:                 if (fa * fmid < 0.0) {
	movsd	24(%rsp), %xmm3	# %sfp, _6
# morse_shoot.c:81:                 if (fa * fmid < 0.0) {
	pxor	%xmm6, %xmm6	# tmp217
	movsd	8(%rsp), %xmm2	# %sfp, emid
	movsd	16(%rsp), %xmm1	# %sfp, dx
# morse_shoot.c:81:                 if (fa * fmid < 0.0) {
	mulsd	%xmm0, %xmm3	# fmid, _6
# morse_shoot.c:81:                 if (fa * fmid < 0.0) {
	comisd	%xmm3, %xmm6	# _6, tmp217
	jbe	.L46	#,
# morse_shoot.c:82:                     eb = emid;
	movsd	%xmm2, 40(%rsp)	# emid, %sfp
# morse_shoot.c:78:             for (int iter = 0; iter < 100; iter++) {
	subl	$1, %ebx	#, ivtmp_70
	jne	.L33	#,
.L49:
# morse_shoot.c:88:             if (level < 5) en_levels[level] = emid;
	movslq	%r12d, %rax	# level, level
# morse_shoot.c:68:     while (e_cur < e_max && level < 5) {
	movsd	.LC5(%rip), %xmm4	#, tmp218
# morse_shoot.c:89:             level++;
	addl	$1, %r12d	#, level
# morse_shoot.c:68:     while (e_cur < e_max && level < 5) {
	comisd	48(%rsp), %xmm4	# %sfp, tmp218
# morse_shoot.c:88:             if (level < 5) en_levels[level] = emid;
	movsd	%xmm2, 96(%rsp,%rax,8)	# emid, en_levels[level_87]
# morse_shoot.c:68:     while (e_cur < e_max && level < 5) {
	ja	.L50	#,
.L40:
# morse_shoot.c:94:     clock_gettime(CLOCK_MONOTONIC, &end);
	leaq	80(%rsp), %rsi	#, tmp160
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	movq	88(%rsp), %rax	# end.tv_nsec, end.tv_nsec
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	pxor	%xmm4, %xmm4	# _14
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	%ebp, %edx	# _63,
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	subq	72(%rsp), %rax	# start.tv_nsec, _13
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	pxor	%xmm0, %xmm0	# _10
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movsd	120(%rsp), %xmm3	# en_levels[3],
	leaq	.LC15(%rip), %rsi	#,
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm4	# _13, _14
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	movq	80(%rsp), %rax	# end.tv_sec, end.tv_sec
	subq	64(%rsp), %rax	# start.tv_sec, _9
# morse_shoot.c:96:                        (end.tv_nsec - start.tv_nsec) / 1e9;
	divsd	.LC14(%rip), %xmm4	#, _15
# morse_shoot.c:95:     double time_used = (end.tv_sec - start.tv_sec) +
	cvtsi2sdq	%rax, %xmm0	# _9, _10
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	addsd	%xmm0, %xmm4	# _10,
	movsd	112(%rsp), %xmm2	# en_levels[2],
	movsd	104(%rsp), %xmm1	# en_levels[1],
	movsd	96(%rsp), %xmm0	# en_levels[0],
	movl	$2, %edi	#,
	movl	$5, %eax	#,
	call	__printf_chk@PLT	#
# morse_shoot.c:102:     return 0;
	xorl	%eax, %eax	# <retval>
.L26:
# morse_shoot.c:103: }
	movq	136(%rsp), %rdx	# D.6079, tmp205
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp205
	jne	.L51	#,
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
.L48:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:118:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rsi), %rdx	# *argv_38(D),
	movl	$2, %edi	#,
	leaq	.LC11(%rip), %rsi	#,
	call	__printf_chk@PLT	#
# morse_shoot.c:50:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L26	#
.L51:
# morse_shoot.c:103: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE41:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-1598689907
	.long	1051772663
	.align 8
.LC2:
	.long	0
	.long	-1073741824
	.align 8
.LC3:
	.long	0
	.long	-1075838976
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1076101120
	.align 8
.LC6:
	.long	0
	.long	1071644672
	.align 8
.LC7:
	.long	0
	.long	1075314688
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC8:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC9:
	.long	640942080
	.long	1124887541
	.section	.rodata.cst16
	.align 16
.LC10:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC12:
	.long	0
	.long	1077608448
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
