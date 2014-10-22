function format_log_axis(h,axis)
% Format axis with logarithmic spacing, labeled, with tickmarks.
% Labels values 1, 2, 5, 10, 20, 50, 100, 200, etc. across relevant axis range.
% And adds tickmarks for 1:1:10 20:10:100, etc.
% Required 'h' is the handle of a graphics object.
% Optional 'axis' argument equals 'X' or 'Y', default is 'X'.
% Make sure axis limits are set as desired first -- they are used to set label span.
if nargin < 2, axis = 'X'; end

set(h,[axis 'scale'],'log'); % make axis logarithmic
ax_lims = get(h,[axis 'lim']);
lobase = floor(log10(ax_lims(1)));
hibase = ceil(log10(ax_lims(2)));
range10 = 10.^(lobase:hibase); % values of base 10 spanning displayed axis range

% Add tickmarks
set(h,[axis 'MinorTick'],'off');
tick_vals = (1:9)';
ticks_mat = tick_vals*range10;
ticks = ticks_mat(:);
set(h,[axis 'Tick'], ticks);

% Add tick labels
tolabel_mat = false(size(ticks_mat));
tolabel_mat([1 2 5],:) = true; % indices to label, here [1 2 5] in each base 10
tolabel = tolabel_mat(:);
labels = cellfun(@num2str,num2cell(ticks),'UniformOutput',0);
labels(~tolabel) = {''};

set(h,[axis 'TickLabel'],labels);
end