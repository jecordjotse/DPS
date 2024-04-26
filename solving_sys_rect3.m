function X = solving_sys_rect3(x,ybusFunc,v,i,load,R,n,ang_,B,w)
    V = zeros(n,1);
    I = zeros(n,1);
    ang = zeros(n,1);

    for j = 1:n
       
      if (ang_(j)==-1) % ang = -1: Unknown then we equate the solvng variable
          ang(j) =  x(4,j);
      else % ang = 0: slack.  ang != 0 && ang != -1 known angle (Unlikely)
          ang(j) = ang_(j);
      end

        if (v(j)==0) % v=0: Unknown then we equate the solvng variable
            V(j) = x(1,j)*cos(ang(j));
        else % v!=0: We know the bus voltage
            V(j) = v(j)*cos(ang(j));
        end

        if (i(j)==-1) % i=-1: Unknown then we equate the solvng variable
            I(j) =  x(2,j);
        else % i=0: No injected.  i!=0&&i!=-1 injected current
            I(j) = i(j);
        end
    end
    Ybus = ybusFunc(V,load,R,n);

      disp(Ybus)
      for ii = 1:n
          for j = 1:n
              Ybusm(ii, j) = abs(Ybus(ii, j))*cos(angle(Ybus(ii, j)));  % Negate the element
          end
      end
      disp(Ybusm)
      disp([Ybusm*V-I I])
    X = [Ybusm*V-I [x(3,1) - ((V(1)*I(1)*cos(ang(1)))/w) - B*w;0;x(3,3) - ((V(3)*I(3)*cos(ang(3)))/w) - B*w]];
end