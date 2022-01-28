%%
close all
clear all
load('data.mat');

c=3*10^8;
hbar=1.05*10^-34;
e=1.6*10^-19;
E=2*pi*c./lam*hbar/e*10^9;

%% fitting
Eqn = 'a/((x-b)^2+c)+d';
startPoints = [4 7 3 0];

R_sq=zeros(1,5);
a=zeros(1,5);
w0=zeros(1,5);
c=zeros(1,5);
d=zeros(1,5);

E2=1.5:0.1:10;
fit_curve=zeros(5,length(E2));
for j=1:5
y=A(j,:);
[f,quality]=fit(E',y',Eqn,'Start',startPoints);
R_sq(j)=quality.rsquare;
a(j)=f.a;
w0(j)=f.b;
c(j)=f.c;
d(j)=f.d;
fit_curve(j,:)=a(j)./((E2-w0(j)).^2+c(j))+d(j);
end
%% plotting


figure
subplot(1,2,1)
hold on
scatter(E,A(1,:),'r');
scatter(E,A(2,:),'b');
scatter(E,A(3,:),'g');
scatter(E,A(4,:),'y');
scatter(E,A(5,:),'cyan');

plot(E2,fit_curve(1,:),'r');
plot(E2,fit_curve(2,:),'b');
plot(E2,fit_curve(3,:),'g');
plot(E2,fit_curve(4,:),'y');
plot(E2,fit_curve(5,:),'cyan');
%  legend(['R_{sq,1}=',num2str(R_sq(1))],['R_{sq,2}=',num2str(R_sq(2))],['R_{sq,3}=',num2str(R_sq(3))],['R_{sq,4}=',num2str(R_sq(4))],['R_{sq,5}=',num2str(R_sq(5))])
legend('16:1','14:0','16:0','18:0','18:1')
xlabel('photon energy [eV]')
ylabel('absorbance')


subplot(1,2,2)
hold on
scatter(lam,A(1,:),'r');
scatter(lam,A(2,:),'b');
scatter(lam,A(3,:),'g');
scatter(lam,A(4,:),'y');
scatter(lam,A(5,:),'cyan');

lam2=2*pi*(3*10^8)./E2*hbar/e*10^9;

plot(lam2,fit_curve(1,:),'r');
plot(lam2,fit_curve(2,:),'b');
plot(lam2,fit_curve(3,:),'g');
plot(lam2,fit_curve(4,:),'y');
plot(lam2,fit_curve(5,:),'cyan');
%  legend(['R_{sq,1}=',num2str(R_sq(1))],['R_{sq,2}=',num2str(R_sq(2))],['R_{sq,3}=',num2str(R_sq(3))],['R_{sq,4}=',num2str(R_sq(4))],['R_{sq,5}=',num2str(R_sq(5))])
legend('16:1','14:0','16:0','18:0','18:1')
xlabel('photon wavelength [nm]')
ylabel('absorbance')
xlim([120 800])
%% absorption strength (a.u)
Abs=pi*a./sqrt(c);
figure
plot(Abs/max(Abs),'o')
ylim([0 1])
%maybe better that the x-axis will be just the names of molecules


