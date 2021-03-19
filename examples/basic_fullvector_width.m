% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

close all
clear 
format short
clc


% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute

% iteratively changing width

steps = 10;

for i = 1:steps
    
    rw = linspace(1.0,0.325,steps);
    
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],...
                                [h1,h2,h3], rh,rw(i),side,dx,dy); 

    [Hx,Hy,neffTE(i)] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');
    
    fprintf(1,'neff(%i) = %.6f\n',i,neffTE(i));

    figure(i)  
    subplot(1,2,1);
    contourmode(x,y,Hx);
    title(['Hx (TE mode: ' num2str(i) ')']); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end

    subplot(1,2,2);
    contourmode(x,y,Hy);
    title(['Hy (TE mode: ' num2str(i) ')']); xlabel('x'); ylabel('y'); 
%     for v = edges, line(v{:}); end

end 

figure
plot(rw,neffTE)
xlabel('Ridge half width')
ylabel('Neff')
title('Neff vs Ridge half width')
rotate3d on
