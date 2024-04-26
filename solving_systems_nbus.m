function X = solving_systems_nbus(x,v,i_,load_,R,n,ang_)
  Ybus = zeros(n)*1i;
  Ybusm = zeros(n);
  V = zeros(n,1);
  I = zeros(n,1);
  ang = zeros(n,1);

  for j = 1:n
      if (ang_(j)==-1) % ang = -1: Unknown then we equate the solvng variable
          ang(j) =  x(3,j);
      else % ang = 0: slack.  ang != 0 && ang != -1 known angle (Unlikely)
          ang(j) = ang_(j);
      end

      if (v(j)==0) % v = 0: Unknown then we equate the solvng variable
          V(j) = x(1,j)*cos(ang(j));
      else % v != 0: We know the bus voltage
          V(j) = v(j)*cos(ang(j));
      end

      if (i_(j)==-1) % i = -1: Unknown then we equate the solvng variable
          I(j) =  x(2,j);
      else % i = 0: No injected.  i != 0 && i != -1 injected current
          I(j) = i_(j);
      end
  end

  for ii = 1:n
       for j = 1:n
           if ii == j
               Ybus(ii,j) = Ybus(ii,j)+(load_(j)/(V(j)^2));
               for k = 1:n
                   Ybus(ii,j) = Ybus(ii,j)+(1/R(ii,k));
               end
           else
               Ybus(ii,j) = Ybus(ii,j)+(1/R(ii,j));
           end
       end
  end

  for ii = 1:n
      for j = 1:n
          if ii ~= j  % Check if the element is not on the diagonal
              Ybus(ii, j) = -Ybus(ii, j);  % Negate the element
          end
      end
  end

  for ii = 1:n
      for j = 1:n
          Ybusm(ii, j) = abs(Ybus(ii, j))*cos(angle(Ybus(ii, j)));  % Negate the element
      end
  end

  X = Ybusm*V-I;
end