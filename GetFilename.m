function filename = GetFilename(V, Vbark, A, HK, DHK)
if nargin < 5
    DHK = 0;
end
V = roundn(1e6*V^(1/3),-2);
Vbark = roundn(1e9*Vbark^(1/3),-2);
A = roundn(1e6*A^(1/2),-2);
HK = roundn(1e3*HK ,-2);
DHK = roundn(1e3*DHK ,-2);

filename  = ['V_' num2str(V) 'Vbark_' num2str(Vbark)...
    'A_' num2str(A) 'HK_' num2str(HK) 'DHK_' num2str(DHK) '.txt'];

