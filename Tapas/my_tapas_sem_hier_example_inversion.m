function [posterior, summary] = my_tapas_sem_hier_example_inversion(model, param, iteration)
%% Example for inversion with a linear model for the prior. 
%
% Input
%       model       -- String. Either seria or prosa
%       param       -- String. Parametric distribution.
% Output
%       posterior   -- Structure. Contains the posterior estimates.
%       summary     -- Table. Contains a table with a summary of the 
%                      posterior.

% aponteeduardo@gmail.com
% copyright (C) 2018
%


n = 0;

n = n + 1;
if nargin < n
    model = 'seria';
end

n = n + 1;
if nargin < n
    param = 'mixedgamma';
end

n = n + 1;
if nargin < n
    iteration = 0;
end

[data] = load_data(iteration);

switch model
case 'seria'
    ptheta = tapas_sem_seria_ptheta(); 
    switch param
        case 'invgamma'
            ptheta.llh = @c_seria_multi_invgamma;
        case 'gamma'
            ptheta.llh = @c_seria_multi_gamma;
        case 'mixedgamma'
            ptheta.llh = @c_seria_multi_mixedgamma;
        case 'lognorm'
            ptheta.llh = @c_seria_multi_lognorm;
        case 'later'
            ptheta.llh = @c_seria_multi_later;
        case 'wald'
            ptheta.llh = @c_seria_multi_wald;
        otherwise
            error('parametric function not defined')
    end

    ptheta.jm = [ ...
        eye(19)
        zeros(3, 8) eye(3) zeros(3, 8)];
    ptheta.jm = [ ...
        eye(15) zeros(15, 4)
        zeros(2, 4) eye(2) zeros(2, 13)
        zeros(2, 17) eye(2)
        zeros(3, 8) eye(3) zeros(3, 8) ];

    ptheta.p0(11) = tapas_logit(0.005, 1);
    
case 'prosa'
    ptheta = tapas_sem_prosa_ptheta(); % Choose at convinience.
    switch param
    case 'invgamma'
        ptheta.llh = @c_prosa_multi_invgamma;
    case 'gamma'
        ptheta.llh = @c_prosa_multi_gamma;
    case 'mixedgamma'
        ptheta.llh = @c_prosa_multi_mixedgamma;
    case 'lognorm'
        ptheta.llh = @c_prosa_multi_lognorm;
    case 'later'
        ptheta.llh = @c_prosa_multi_later;
    case 'wald'
        ptheta.llh = @c_prosa_multi_wald;
    otherwise
        error('parametric function not defined')
    end

    
     ptheta.jm = [...
        eye(15)
        zeros(3, 6) eye(3) zeros(3, 6)];
    
%     
%     ptheta.jm = [...
%         eye(15)
%         zeros(3, 6) eye(3) zeros(3, 6)];

end

pars = struct();

pars.T = ones(size(data)) * linspace(0.1, 1, 1).^5;
pars.nburnin = 4000;
pars.niter = 4000;
pars.ndiag = 500;
pars.mc3it = 4;
pars.verbose = 1;

display(ptheta);
inference = struct();
inference.kernel_scale = 0.1 * 0.1;

posterior = tapas_sem_hier_estimate(data, ptheta, inference, pars);

display(posterior);
summary = tapas_sem_display_posterior(posterior);

CSVDIR = '/Users/mplome/data/young_old/';
writetable(summary, ...
    fullfile(CSVDIR, sprintf('%d.csv', iteration)));
end

function [data] = load_data(iteration)
%% Prepares the test data

NDTIME = 100;
CSVDIR = '/Users/mplome/data/young_old/';   

f = mfilename('fullpath');
[tdir, ~, ~] = fileparts(f);


d = readtable(fullfile(tdir, 'data', 'full_data_for_2_stage.csv'));


%d = readtable(fullfile(tdir, 'data', 'subjects2018_eq.csv'));
%w bootstrapie wybierac bedziemy podzbiory 42 elementowe, ktore moga sie
%powtarzac
%tu poleci funkcja z forem data_boot z matlaba
%same wyprodukujemy sampla, jakies choose rand. number w matlabie, z tych
%naszych danych wybieramy te ktore id maja takie jakie nam wyszly z
%samplowania

% Convert ids to numeric
nt = size(d, 1);
ids = table2array(d(:,8));
unique_ids = unique(ids);
numeric_ids = zeros(nt, 1);
for i = 1:size(unique_ids, 1)
    numeric_ids(contains(ids, unique_ids(i))) = i;
end
d(:, 8) = [];
d = [d(:,1:7), array2table(numeric_ids), d(:,8:end)];

% Convert d to matrix for an easy manipulation
d = table2array(d);

y = struct('t', [], 'a', [], 'b', []);

% Subject, block, test num, age, id
u.s = d(:, 1); % sbj
u.b = d(:, 2); % block
u.t = d(:, 9); % test num
u.age = d(:,12); % age
u.id = d(:, 8); % numid

%Filter out unreasonably short reactions
% Invalid trials are shorter than 100 ms
y.i = d(:, 7) < 100;
y.i = d(:, 7) > 800;
% Shift and rescale the data
y.t = d(:, 7)/100;

% Is it a prosaccade or an antisaccade
% Up to hear prosaccades are 1 and antisaccades are 0%still valid
y.a = d(:, 6) == d(:, 5);
y.a = double(y.a);

% trial type
u.tt = d(:, 4);

t0 = y.a == 0;
t1 = y.a == 1;

y.a(t0) = 1;
y.a(t1) = 0;

y.a = y.a(~y.i);
y.t = y.t(~y.i);

u.s = u.s(~y.i);
u.b = u.b(~y.i);
u.tt = u.tt(~y.i);
u.t = u.t(~y.i);
u.age = u.age(~y.i);
u.id = u.id(~y.i);

y.i = y.i(~y.i);

data = struct('y', cell(2, 1), 'u', []);
data(1).iter = iteration;
data(1).csvdir = CSVDIR;



%%%%%%%%%%
j = 1;
split_by = 'age';
switch split_by
case 'age'
    for i = unique(u.age)'
        data(j).y = struct();
        data(j).u = struct();

        data(j).y.a = y.a(u.age == i);
        data(j).y.t = y.t(u.age == i);
        data(j).y.i = y.i(u.age == i);

        data(j).u.s = u.s(u.age == i);
        data(j).u.b = u.b(u.age == i);
        data(j).u.tt = u.tt(u.age == i);
        data(j).u.age = u.age(u.age == i); %age [0,1]
        data(j).u.t = u.t(u.age == i); %testnum [1,2]
        data(j).u.id = u.id(u.age == i);
        j = j+1;
    end
    
case 's'
    for i = unique(u.s)'
        data(j).y = struct();
        data(j).u = struct();

        data(j).y.a = y.a(u.s == i);
        data(j).y.t = y.t(u.s == i);
        data(j).y.i = y.i(u.s == i);

        data(j).u.s = u.s(u.s == i);
        data(j).u.b = u.b(u.s == i);
        data(j).u.tt = u.tt(u.s == i);
        data(j).u.age = u.age(u.s == i); %age [0,1]
        data(j).u.t = u.t(u.s == i); %testnum [1,2]
        data(j).u.id = u.id(u.s == i);
        j = j+1;
    end
case 'bt'
    bootstrap_sample = datasample(unique(u.id)', 42);
    for tn = 1:2
        for i = bootstrap_sample
            data(j).y = struct();
            data(j).u = struct();

            data(j).y.a = y.a(u.id == i & u.t == tn);
            data(j).y.t = y.t(u.id == i & u.t == tn);
            data(j).y.i = y.i(u.id == i & u.t == tn);

            data(j).u.s = u.s(u.id == i & u.t == tn);
            data(j).u.b = u.b(u.id == i & u.t == tn);
            data(j).u.tt = u.tt(u.id == i & u.t == tn);
            data(j).u.age = u.age(u.id == i & u.t == tn); %age [0,1]
            data(j).u.t = u.t(u.id == i & u.t == tn); %testnum [1,2]
            data(j).u.id = u.id(u.id == i & u.t == tn);
            j = j+1;
        end
    end
end
end
