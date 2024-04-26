function Ybus = systems_nbus_Ru(x,load_,R,U,n)
%u is for unkowns 
  Ybus = zeros(n);
  for i = 1:n
        for j = 1:n
            if i == j
                Ybus(i,j) = Ybus(i,j)+(load_(j)/(x(j)^2));
                for k = 1:n
                    Ybus(i,j) = Ybus(i,j)+(1/R(i,k));
                end
            else
                Ybus(i,j) = Ybus(i,j)+(1/R(i,j));
            end
        end
  end
  for i = 1:n
       for j = 1:n
           if i ~= j  % Check if the element is not on the diagonal
               Ybus(i, j) = -Ybus(i, j);  % Negate the element
           end
       end
  end
end