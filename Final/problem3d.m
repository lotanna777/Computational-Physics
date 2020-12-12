rng(2,'twister');

N = 50;
nstep = 500000;
printstep = 2000;
nprint = floor(nstep/printstep);
nrun = 100;

t = zeros(nprint,1);
avm = zeros(nprint,1);       % average magnetization
ave = zeros(nprint,1);       % average energy
sq_ave = zeros(nprint,1);    % square of average energy
en_sq = zeros(nprint,1);     % energy squared
en_fluc = zeros(nprint,1);   % energy fluctuation

avcn = zeros(nprint,1);      % average correlation
%where we store averages

Jmat= [0.1 0.2 0.3 0.4];                       % Interaction energy
b=0;                        % magnetic field 
pbc=true;                   % periodic BCs

%% Initialize
nfigs = length(Jmat);
% Results matrices
ave_mat = zeros(nprint, nfigs);
avm_mat = zeros(nprint, nfigs);
en_fluc_mat = zeros(nprint, nfigs);
spins_mat = zeros(N,N, nfigs);

taue = 10^4;                % equilibration time

for Jcount =1:nfigs
    J = Jmat(Jcount);   
    spins=zeros(N,N);

for run=1:nrun

   m=0;
   for i=1:N
        for j=1:N
            if(rand()<.5)
                spins(i,j)=1;  %spin up
                m=m+1;
            else
                spins(i,j)=-1; %spin down
                m=m-1;
            end
        end
   end
   e = get_init_energy(spins,J,b,N,pbc);
   %initialize the system:  spins and energies computed
   
   
%% 
   for step=1:nstep
      s1=floor(N*rand())+1;
      s2=floor(N*rand())+1;
      enew=e+energy_difference(s1,s2,spins,J,b,N,pbc);
       %try to flip a spin
      if(metropolis(e,enew))
          %use metropolis to accept or reject
         spins(s1,s2)=-spins(s1,s2);
         if(spins(s1,s2)>0)
            m=m+2; 
         else
             m=m-2;
         end
         e=enew;
         %update energy and magnetization if accepted
      end
      
      if(mod(step,printstep)==0)
          k=floor(step/printstep);
          t(k)=step;
          avm(k)=avm(k)+abs(m)/N/N; 
          ave(k)=ave(k)+e/J/N/N;
          sq_ave(k) = ave(k)^2;                 % square of ave
          en_sq(k) = en_sq(k)+(e^2)/J/N/N;      % ave of energy squared
          en_fluc(k) = en_sq(k) - sq_ave(k);    % energy fluctuation
          %save the averages
          
          if step == taue
             m_taue =  m;
          end
          
          if(step/taue>=1) && step>=taue
             cn = m*m_taue;
             avcn(k) = avcn(k) + abs(cn)/N/N;   % correlation
             t_cn(k) = step;
          end
          
      end
             
   end
end

% Update Matrices
ave_mat(:,Jcount) = ave;
en_fluc_mat(:,Jcount) = en_fluc;
avm_mat(:,Jcount) = avm;
spins_mat(:,:,Jcount) = spins;

avcn_mat(:,Jcount) = avcn;
end


figure(1)
sgtitle('Correlation')
for j=1:Jcount
subplot(floor(nfigs/2),floor(nfigs/2),j)

avcn = avcn_mat(:,j);
plot(t_cn',avcn./nrun)
title(['J = ',num2str(Jmat(j))])
xlabel('iteration')
ylabel('<Cn>/JN^2')

% Curve fitting
% ft specifies the fit type while defining respective coefficients
ft2 = fittype( 'D*exp(-t_cn/tauc)','dependent',{'avcn'},'independent',{'t_cn'},...
    'coefficients',{'D','tauc'}) ;    

f2 = fit( t_cn', avcn, ft2 ,'StartPoint',[1600, 14000])     % Start point specifies init values

plot( f2, t_cn', avcn)
title(['J = ',num2str(Jmat(j))])
hold off;

end



%metropolis criterion
function x=metropolis(e,enew)
   if(e>enew)
       x=true;
   else
       if(rand()<exp(-(enew-e)))
           x=true;
       else
           x=false;
       end
   end
end


%compute the energy of the system
function efinal=get_init_energy(spins,J,b,N,pbc)
    e=0;
    for i=1:(N-1)
       for j=1:(N-1)
          e=e-spins(i,j)*spins(i+1,j);
          e=e-spins(i,j)*spins(i,j+1);
          %bulk contribution, not needing to worry about pbc's
       end
    end
    

    for i=1:(N-1)
       e=e-spins(i,N)*spins(i+1,N);
       if(pbc)
            e=e-spins(i,N)*spins(i,1);
       end
    end
    % right side
    

    for j=1:(N-1)
        e=e-spins(N,j)*spins(N,j+1);
        if(pbc)
            e=e-spins(N,j)*spins(1,j);
        end
    end
    %bottom
    

    if(pbc)
        e=e-spins(N,N)*spins(N,1);
        e=e-spins(N,N)*spins(1,N);
    end
    %bottom right corner

    emag=0;
    for i=1:N
        for j=1:N
            emag=emag-spins(i,j);
        end
    end
    

    
    e=J*e+b*emag;
    efinal=e;
end


function de=energy_difference(s1,s2,spins,J,b,N,pbc)
    de=0;

    
    evaluate=true; 
    t1=s1+1;
    t2=s2;
    if(t1==N+1)
           if(pbc)
               t1=1;
           else
               evaluate=false;
           end
    end
    
    if(evaluate)
           de=de+2*spins(s1,s2)*spins(t1,t2);
    end
           
    evaluate=true; 
    t1=s1-1;
    t2=s2;
    if(t1==0)
           if(pbc)
               t1=N;
           else
               evaluate=false;
           end
    end
    
    if(evaluate)
           de=de+2*spins(s1,s2)*spins(t1,t2);       
    end      
    
           
    evaluate=true; 
    t1=s1;
    t2=s2+1;
    if(t2==N+1)
           if(pbc)
               t2=1;
           else
               evaluate=false;
           end
    end
    
    if(evaluate)
           de=de+2*spins(s1,s2)*spins(t1,t2);   
    end     
           
           
    evaluate=true; 
    t1=s1;
    t2=s2-1;
    if(t2==0)
           if(pbc)
               t2=N;
           else
               evaluate=false;
           end
    end
    
    if(evaluate)
           de=de+2*spins(s1,s2)*spins(t1,t2); 
    end
    
    de=de*J;
    if(spins(s1,s2)>0)
        de=de+2*b;
    else
        de=de-2*b;
    end   
end
