clc
clear
close all
% this code calculate the mostly needed recieved packet number for decoded
% LT, using Guassion or BP algorithm
% the run Nc times

% parameter of sendind packages
packet_num  = 1000;
packet_length = 10;
redundancy = 1;
code_send = cell(1,2);
Nc = 10;
packet_encode_num = packet_num * (1 + redundancy);
receive_pkt_seq = zeros(1,Nc);
rate = zeros(1,Nc);

global Decoded_data
Decoded_data = [];
    

for n = 1:1:Nc

% generate the msg matrix which is random 0/1 bit
% every row is one packet_length(for example 50bits) package msg
message_matrix = randi([0 1],packet_num,packet_length);

% encode the msg matrix 
% and get the generation matrix H
% H's row respresent the order of encoding, the m-th row's n-th is 1, which
% respresent the n-th original msg is participated in encoding
[H,code_encode] = LT_encode(message_matrix,redundancy);


%Initialize the receiver
H_decode = [];
code_decode = []; 
send_index = randperm(size(code_encode,1));
%send_index = 1:size(code_encode,1);
receive_packet = 0;
decoded_bp_index = [];


for i = send_index
    %sending data
    code_send{1,1} = code_encode(i,:); 
    code_send{1,2} = H(i,:);    
    
    %receving data
    receive_packet = receive_packet + 1;
    if receive_packet == 500
        a = 1;
    end
    [H_decode,code_decode,tag_decode] = LT_decode_Guassian(code_send{1,2},code_send{1,1},H_decode,code_decode);
    %[H_decode,code_decode,tag_decode,decoded_bp_index] = LT_decode_BP(code_send{1,2},code_send{1,1},H_decode,code_decode,decoded_bp_index); 
    if tag_decode == 1
        receive_pkt_seq(n) = size(code_decode,1);
        rate(n) = check_decoded(message_matrix, code_decode);
        break;
    end    
end

end



