function Ybus = systems_nbus(x,load_,R,n)
  Ybus = zeros(n);
  for i = 1:n
        for j = 1:n
            if i == j
                Ybus(i,j) = Ybus(i,j)+(load_(j)/(x(j)^2));
  disp("Bus Diagonal")
  disp(i)
  disp(j)
  disp(Ybus(i,j))
  disp(load_(j))
                for k = 1:n
                    Ybus(i,j) = Ybus(i,j)+(1/R(i,k));
  disp("Bus Diagonal")
  disp(i)
  disp(k)
  disp(Ybus(i,j))
  disp(R(i,k))
                end
            else
                Ybus(i,j) = Ybus(i,j)+(1/R(i,j));
  disp("Bus offdiagonal")
  disp(i)
  disp(j)
  disp(Ybus(i,j))
  disp(R(i,j))
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