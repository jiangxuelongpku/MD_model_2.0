
% make filepath for the result
% VRM file
% 在 "Root" 文件夹中创建 "constant-coercivity" 文件夹
mkdir('constant-coercivity')
% 在 "constant-coercivity" 文件夹中创建 "VRM" 文件夹
mkdir('constant-coercivity/VRM')
% 在 "VRM" 文件夹中创建磁场温度文件夹
for B =0:5:100
    for T = 20:10:200
        mkdir(['constant-coercivity/VRM/' num2str(B) 'uT_' num2str(T) 'C'])
    end
end

% 在 "constant-coercivity" 文件夹中创建 "TRM" 文件夹
mkdir('constant-coercivity/TRM')

% 在 "TRM" 文件夹中创建磁场文件夹
for B =0:5:100
    mkdir(['constant-coercivity/TRM/' num2str(B) 'uT_580C_20C_1000s'])
end

% 在 "constant-coercivity" 文件夹中创建 "Coe" 文件夹
mkdir('constant-coercivity/Coe')

% 在 "Coe" 文件夹中创建步数文件夹
mkdir('constant-coercivity/Coe/1step_seq')
mkdir('constant-coercivity/Coe/10step_seq')
mkdir('constant-coercivity/Coe/20step_seq')
% 在 "step" 文件夹中外加磁场，实验室磁场文件夹
for B =0:5:100
    for Blab = 10:10:100
        mkdir(['constant-coercivity/Coe/20step_seq/' num2str(B) 'uTnrm' num2str(Blab) 'uTlab'])
    end 
end
