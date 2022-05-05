%arithmatic final isa

clc
clear

% input string
%s1 = 'ABBCA';
str = 'ABCABACBABCCACBAABBCCABAABB';
fprintf('The entered string is : %s\n', str);
  
% length of the string
len = length(str);
fprintf('The length of the string is : %d\n', len);
  
% get unique characters from the string
u = unique(str);
fprintf('The unique characters are : %s\n', u);
  
% length of the unique characters string
len_unique = length(u);
fprintf('The length of unique character string is : %d\n', len_unique);
  
% General lookup table
  
% get zeros of length of unique characters
%z = zeros(1, len_unique);
p = zeros(1, len_unique);
  
for i = 1 : len_unique %equalprob
   p(i) = 1 / len_unique;
end
display(p);

%Average length
Avg_len = p(1)^length(str) ;
  

  
% Encoder Table
  
low = 0;
high = 1;
%middle = 0.5;
stage = zeros(1, len_unique + 1);   %table
stage(1)=low;
stage(length(stage))=high;

for i = 2: length(stage)-1

    stage(i)= stage(i-1)+p(i);
    
end

u = sort(u);
prev_observation = zeros(1, len_unique);
p_sep = zeros(1, len_unique);
%total_previous_observation_String=1;
for i = 1 : len
   for j = 1 : len_unique
  
       % if the value from 'str'
       % matches with 'u' then
       if str(i) == u(j)
           prev_observation(j)=prev_observation(j) + 1;
           %if i ~= 1
              for k = 1 : len_unique 
                p_sep(k)=(1+prev_observation(k))/(i+len_unique);
              end
           %end
           %total_previous_observation_String = total_previous_observation_String + 1;
           pos = j;
           
           low = stage(j);
           high = stage(j+1);
           
           stage(1)=low;
           stage(length(stage))=high;
           for i = 2: length(stage)-1

%                if stage(i-1)==stage(i)
%                   
%                     stage(i)= stage(i-1) + p_sep(i-1)*(high - low)*2;
%                    
%                else
               
                stage(i)= stage(i-1)+p_sep(i-1)*(high - low);
    
              % end
           end
  
           display(pos);
  

         
           break
       end
   end
end
  
% displaying tag value
l_of_bin = ceil(1/(high-low))+1;
tag = (low + high)/2;
display(tag);
%tag = 01100000000000;
%disp(tag);



%%decoding

low = 0;
high = 1;
%middle = 0.5;
stage = zeros(1, len_unique + 1);   %table
stage(1)=low;
stage(length(stage))=high;

for i = 2: length(stage)-1

    stage(i)= stage(i-1)+p(i);
    
end

u = sort(u);
prev_observation = zeros(1, len_unique);
p_sep = zeros(1, len_unique);


str = '';
  
for i = 1 : len
   for j = 1 : len_unique
       
       % If tag value falls between a certain 
       % range in lookup table then
       if tag > stage(j) && tag < stage(j+1)
          prev_observation(j)=prev_observation(j) + 1;
           %if i ~= 1
              for k = 1 : len_unique 
                p_sep(k)=(1+prev_observation(k))/(i+len_unique);
              end
           %end
           %total_previous_observation_String = total_previous_observation_String + 1;
           
           
           
           pos = j;
           
           low = stage(j);
           high = stage(j+1);
           
           stage(1)=low;
           stage(length(stage))=high;
           for i = 2: length(stage)-1

%                 if stage(i-1)==stage(i)
%                   
%                     stage(i)= stage(i-1) + p_sep(i-1)*(high - low)*2;
%                    
%                else
               
                stage(i)= stage(i-1)+p_sep(i-1)*(high - low);
    
            %   end
    
           end
  
           % Geeting the matched tag 
           % value character
           decoded_str = u(pos);
  
           % String concatenating 
           % 'decoded_str' into 'str'
           str = strcat(str, decoded_str);
           break
       end
   end
end
  
% Displaying final decoded string
disp(str)



% function y=d2b(n,signed,bit_length,fraction_length)
%     a = fi(n,signed,bit_length,fraction_length);
%     y = a.bin;
%     
% end