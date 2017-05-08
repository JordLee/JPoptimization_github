function differTotal = find_rate_weighting(X,coefs,Temp,numbOfClass,classnumb_text,Target_data,numbOftarget1,numbOftarget2)
%% This function automatically writes the quadratic function for defining objective function i.e. obj = (target-f(A,E))


differTotal= 0;
timeTotal =zeros(length(Temp),1) ;
time = zeros(length(Temp),numbOfClass);
time_weight_differ = zeros(length(Temp),numbOfClass);
for j= 1: length(Temp)

    if j<=numbOftarget1 % normalizing weighting
        W = 1/numbOftarget1;
    else
        W = 1/numbOftarget2;
    end
    
    
     for i = 1: numbOfClass
    
     A=X(2*i-1);
     E=X(2*i);
%      W=X(3*i); % setting weight as variable
%      W=1; % equal weighting

% automatically writing the second order polynomial func.
     time(j,i)=coefs.(classnumb_text{i})(j,1)*log(A)+coefs.(classnumb_text{i})(j,2)*log(Temp(j))...
         +coefs.(classnumb_text{i})(j,3)*E+coefs.(classnumb_text{i})(j,4)*log(A)*E...
         +coefs.(classnumb_text{i})(j,5)*(log(A))^2+coefs.(classnumb_text{i})(j,6)*(E)^2;
     
     time_weight_differ(j,i)= W*abs(log10(Target_data(j))-log10(exp(time(j,i))));
     
     timeTotal(j)=time_weight_differ(j,i)+timeTotal(j); % sum up class

     
     end
    
     differTotal = timeTotal(j) + differTotal; % sum up Temp


end

    


end



