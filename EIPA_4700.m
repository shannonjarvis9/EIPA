clc
clear all;

nx = 50;
ny = 50;

G = sparse(nx*ny,nx*ny);


for i = 1:nx
    for j = 1:ny
         n = j + (i-1)*ny;
         
         nxm = j + (i-2)*ny;
         nxp = j + (i)*ny;
         nym = j-1 + (i-1)*ny;
         nyp = j+1 + (i-1)*ny;
         
        if i == 1 || i == nx || j == 1 || j == ny
            G(n,:) = 0;
            G(n,n) = 1;
        else
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(nym,n) = 1;
            G(nyp,n) = 1;         
        end
        
%         if (i > 10 & i < 20 & j > 10 & j < 20)
%             G(n,n) = -2;
%         end
        
    end
end


figure(1)
spy(G)
title('Plot of G')


[E,D] = eigs(G,9,'SM');


%Plot the eigenvalues 
figure(2)
plot(real(D(1:9,1:9)),imag(D(1:9,1:9)),'r*') %   Plot real and imaginary parts
hold on;
xlabel('Real')
ylabel('Imaginary')
title('Eigenvalues of the wave equation modes') 


for k = 1:9
    for i = 1:nx
        for j = 1:ny
            
            %Remap n to nx, ny 
            n = j + (i-1)*ny;
            remap(k,i,j) = E(n,k);        
        end
    end
    
end


%Plot the eigenvectors 
figure(3)
title('Eigenvectors of the wave equation modes') 
for k=1:9
    subplot(3,3,k);
    surf(squeeze(remap(k,:,:)));
    
end
