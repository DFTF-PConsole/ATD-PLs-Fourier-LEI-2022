%% MAIN

clear;
clc;



%% 1.



%% 1.1.

PL = 6;

A1 = 2 * (mod(PL, 2) + 1);
A2 = 6 * (mod(PL, 5) + 1);

Wa = mod(PL, 5) + 2;
Wb = mod(PL, 7) + 7;
Wc = mod(PL, 9) + 1;

% Considerando as relações trigonométricas, verifica-se que 
% as frequências presentes no sinal são:
% w pertencente a {Wa - Wb, Wa + Wb, Wc - Wc, Wc + Wc} ou seja {...} rad/s
temp1 = Wa - Wb;
temp2 = Wa + Wb;
temp3 = Wc - Wc;
temp4 = Wc + Wc;

% frequência angular fundamental, w0, em rad/s
w0 = gcd(sym([abs(temp1), abs(temp2), abs(temp3), abs(temp4)]))

% frequência linear fundamental, f0, em Hz
f0 = w0/(2*pi)

% período fundamental, T0, em s
T0 = 1/f0

% sinal x1(t)
syms t
x1_t_s = A1 * sin(Wa*t) * cos(Wb*t) + A2 * cos(Wc*t)^2

% -- Relações trigonométricas
% -- -- sin(a)*cos(b) = (sen(a+b)+sen(a-b))/2
% -- -- sin(a) = cos((pi/2) - a)
% -- -- cos(a) = cos(-a)
% -- -- cos^2(a) = (1 + cos(2a))/2
% -- -- cos(0) = 1

% A1/2 * sin(temp1*t) + A1/2 * sin(temp2*t) + A2/2 * cos(temp3*t) + A2/2 * cos(temp4*t)

% expressão equivalente de x1(t) conforme formulação de Fourier
x1_t_eq_s = A1/2 * cos(pi/2 - temp1*t) + A1/2 * cos(pi/2 - temp2*t) + A2/2 * cos(temp3*t) + A2/2 * cos(temp4*t)


%plot inline -w 1200
% obtenção e plot de x1 e x1eq
tt=linspace(-pi/2, pi/2, 200);

x1_t=double(subs(x1_t_s, tt));
x1_t_eq=double(subs(x1_t_eq_s, tt));

figure;
plot(tt, x1_t, '-o', tt, x1_t_eq, '-+');
xlabel('t[s]');
title('x1(t)=' + string(x1_t_s));
legend('x1(t) pela expressão original', 'x1(t) pela expressão de Fourier','Location','northwest');



%% 1.2.

syms t;
x1_t_s = A1 * sin(Wa*t) * cos(Wb*t) + A2 * cos(Wc*t)^2;
x1_t_s_2 = subs(x1_t_s, -t)

if x1_t_s==x1_t_s_2
    disp('x1(t) é um sinal par');
elseif x1_t_s == -x1_t_s_2
    disp('x1(t) é um sinal ímpar');
else
    disp('x1(t) não é um sinal par nem ímpar');
end



%% 1.3.

syms t n Ts;
x1_t_s = A1 * sin(Wa*t) * cos(Wb*t) + A2 * cos(Wc*t)^2;
x1_n_s = subs(x1_t_s, n*Ts)



%% 1.4.

% Tendo em conta que as frequências presentes no sinal x1(t) são:
% w pertencente a {...} rad/s
% frequência angular fundamental de x1[n], Omega0, em rad
Omega_0_s = gcd(sym([abs(temp1), abs(temp2), abs(temp3), abs(temp4)]) * Ts)

% período fundamental de x1[n], N
Ns = 2*pi/Omega_0_s

% expressão equivalente de x1(t) conforme formulação de Fourier
x1_n_eq_s=subs(x1_t_eq_s, n*Ts)



%% 1.5.

% obtenção e plot de x1(t) , x1[n] e x1eq[n]
Tsample = 0.1;
Omega_0 = double(subs(Omega_0_s, Tsample))
N = fix(double(subs(Ns, Tsample)))

nn = fix(-N/2):fix(N/2);
x1_n = double(subs(x1_n_s, {n, Ts}, {nn, Tsample}));
x1_n_eq = double(subs(x1_n_eq_s, {n, Ts}, {nn, Tsample}));

figure;
plot(tt, x1_t, '-*', nn*Tsample, x1_n, 'o', nn*Tsample, x1_n_eq, '+')
xlabel('t[s]')
title('x1(t) e x1[n]')
legend('x1(t)', 'x1[n]', 'x1[n] pela expressão de Fourier', 'Location', 'northeast')



%% 2.



%% 2.1.

% Integral = trapezio(f_x, x1, xn, n)
% Integral = simpson(f_x, x1, xn, n)



%% 2.2.

syms t;
x1_t_s = A1 * sin(Wa*t) * cos(Wb*t) + A2 * cos(Wc*t)^2;

% Regra dos Trapezios
tic     % Calcular tempo de execução
Trapezio_E_x1_t = trapezio(abs(x1_t_s)^2, -pi/2, pi/2, 25) 
Tempo_Trapezio_E_x1_t = toc();      % Calcular tempo de execução

% Regra de Simpson
tic     % Calcular tempo de execução
Simpson_E_x1_t = simpson(abs(x1_t_s)^2, -pi/2, pi/2, 25)
Tempo_Simpson_E_x1_t = toc();      % Calcular tempo de execução



%% 2.2.1.

% Valor exato da Energia
tic     % Calcular tempo de execução
E_x1_t = double(int(abs(x1_t_s)^2, -pi/2, pi/2))
Tempo_syms_E_x1_t = toc();      % Calcular tempo de execução



%% 2.2.2.

disp("Tempo_Trapezio_E_x1_t = " + Tempo_Trapezio_E_x1_t)

disp("Tempo_Simpson_E_x1_t = " + Tempo_Simpson_E_x1_t)

disp("Tempo_syms_E_x1_t = " + Tempo_syms_E_x1_t)



%% 2.2.3.

Trapezio_erro = abs(E_x1_t - Trapezio_E_x1_t)

Simpson_erro = abs(E_x1_t - Simpson_E_x1_t)



%% 2.3.

% Cálculo da energia do sinal x[n]
Ts = 0.1;
nn = fix(-pi/2/Ts):fix(pi/2/Ts);

% Valor da energia do sinal discreto
x1_n = double(subs(x1_t_s, nn*Ts));
E_x1_n = sum(x1_n.^2) 



%% 2.4.

syms t;

x2_t_s = 6*cos(3*t)*sin(4*t)
E_x2_t = int(abs(x2_t_s)^2, -pi, pi)
E_x2_t_2 = int(abs(x2_t_s)^2, -2*pi, 2*pi)

x3_t_s = 6*cos(3*t-3)*sin(4*t-4)
E_x3_t = int(abs(x3_t_s)^2, -pi, pi)

x4_t_s = 3*cos(3*t)*sin(4*t)
E_x4_t = int(abs(x4_t_s)^2, -pi, pi)


