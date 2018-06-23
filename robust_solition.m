function [ distribution_matrix ] = robust_solition( packet_num,redundancy )

    % function illustration:
    % This function input the numebr of total original packets,
    %   and the redundancy to generate more encoded packages
    % The function outputs the robust soliton distribution degrees(not the probability)
    
    
    
    % Ideal Soliton distribution
    % p(i), i =1,2,...,k
    p_ideal = zeros(1,packet_num);
    p_ideal(1) = 1/packet_num;
    for i = 2:packet_num
        p_ideal(i) = 1/(i*(i-1));
    end


    % Robust Soliton Distribution
    % parameter: 
    % c > 0
    c = 0.05;
    delta = 0.05; % the probality is (1-delta) to recover all the input symbols
    p_robust = p_ideal;
    

    R = c*log(packet_num/delta)*sqrt(packet_num);
    degree_max = round(packet_num / R); % maximum degree = k/R, k is the number of packages
    
    % construct the tao
    p = zeros(1,degree_max);  
    
    for i = 1:degree_max-1
        p(i) = R/(i*packet_num);
    end
    
    p(degree_max) = R*log(R/delta)/packet_num;
    
    % sum the solition distribution and the robust sloliton distribution
    % then normlize the sum
    if degree_max > packet_num
        disp('degree_max > packet_num')
    end
        
        
    for i = 1:degree_max
        p_robust(i) = p_ideal(i) + p(i);
    end

    p_robust = p_robust/sum(p_robust);
    
    % ensure the minimal prob
    max_num = find(p_robust > (0.1/packet_num), 1, 'last' );
    distribution_matrix_prob = p_robust(1:max_num);
    temp_sum = sum(distribution_matrix_prob);
    distribution_matrix_prob = distribution_matrix_prob .* (1/temp_sum);  % nomalize the prob
    real_degree_max = length(distribution_matrix_prob);
    
    %distribution_matrix = randsample(1:real_degree_max,packet_num*(1+redundancy),'true',distribution_matrix_prob);
    distribution_matrix = randsrc(packet_num*(1+redundancy),1,[1:real_degree_max;distribution_matrix_prob]);
end