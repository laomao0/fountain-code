function [ H_in,code_in,decoded_bp_index_in] = BP( H_in,code_in,decoded_bp_index_in)
   % in Bp the code_in doesn't respresent the totally decoded source
   % matrix, becase the H_in matrix is not the Identity matix
   
   global Decoded_data
   % check until the arrival of degree 1 msg
   dec_H = sum(H_in,2)';
   dec_pos_H = find(dec_H(1,:) == 1); % ???????1
   
while dec_pos_H  % arrival of degree 1
    select_dec_pos_H = dec_pos_H(1);
    col_pos = find(H_in(select_dec_pos_H,:) == 1);  % Select the first,????????
 
    % encoded_msg_pos_pointer = cur_row_num; % we find the pos_pointer-th encoded msg is degree 1
          
    % we need to get the postion of which original msg s-th
    original_msg_pos_pointer = col_pos;  % so the original msg s(original_msg_pos_pointer) is decoded
    decoded_bp_index_in = [decoded_bp_index_in,original_msg_pos_pointer]; 
    

    original_msg = code_in(select_dec_pos_H,:);
    Decoded_data(original_msg_pos_pointer,:) = original_msg;
           
    % find which encoced msg is related to
    % original(original_msg_pos_pointer -th) msg
    related_encoded_msg_pos = find(H_in(:,original_msg_pos_pointer) == 1);

    % for each related_encoded_msg, we do bitwise sum then modolo 2
    % e.g. XOR
    for j = related_encoded_msg_pos'
        if j ~= select_dec_pos_H(1)
            code_in(j,:) = rem( code_in(j,:) + original_msg , 2);
        end
    end

    % the next step is to cut off all the collection from decoded
    % source to the encoded msg
    H_in(related_encoded_msg_pos,original_msg_pos_pointer) = 0;
    
    
    
    % check the received Generation Matrix
    dec_H = sum(H_in,2);
    dec_pos_H = find(dec_H(:,1) == 1);
       
       
end
   
   
   
end % end function

