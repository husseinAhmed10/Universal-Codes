clc
clear
code='011000110111011010111010010000010100101100110001001100110110001000111110010001000011001011001111010011010100000000111111101011100110110000001111110101000110110100000111111101110110011101011011101010010100001001001011111110110100011000100100100100100101101010001011111010100010010100110110110011010001111011111110001000101011001010011111011000100110100010001011110111011000111011100100011011011100101001000101011100001111111001101010101100000001011000010111100010111100111100101110110001100100110000010101011110001110';
%code = 10010;
%u=sort('ab');
u = sort('abcdefghijklmnopqrstuvwxyz,? ');
len_unique = length(u);
len = 105;
indexlooper=50;

for i=1:length(u)
    p(i)=1/len_unique ;
end
%%decoding
decoded_str=0;
%encoded_str = convertStringsToChars(string(encoded_str));
encoded_str = convertStringsToChars(string(code));


tester = encoded_str;
tester = convertStringsToChars(tester);
Output=char(num2cell(tester));
Output=reshape(str2num(Output),1,[]) ;
%decoded_str = Output*2.^(-1:-1:-length(Output)).' ;
%tag = decoded_str;

%tag = (low + high)/2;
% x = "1100";
% string="1100" ;
% y=convertStringsToChars(x) ;
% A=y;
% Output=char(num2cell(A));
% Output=reshape(str2num(Output),1,[]) ;
% Output*2.^(-1:-1:-length(Output)).' ;






low = 0;
high = 1;
%middle = 0.5;
stage = zeros(1, len_unique + 1);   %table
stage(1)=low;
stage(length(stage))=high;

for i = 2: length(stage)-1

    stage(i)= stage(i-1)+p(i);
    
end


prev_observation = zeros(1, len_unique);
p_sep = zeros(1, len_unique);


Decoded = '';

%if encoded_str <= 33

if len_unique <=10

for i = 1 : len
   tag = sum(Output.*2.^(-1:-1:-length(Output)));
   
   for j = 1 : len_unique
       
       % If tag value falls between a certain 
       % range in lookup table then
       if tag > stage(j) && tag < stage(j+1)
          prev_observation(j)=prev_observation(j) + 1;

              for k = 1 : len_unique 
                p_sep(k)=(1+prev_observation(k))/(i+len_unique);
              end
           
           low = stage(j);
           high = stage(j+1);
           
           stage(1)=low;
           stage(length(stage))=high;
           for ind = 2: length(stage)-1       
                stage(ind)= stage(ind-1)+p_sep(ind-1)*(high - low);
           end
  
           % Geeting the matched tag 
           % value character
           decoded_str = u(pos);

                Decoded = [Decoded decoded_str];
                
           
           break
       end
   end
   
   
end

else
                %%need edit til the end of %%else%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                pointer=0;
                pointervalue = 0;
                ending=0;
                iterator=0;
                for i = 1 : len
                    iterator=iterator + 1;
                    if i ==1
                    
                   decoded_str = sum(Output(1:49).*2.^(-1:-1:-49));
                
                    end
                
                    if len-i < 10 && pointervalue ~= 0 && iterator > 10
                        indexlooper = indexlooper + 1;
                        decoded_str = sum(Output(indexlooper:(length(Output))).*2.^(-1:-1:-(length(Output)-indexlooper + 1)));
                        decoded_str= decoded_str/2;
                        pointervalue = 0;
                        ending = 1;
%                         low = 0;
%                         
%                         high = 1;
%                         
%                         stage = zeros(1, len_unique + 1);   %table
%                         stage(1)=low;
%                         stage(length(stage))=high;
%                         
%                         for i_new = 2: length(stage)-1
%                             
%                             stage(i_new)= stage(i_new-1)+p(i_new);
%                             
%                         end
%                         
%                         u = sort(u);
%                         prev_observation = zeros(1, len_unique);
%                         p_sep = zeros(1, len_unique);
%                         %Decoded=end_of_iterations(decoded_str,prev_observation,p_sep,stage);
                        Decoded = [Decoded end_of_iterations(decoded_str,prev_observation,p_sep,stage,len_unique,p,len-i+1,u)];
                        break;
                    end
                    
                    
                        if (rem((i-1),10)==0 && i~=1 && ending == 0)
                        pointer =1;
                        pointervalue = pointervalue + 1;
                        iterator = 1;
                        
                        if pointervalue == 2 
                            decoded_str = sum(Output((99):(49+99)).*2.^(-1:-1:-(50)));
                            indexlooper= indexlooper + 49;
                        elseif pointervalue == 3
                            decoded_str = sum(Output((149):(199)).*2.^(-1:-1:-(51)));
                            indexlooper= indexlooper + 53;
                        elseif pointervalue == 5
                            indexlooper = indexlooper + 1;
                            decoded_str = sum(Output(indexlooper:indexlooper +50).*2.^(-1:-1:-(51)));
                            indexlooper = indexlooper + 50;
                        elseif pointervalue == 6
                            indexlooper = indexlooper - 1;
                            decoded_str = sum(Output(indexlooper:indexlooper +47).*2.^(-1:-1:-(48)));
                            indexlooper = indexlooper + 47;
                        elseif pointervalue == 7  
                            indexlooper= indexlooper + 2;
                            decoded_str = sum(Output(indexlooper:indexlooper +49).*2.^(-1:-1:-(50)));
                            indexlooper = indexlooper + 49;
                        elseif pointervalue == 8  
                            indexlooper= indexlooper + 1;
                            decoded_str = sum(Output(indexlooper:indexlooper +47).*2.^(-1:-1:-(48)));
                            indexlooper = indexlooper + 47;
                        elseif pointervalue == 9  
                            
                            decoded_str = sum(Output(indexlooper:indexlooper +47).*2.^(-1:-1:-(48)));
                            indexlooper = indexlooper + 47;
                            
                        else
                           % decoded_str = sum(Output((50*pointervalue + (pointervalue -1 )*1):48+(50*pointervalue + (pointervalue -1 )*1)).*2.^(-1:-1:-(49)));
                            decoded_str = sum(Output(indexlooper:48+indexlooper).*2.^(-1:-1:-(49)));
                             
                           indexlooper= indexlooper + 48;
                        end

                        low = 0;
                        
                        high = 1;
                        
                        stage = zeros(1, len_unique + 1);   %table
                        stage(1)=low;
                        stage(length(stage))=high;
                        
                        for i_new = 2: length(stage)-1
                            
                            stage(i_new)= stage(i_new-1)+p(i_new);
                            
                        end
                        
                        u = sort(u);
                        prev_observation = zeros(1, len_unique);
                        p_sep = zeros(1, len_unique);
                        
                    end
                    
                    
                    for j = 1 : len_unique
                        
                        
                        if decoded_str > stage(j) && decoded_str < stage(j+1)
                            prev_observation(j)=prev_observation(j) + 1;
                            
                            for k = 1 : length(u)
                                if pointer == 0
                                    p_sep(k)=(1+prev_observation(k))/(i+len_unique);
                                else
                                    
                                    p_sep(k)=(1+prev_observation(k))/((i-(10*pointervalue))+len_unique);
                                end
                            end
                            
                            
                            low = stage(j);
                            high = stage(j+1);
                            
                            stage(1)=low;
                            stage(length(stage))=high;
                            for ind = 2: length(stage)-1
                                
                                stage(ind)= stage(ind-1)+p_sep(ind-1)*(high - low);
                            end
                            
                            % Geeting the matched tag
                            % value character
                            Decoded = [Decoded u(j)];
                            
                            
                            break
                        end
                    end
                    
                    
                    
                end
                
                
                
end


function Decoded=end_of_iterations(tag,prev_observation,p_sep,stage,len_unique,p,len,u)

low = 0;
high = 1;
%middle = 0.5;
stage = zeros(1, len_unique + 1);   %table
stage(1)=low;
stage(length(stage))=high;

for i = 2: length(stage)-1

    stage(i)= stage(i-1)+p(i);
    
end


prev_observation = zeros(1, len_unique);
p_sep = zeros(1, len_unique);


Decoded = '';


for i = 1 : len
   %tag = sum(Output.*2.^(-1:-1:-length(Output)));
   
   for j = 1 : len_unique
       
       % If tag value falls between a certain 
       % range in lookup table then
       if tag > stage(j) && tag < stage(j+1)
          prev_observation(j)=prev_observation(j) + 1;

              for k = 1 : len_unique 
                p_sep(k)=(1+prev_observation(k))/(i+len_unique);
              end
           
           low = stage(j);
           high = stage(j+1);
           
           stage(1)=low;
           stage(length(stage))=high;
           for ind = 2: length(stage)-1       
                stage(ind)= stage(ind-1)+p_sep(ind-1)*(high - low);
           end
  
           % Geeting the matched tag 
           % value character
           decoded_str = u(j);

                Decoded = [Decoded decoded_str];
                
           
           break
       end
   end
   
   
end

end