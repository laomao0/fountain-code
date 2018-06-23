% this function check every bit of original source matrix and the decoded
% matrix, then calculate the bit error rate

function [ rate ] = check_decoded(source, decoded)
    
    totalbits = 0;
    right_decoded_num = 0;
    for i = 1:1:size(source,1)
        for j = 1:1:size(source,2)
                totalbits = totalbits + 1;
            if source(i,j) == decoded(i,j)
                right_decoded_num = right_decoded_num + 1;
            end
            
        end
    end
    
    rate = right_decoded_num/totalbits;
    

end % endof func