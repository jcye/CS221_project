filename = 'CF_jobs_words.txt';
fid = fopen(filename);
line = fgetl(fid);
line = fgetl(fid);
precision2 = sscanf(line, '%f');
line = fgetl(fid);
recall2 = sscanf(line, '%f');
fclose(fid);

hold on;
plot(recall2, precision2,'r--*');
filename = 'CF_jobs_result.txt';

filename = 'CF_small_data.txt';
fid = fopen(filename);
line = fgetl(fid);
line = fgetl(fid);
precision1 = sscanf(line, '%f');
line = fgetl(fid);
recall1 = sscanf(line, '%f');
fclose(fid);

plot(recall1, precision1,'g--x');
title('precision-recall');
xlabel('reall');
ylabel('precision');
axis([0 1 0 1]);
legend('large-dataset','small-dataset');


if 0
% draw_pr_curve
filename = 'CF_jobs_result.txt';
fid = fopen(filename);
line = fgetl(fid);
line = fgetl(fid);
precision1 = sscanf(line, '%f');
line = fgetl(fid);
recall1 = sscanf(line, '%f');
fclose(fid);

plot(recall1, precision1,'g--x');
title('precision-recall');
xlabel('reall');
ylabel('precision');
axis([0 1 0 1]);


filename = 'CF_word_result.txt';
fid = fopen(filename);
line = fgetl(fid);
line = fgetl(fid);
precision3 = sscanf(line, '%f');
line = fgetl(fid);
recall3 = sscanf(line, '%f');
fclose(fid);

hold on;
plot(recall3, precision3, 'b--o');

legend('application-history-work-history','application-history','work-history');
end