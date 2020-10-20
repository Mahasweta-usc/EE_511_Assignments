mean=1/25; %mean service time
index = 1;
Na=0; %number of arrivals
Nd=0; %number of departures
N=0; %number of customers
t=0; %current time
T=100; %Total hours of operation
srvc_time=0; %Service time of one job
total_break_time=0; %Total break time 
srvc_comp_time= inf; %time after completion of current service


array_of_arr_time = exprnd(1/4);
arr_rates = [4,7,10,13,16,19,16,13,10,7]; %Varaible poisson rates
while(array_of_arr_time(index) < T) %generating the arrivals times as explained
    lamda = 19;
    time = array_of_arr_time(index);
    while(time<T)
        u_rand1 = rand();
        time = time - log(u_rand1)/lamda;
        u_rand2 = rand();
        mod_time = mod(uint8(time),10);
        comp_time = arr_rates(mod_time + 1)/lamda;
        if (u_rand2 <= comp_time)
            array_of_arr_time(index + 1) = time;
            index=index+1;
            break;
        end
    end
end

index = 1;
total_break_time = array_of_arr_time(1); %till first customer arrives, server is on break
arr_time = array_of_arr_time(1); %time of first arrival

while(arr_time <= T || N > 0) %Continue server till either No more customers arrive or queue has been cleared
    %Case 1
    if(((arr_time <=srvc_comp_time) && (arr_time <=T)))
        if(t < arr_time) %Update current time if only it is less than next arrival
            t=arr_time;
        end
        Na = Na + 1; %Update number of arrivals
        N = N +1; %Update queue size
        if index == length(array_of_arr_time) %update new time of arrival
            arr_time = array_of_arr_time(index);
        else
            arr_time = array_of_arr_time(index+1);
        end
        if(N == 1) %If queue non-empty
            srvc_comp_time = t + exprnd(mean); %service the customer
            t = srvc_comp_time; %Time moves to instant after customer is cleared
        end
        index = index + 1; %update arrival number
        continue
    end
    
    %Case 2
    if((srvc_comp_time < arr_time) && (srvc_comp_time <= T))
        N = N - 1; %update queue size
        Nd = Nd +1; %update number of departures
        t = srvc_comp_time; %update t
        break_t = 0; %initialize total break
        if(N==0)
            srvc_comp_time = inf;
            while(t < arr_time)
                increment = 0.3*rand();
                break_t = break_t + increment;
                t = t + increment; %update t, and total break till next arrival
            end
            total_break_time = total_break_time + break_t;
        else
            srvc_comp_time = t+ exprnd(1/25); %If non empty queue, process the waiting customer
            t = srvc_comp_time; %update time
        end
        if(arr_time > T)
            srvc_comp_time = t;
        end
        continue
    end
    %Case 3
    if(min(arr_time,srvc_comp_time) > T && N >0)
        t = srvc_comp_time; %Update the time
        N = N - 1; %clear remaining customer
        Nd = Nd +1; %increase the departures
        srvc_comp_time = t+ exprnd(1/25); %add the service times
        pause
        continue
    end
    
end
 %Case 4: Terminal case
    if(min(arr_time,srvc_comp_time) > T && N == 0)
        %Queue clear. No furthur
        Tp = max(t-T, srvc_comp_time - T) %Tp is the duration for which
        %server works to clear up queue after arrivals stop
    end

