function [H,code_encode] = LT_encode( source_code,redundancy )

    packet_num = size(source_code,1);
    packet_encode_num = packet_num * (1 + redundancy);
    pakcet_length = size(source_code,2);
    code_encode = zeros(packet_encode_num,pakcet_length);
    
    distribution_matix = robust_solition(packet_num,redundancy);

    %H generation Matrix
    H = zeros(packet_encode_num,packet_num);

    
    for row_index = 1:packet_encode_num
        pk2check_num = distribution_matix(row_index);
        col_pos = randperm(packet_num,pk2check_num);
        for col_index = col_pos
             H(row_index,col_index) = 1;
             code_encode(row_index,:) = rem(code_encode(row_index,:)+source_code(col_index,:),2);
        end
    end
    
    

end
