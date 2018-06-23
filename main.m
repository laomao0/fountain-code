clc
clear
close all

% this code calculate the mostly needed recieved packet number for decoded
% LT, using Guassion or BP algorithm
% the run 1 times

% parameter of sendind packages
packet_num  = 1000;
packet_length = 10;
redundancy = 2;
code_send = cell(1,2);

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
global Decoded_data
Decoded_data = [];

for i = send_index
    
    %sending data
    code_send{1,1} = code_encode(i,:); 
    code_send{1,2} = H(i,:);    
    
    %receving data
    receive_packet = receive_packet + 1;
    if receive_packet == 500
        a = 1;
    end
    
    % uncomment the below to enable Gaussian or BP decode algorithm
    %[H_decode,code_decode,tag_decode] = LT_decode_Guassian(code_send{1,2},code_send{1,1},H_decode,code_decode);
    [H_decode,code_decode,tag_decode,decoded_bp_index] = LT_decode_BP(code_send{1,2},code_send{1,1},H_decode,code_decode,decoded_bp_index); 
    if tag_decode == 1
        rate = check_decoded(message_matrix, Decoded_data);
        receive_pkt = size(code_decode,1);        
        disp('decode success');
        disp('receive packet num is');
        disp(receive_pkt);
        disp('errer rate is');
        disp(rate);
        break;
    end    
end
