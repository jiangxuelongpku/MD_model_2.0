
% make filepath for the result
% VRM file
% �� "Root" �ļ����д��� "constant-coercivity" �ļ���
mkdir('constant-coercivity')
% �� "constant-coercivity" �ļ����д��� "VRM" �ļ���
mkdir('constant-coercivity/VRM')
% �� "VRM" �ļ����д����ų��¶��ļ���
for B =0:5:100
    for T = 20:10:200
        mkdir(['constant-coercivity/VRM/' num2str(B) 'uT_' num2str(T) 'C'])
    end
end

% �� "constant-coercivity" �ļ����д��� "TRM" �ļ���
mkdir('constant-coercivity/TRM')

% �� "TRM" �ļ����д����ų��ļ���
for B =0:5:100
    mkdir(['constant-coercivity/TRM/' num2str(B) 'uT_580C_20C_1000s'])
end

% �� "constant-coercivity" �ļ����д��� "Coe" �ļ���
mkdir('constant-coercivity/Coe')

% �� "Coe" �ļ����д��������ļ���
mkdir('constant-coercivity/Coe/1step_seq')
mkdir('constant-coercivity/Coe/10step_seq')
mkdir('constant-coercivity/Coe/20step_seq')
% �� "step" �ļ�������Ӵų���ʵ���Ҵų��ļ���
for B =0:5:100
    for Blab = 10:10:100
        mkdir(['constant-coercivity/Coe/20step_seq/' num2str(B) 'uTnrm' num2str(Blab) 'uTlab'])
    end 
end
