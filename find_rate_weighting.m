function differTotal = find_rate_weighting(X,coefs,Temp,numbOfClass,classnumb_text,Target_data)
differTotal= 0;
timeTotal =zeros(length(Temp),1) ;
time = zeros(length(Temp),numbOfClass);
for j= 1: length(Temp)

     for i = 1: numbOfClass

     time(j,i)=coefs.(classnumb_text{i})(j,1)*log(X(2*i-1))+coefs.(classnumb_text{i})(j,2)*log(Temp(j))...
         +coefs.(classnumb_text{i})(j,3)*X(2*i)+coefs.(classnumb_text{i})(j,4)*log(X(2*i-1))*X(2*i)...
         +coefs.(classnumb_text{i})(j,5)*(log(X(2*i-1)))^2+coefs.(classnumb_text{i})(j,6)*(X(2*i))^2;
     W(2*i-1)
     W(2*i)
     
     
     timeTotal(j)=time(j,i)+timeTotal(j);
    
     
     
     end
     
     differ(j) = abs(log10(Target_data(j))-W(2*i-1)*log10(exp(timeTotal(j))));
     differ(j) = abs(log10(Target_data(j))-W(2*i)*log10(exp(timeTotal(j))));
               
     differTotal = differ(j) + differTotal;
end

    


end

