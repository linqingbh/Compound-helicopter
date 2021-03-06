clearvars
clc
h = 100;
[~,~,~,rho] = atmosisa(h);
global inteference % 0: 无干扰 1: 只有上对下干扰（直接相加） 2:上下相互干扰（拟合数据）

%% 建立对象
global DoubleRotorHelicopter
global LowerRotor UpperRotor 
global Prop

% 直升机
DoubleRotorHelicopter       = Helicopter();
DoubleRotorHelicopter.GW    = 5500;
DoubleRotorHelicopter.GWF   = 5500*9.81;

% 下旋翼
LowerRotor = RotorFixed('anticlockwise'); % 下旋翼逆时针转， 为默认情况
LowerRotor.a_0        = 5.7;           % 主旋翼升力线斜率,NACA0012
LowerRotor.b          = 3;             % 旋翼桨叶数
LowerRotor.c          = 0.29;          % 主旋翼桨叶弦长m
LowerRotor.delta      = 0.008;         % 主旋翼桨叶阻力系数
LowerRotor.e          = 2.58/5.49;     % 无量纲等效铰偏置量
LowerRotor.e_oswald   = 0.8;           % 奥斯瓦尔德效率因子 (0.8)
LowerRotor.gamma_s    = deg2rad(3);    % 主旋翼桨毂纵向安装角
LowerRotor.h_R        = 0.89;          % 主旋翼处于重心之上的位置
LowerRotor.m_b        = 60;            % 桨叶质量
LowerRotor.omega_n    = 1.4*35.9;      % 主旋翼一阶挥舞固有频率 
LowerRotor.rho        = rho;           % 空气密度
LowerRotor.s          = 0.127;         % 主旋翼实度
LowerRotor.theta_t    = deg2rad(-10);  % 主旋翼桨叶扭转角 rad
LowerRotor.x_cg       = 0;             % 主旋翼处于重心之后的位置
LowerRotor.x_H        = 0;             % 桨毂x位置
LowerRotor.y_H        = 0;             % 桨毂y位置
LowerRotor.z_H        = -0.89;         % 桨毂z位置
LowerRotor.z_diff     = 0.77;          % 上下旋翼间距 m
LowerRotor.I_beta     = 450;           % 主旋翼挥舞惯性矩 kg m^2
LowerRotor.K_beta     = 183397;        % K_beta 弹簧刚度  Nm/rad
LowerRotor.M_beta     = 123;           % 主旋翼对挥舞铰的质量静矩
LowerRotor.Omega      = 35.9;          % 主旋翼转速rad/s
LowerRotor.R          = 5.49;          % 主旋翼半径 m

%上旋翼
UpperRotor = RotorFixed('clockwise'); % 上旋翼顺时针转
UpperRotor.a_0        = 5.7;           % 主旋翼升力线斜率,NACA0012
UpperRotor.b          = 3;             % 旋翼桨叶数
UpperRotor.c          = 0.29;          % 主旋翼桨叶弦长m
UpperRotor.delta      = 0.008;         % 主旋翼桨叶阻力系数
UpperRotor.e          = 2.58/5.49;     % 无量纲等效铰偏置量
UpperRotor.e_oswald   = 0.8;           % 奥斯瓦尔德效率因子 (0.8)
UpperRotor.gamma_s    = deg2rad(3);    % 主旋翼桨毂纵向安装角
UpperRotor.h_R        = 0.89+0.77;     % 主旋翼处于重心之上的位置
UpperRotor.m_b        = 60;            % 桨叶质量
UpperRotor.omega_n    = 1.4*35.9;      % 主旋翼一阶挥舞固有频率 
UpperRotor.rho        = rho;           % 空气密度
UpperRotor.s          = 0.127;         % 主旋翼实度
UpperRotor.theta_t    = deg2rad(-10);  % 主旋翼桨叶扭转角 rad
UpperRotor.x_cg       = 0;             % 主旋翼处于重心之后的位置
UpperRotor.x_H        = 0;             % 桨毂x位置
UpperRotor.y_H        = 0;             % 桨毂y位置
UpperRotor.z_H        = -0.89-0.77;    % 桨毂z位置
UpperRotor.z_diff     = 0.77;          % 上下旋翼间距 m
UpperRotor.I_beta     = 450;           % 主旋翼挥舞惯性矩 kg m^2
UpperRotor.K_beta     = 183397;        % K_beta 弹簧刚度  Nm/rad
UpperRotor.M_beta     = 123;           % 主旋翼对挥舞铰的质量静矩
UpperRotor.Omega      = 35.9;          % 主旋翼转速rad/s
UpperRotor.R          = 5.49;          % 主旋翼半径 m

%推进桨
Prop = PropellerNUAA();
Prop.delta              = 0.008;
Prop.e_oswald           = 0.8;
Prop.rho                = rho;
Prop.s                  = 0.2;
Prop.x_PR                = -7.66;
Prop.y_PR                = 0;
Prop.z_PR                = 0;
Prop.Omega              = 162;
Prop.R                  = 1.3;

%% 悬停/前飞配平 X,Y,Z,L,M,N=0,[theta_0,theta_diff,theta_1c,theta_1s,theta,phi,v_i1,v_i2]
DoubleRotorHelicopter.u         = 0;
DoubleRotorHelicopter.v         = 0;
DoubleRotorHelicopter.w         = 0;
DoubleRotorHelicopter.u_dot     = 0;
DoubleRotorHelicopter.v_dot     = 0;
DoubleRotorHelicopter.w_dot     = 0;
DoubleRotorHelicopter.p         = 0;
DoubleRotorHelicopter.q         = 0;
DoubleRotorHelicopter.r         = 0;
DoubleRotorHelicopter.p_dot     = 0;
DoubleRotorHelicopter.q_dot     = 0;
DoubleRotorHelicopter.r_dot     = 0;

LowerRotor.u        = DoubleRotorHelicopter.u;
LowerRotor.v        = DoubleRotorHelicopter.v;
LowerRotor.w        = DoubleRotorHelicopter.w;
LowerRotor.u_dot    = DoubleRotorHelicopter.u_dot;
LowerRotor.v_dot    = DoubleRotorHelicopter.v_dot;
LowerRotor.w_dot    = DoubleRotorHelicopter.w_dot;
LowerRotor.p        = DoubleRotorHelicopter.p;
LowerRotor.q        = DoubleRotorHelicopter.q;
LowerRotor.r        = DoubleRotorHelicopter.r;
LowerRotor.p_dot    = DoubleRotorHelicopter.p_dot;
LowerRotor.q_dot    = DoubleRotorHelicopter.q_dot;
LowerRotor.r_dot    = DoubleRotorHelicopter.r_dot;

UpperRotor.u        = DoubleRotorHelicopter.u;
UpperRotor.v        = -DoubleRotorHelicopter.v;
UpperRotor.w        = DoubleRotorHelicopter.w;
UpperRotor.u_dot    = DoubleRotorHelicopter.u_dot;
UpperRotor.v_dot    = -DoubleRotorHelicopter.v_dot;
UpperRotor.w_dot    = DoubleRotorHelicopter.w_dot;
UpperRotor.p        = -DoubleRotorHelicopter.p;
UpperRotor.q        = DoubleRotorHelicopter.q;
UpperRotor.r        = -DoubleRotorHelicopter.r;
UpperRotor.p_dot    = -DoubleRotorHelicopter.p_dot;
UpperRotor.q_dot    = DoubleRotorHelicopter.q_dot;
UpperRotor.r_dot    = -DoubleRotorHelicopter.r_dot;

% x = [theta_0,theta_diff,theta_1c,theta_1s,theta,phi,v_i1,v_i2]
options         = optimset('Display','iter','TolFun',1e-15,'Maxiter',5000,'Algorithm','levenberg-marquardt' ,'MaxFunEvals',20000);
InitialStates   = [0.01,0,0,0,0,0,10,10];
[x,~,exitflag,~] = trim_solve(@Aerodynamics_trim_2rotor_prop_8var,InitialStates,options,2,2,0,0);

%% 前飞配平 X,Y,Z,L,M,N=0,[theta_0,theta_diff,theta_1c,theta_1s,theta,phi,v_i1,v_i2]
DoubleRotorHelicopter.u         = 10;
DoubleRotorHelicopter.v         = 0;
DoubleRotorHelicopter.w         = 0;
DoubleRotorHelicopter.u_dot     = 0;
DoubleRotorHelicopter.v_dot     = 0;
DoubleRotorHelicopter.w_dot     = 0;
DoubleRotorHelicopter.p         = 0;
DoubleRotorHelicopter.q         = 0;
DoubleRotorHelicopter.r         = 0;
DoubleRotorHelicopter.p_dot     = 0;
DoubleRotorHelicopter.q_dot     = 0;
DoubleRotorHelicopter.r_dot     = 0;

LowerRotor.u        = DoubleRotorHelicopter.u;
LowerRotor.v        = DoubleRotorHelicopter.v;
LowerRotor.w        = DoubleRotorHelicopter.w;
LowerRotor.u_dot    = DoubleRotorHelicopter.u_dot;
LowerRotor.v_dot    = DoubleRotorHelicopter.v_dot;
LowerRotor.w_dot    = DoubleRotorHelicopter.w_dot;
LowerRotor.p        = DoubleRotorHelicopter.p;
LowerRotor.q        = DoubleRotorHelicopter.q;
LowerRotor.r        = DoubleRotorHelicopter.r;
LowerRotor.p_dot    = DoubleRotorHelicopter.p_dot;
LowerRotor.q_dot    = DoubleRotorHelicopter.q_dot;
LowerRotor.r_dot    = DoubleRotorHelicopter.r_dot;

LowerRotor.theta_1s     = deg2rad(0);
LowerRotor.theta_1c     = deg2rad(0);

UpperRotor.u        = DoubleRotorHelicopter.u;
UpperRotor.v        = -DoubleRotorHelicopter.v;
UpperRotor.w        = DoubleRotorHelicopter.w;
UpperRotor.u_dot    = DoubleRotorHelicopter.u_dot;
UpperRotor.v_dot    = -DoubleRotorHelicopter.v_dot;
UpperRotor.w_dot    = DoubleRotorHelicopter.w_dot;
UpperRotor.p        = -DoubleRotorHelicopter.p;
UpperRotor.q        = DoubleRotorHelicopter.q;
UpperRotor.r        = -DoubleRotorHelicopter.r;
UpperRotor.p_dot    = -DoubleRotorHelicopter.p_dot;
UpperRotor.q_dot    = DoubleRotorHelicopter.q_dot;
UpperRotor.r_dot    = -DoubleRotorHelicopter.r_dot;

% x = [theta_0,theta_diff,theta_1c,theta_1s,theta,phi,v_i1,v_i2]
inteference = 0;
options         = optimset('Display','iter','TolFun',1e-15,'Maxiter',5000,'Algorithm','levenberg-marquardt' ,'MaxFunEvals',20000);
InitialStates   = [0.01,0,0,0,0,0,10,10];
[x,~,exitflag,~] = fsolve(@Aerodynamics_trim_2rotor_8var,InitialStates,options);

% 遍历测试
test_array_u = 0:1:50;
test_array_u_size = size(test_array_u);
test_matrix = zeros(test_array_u_size(2),12); 
% test_matrix(:,1) : i_u
% test_matrix(:,2) : theta_0
% test_matrix(:,3) : theta_diff
% test_matrix(:,4) : theta_1c
% test_matrix(:,5) : theta_1s
% test_matrix(:,6) : theta
% test_matrix(:,7) : phi
% test_matrix(:,8) : v_01
% test_matrix(:,9) : v_02
% test_matrix(:,10) : Power_LowerRotor
% test_matrix(:,11) : Power_UpperRotor
% test_matrix(:,12) : Power_2Rotor = Power_LowerRotor + Power_UpperRotor

i_u = 1;
for ele_u = test_array_u
    DoubleRotorHelicopter.u         = ele_u;
    DoubleRotorHelicopter.v         = 0;
    DoubleRotorHelicopter.w         = 0;
    DoubleRotorHelicopter.u_dot     = 0;
    DoubleRotorHelicopter.v_dot     = 0;
    DoubleRotorHelicopter.w_dot     = 0;
    DoubleRotorHelicopter.p         = 0;
    DoubleRotorHelicopter.q         = 0;
    DoubleRotorHelicopter.r         = 0;
    DoubleRotorHelicopter.p_dot     = 0;
    DoubleRotorHelicopter.q_dot     = 0;
    DoubleRotorHelicopter.r_dot     = 0;

    LowerRotor.u        = DoubleRotorHelicopter.u;
    LowerRotor.v        = DoubleRotorHelicopter.v;
    LowerRotor.w        = DoubleRotorHelicopter.w;
    LowerRotor.u_dot    = DoubleRotorHelicopter.u_dot;
    LowerRotor.v_dot    = DoubleRotorHelicopter.v_dot;
    LowerRotor.w_dot    = DoubleRotorHelicopter.w_dot;
    LowerRotor.p        = DoubleRotorHelicopter.p;
    LowerRotor.q        = DoubleRotorHelicopter.q;
    LowerRotor.r        = DoubleRotorHelicopter.r;
    LowerRotor.p_dot    = DoubleRotorHelicopter.p_dot;
    LowerRotor.q_dot    = DoubleRotorHelicopter.q_dot;
    LowerRotor.r_dot    = DoubleRotorHelicopter.r_dot;

    LowerRotor.theta_1s     = deg2rad(0);
    LowerRotor.theta_1c     = deg2rad(0);

    UpperRotor.u        = DoubleRotorHelicopter.u;
    UpperRotor.v        = -DoubleRotorHelicopter.v;
    UpperRotor.w        = DoubleRotorHelicopter.w;
    UpperRotor.u_dot    = DoubleRotorHelicopter.u_dot;
    UpperRotor.v_dot    = -DoubleRotorHelicopter.v_dot;
    UpperRotor.w_dot    = DoubleRotorHelicopter.w_dot;
    UpperRotor.p        = -DoubleRotorHelicopter.p;
    UpperRotor.q        = DoubleRotorHelicopter.q;
    UpperRotor.r        = -DoubleRotorHelicopter.r;
    UpperRotor.p_dot    = -DoubleRotorHelicopter.p_dot;
    UpperRotor.q_dot    = DoubleRotorHelicopter.q_dot;
    UpperRotor.r_dot    = -DoubleRotorHelicopter.r_dot;

    % x = [theta_0,theta_diff,theta_1c,theta_1s,theta,phi,v_i1,v_i2]
    options         = optimset('Display','iter','TolFun',1e-15,'Maxiter',5000,'Algorithm','levenberg-marquardt' ,'MaxFunEvals',20000);
    InitialStates   = [0.01,0,0,0,0,0,10,10];
    [x,~,exitflag,~] = trim_solve(@Aerodynamics_trim_2rotor_prop_8var,InitialStates,options,2,2,0,0);
    
    if exitflag > 0
        test_matrix(i_u,:) = [  i_u, x(1), x(2), x(3), x(4), ...
                                x(5), x(6), LowerRotor.v_0, UpperRotor.v_0, ...
                                LowerRotor.Power_total, UpperRotor.Power_total, ...
                                LowerRotor.Power_total + UpperRotor.Power_total];
    end
    
    i_u = i_u + 1;
end

test_table = array2table(test_matrix, ...
    'VariableNames', {'u','theta_0','theta_diff','theta_1c','theta_1s',...
                        'theta','phi','v_01','v_02', ...
                         'Power_LowerRotor','Power_UpperRotor','Power_2Rotor'});

subplot(3,3,1)
plot(test_table.u, rad2deg(test_table.theta_0),'linewidth',1.5);
xlabel('u'); ylabel('\theta_0(deg)'); title('u - \theta_0(deg)'); grid on;
subplot(3,3,2)
plot(test_table.u, rad2deg(test_table.theta_diff),'linewidth',1.5);
xlabel('u'); ylabel('\theta_{diff}(deg)'); title('u - \theta_{diff}(deg)'); grid on;
subplot(3,3,3)
plot(test_table.u, rad2deg(test_table.theta_1c),'linewidth',1.5);
xlabel('u'); ylabel('\theta_{1c}(deg)'); title('u - \theta_{1c}(deg)'); grid on;
subplot(3,3,4)
plot(test_table.u, rad2deg(test_table.theta_1s),'linewidth',1.5);
xlabel('u'); ylabel('\theta_{1s}(deg)'); title('u - \theta_{1s}(deg)'); grid on;
subplot(3,3,5)
plot(test_table.u, rad2deg(test_table.theta),'linewidth',1.5);
xlabel('u'); ylabel('\theta(deg)'); title('u - \theta(deg)'); grid on;
subplot(3,3,6)
plot(test_table.u, rad2deg(test_table.phi),'linewidth',1.5);
xlabel('u'); ylabel('\phi(deg)'); title('u - \phi(deg)'); grid on;
subplot(3,3,7)
plot(test_table.u, test_table.v_01,'linewidth',1.5);
xlabel('u'); ylabel('v_{01}(m/s)'); title('u - v_{01}(m/s)'); grid on;
subplot(3,3,8)
plot(test_table.u, test_table.v_02,'linewidth',1.5);
xlabel('u'); ylabel('v_{02}(m/s)'); title('u - v_{02}(m/s)'); grid on;
subplot(3,3,9)
plot(test_table.u, test_table.Power_2Rotor/1000,'linewidth',1.5);
xlabel('u'); ylabel('Power_{2Rotor}(kW)'); title('u - Power_{2Rotor}(kW)'); grid on;
