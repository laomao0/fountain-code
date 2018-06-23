function [ H_decode_after,code_decode_after,tag_decode,decoded_bp_index] = LT_decode_BP( H_receive,code_receive,H_decode_before,code_decode_before,decoded_bp_index)
 
    
    H_decode_after = [H_decode_before;H_receive];
    code_decode_after = [code_decode_before;code_receive];
                    
    [H_decode_after,code_decode_after,decoded_bp_index] = BP(H_decode_after,code_decode_after,decoded_bp_index);
    
    
    % ??????
    % ?????????????????   
    %rank_H = find_rank(H_decode_after);
    %if rank_H == size(H_decode_after,2)
    %    tag_decode = 1;
   % end
   tag = 1;
   for i = 1:1:size(H_receive,2)
       tag = tag & ismember(i,decoded_bp_index);
   end
   tag_decode = tag;
   


end

