Ri=input ('Enter the Ri');
Rj=input ('Enter the Rj');
p = input('Arrival Probability');
no_of_time_slots=100;
ip1_buf=0;
ip2_buf=0;
op1_buf=0;
op2_buf=0;
pack_proc = 0;
ip1 = [];
ip2 = [];
sit = 0;
dest1 = 0;
dest2 = 0;
for iter1=1:1:no_of_time_slots
 arrival = binornd(1,p);
 
 if(arrival == 1) %If packet arrives
 if(rand()< 0.5)% Packets arriving at Input buffer 1
 ip1_buf = ip1_buf+1;
 else % Packets arriving at Input buffer 2
 ip2_buf=ip2_buf+1;
 end
 end
 
 ip1(iter1) = ip1_buf;
 ip2(iter1) = ip2_buf;
 
 if(dest1 ~= dest2) %If two simultaneous transmissions took place in previous slot
dest1 = binornd(1,0.5); 
dest2 = binornd(1,0.5);
sit = 0;
 elseif(sit == 1) %If only ip buffer 1 transmitted
     dest1 = binornd(1,0.5);
     sit = 0;
 elseif(sit == 2)
     dest2 = binornd(1,0.5); %If only ip buffer 2 transmitted
     sit = 0;
 end
 if(dest1 ~= dest2) %If both inputs are cleared to transmit
     pause
               if(ip1_buf > 0 && ip2_buf > 0)
               op1_buf = op1_buf + 1;
               op2_buf = op2_buf + 1;
               ip1_buf = ip1_buf - 1;
               ip2_buf = ip2_buf - 1;
               packs_proc(iter1) = 2;
               disp('Heh');
              
               continue
                else
                    if(ip1_buf > 0)
                     if(dest1 == 0)
                        op1_buf = op1_buf + 1;
                        ip1_buf = ip1_buf - 1;
                        packs_proc(iter1) = 1;
                     else
                         op2_buf = op2_buf + 1;
                        ip1_buf = ip1_buf - 1;
                        packs_proc(iter1) = 1;
                     end
                        continue
                    else
                        if(ip2_buf > 0)
                    if(dest1 == 0)
                            op1_buf = op1_buf + 1;
                            ip2_buf = ip2_buf - 1;
                            packs_proc(iter1) = 1;
                    else
                        op2_buf = op2_buf + 1;
                            ip2_buf = ip2_buf - 1;
                            packs_proc(iter1) = 1;
                    end
                        end
                            continue
                    end
                end
 elseif(dest1 == 0 && dest2 == 0) %If there is contention for the channel
  if(rand() < Ri)
    if(ip1_buf > 0 )
        op1_buf = op1_buf + 1;
        ip1_buf = ip1_buf - 1;
        packs_proc(iter1) = 1;
        sit = 1;
        continue
    elseif(ip2_buf > 0)
            op1_buf = op1_buf + 1;
            ip2_buf = ip2_buf - 1;
            packs_proc(iter1) = 1;
            sit = 2;
            continue
    end
    else
        if(ip2_buf > 0)
            op1_buf = op1_buf + 1;
            ip2_buf = ip2_buf - 1;
            packs_proc(iter1) = 1;
            sit = 2;
            continue
        elseif(ip1_buf > 0 )
        op1_buf = op1_buf + 1;
        ip1_buf = ip1_buf - 1;
        packs_proc(iter1) = 1;
        sit = 1;
        continue
        end
        
  end
elseif(dest1 == 1 && dest2 == 1) %If there is contention for the channel
    if(rand() < Ri)
    if(ip1_buf > 0 )
        op2_buf = op2_buf + 1;
        ip1_buf = ip1_buf - 1;
        packs_proc(iter1) = 1;
        sit = 1;
        continue
    elseif(ip2_buf > 0)
            op2_buf = op2_buf + 1;
            ip2_buf = ip2_buf - 1;
            packs_proc(iter1) = 1;
            sit = 2;
            continue
    end
    else
        if(ip2_buf > 0)
            op2_buf = op2_buf + 1;
            ip2_buf = ip2_buf - 1;
            packs_proc(iter1) = 1;
            sit = 2;
            continue
        elseif(ip1_buf > 0 )
        op2_buf = op2_buf + 1;
        ip1_buf = ip1_buf - 1;
        packs_proc(iter1) = 1;
        sit = 1;
        continue
        end
    end

    
end
end