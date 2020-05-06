function printTable(rows, filename, label)

% save LaTex code as file
fid=fopen([filename '.tex'],'w');


fprintf(fid,'\\centering\n');
fprintf(fid,'\\caption{Simulation Parameters}\n');
fprintf(fid,['\\label{' label '}\n']);
fprintf(fid,'\\setlength{\\tabcolsep}{25pt}\n');
fprintf(fid,'\\def\\arraystretch{1.5}\n');
fprintf(fid,'\\begin{threeparttable}\n');
fprintf(fid,'    \\begin{tabular}{@{}lr@{}}\n');

fprintf(fid,'        \\toprule\n');
fprintf(fid,'        %s\\\\\n',pad('\textbf{Parameter} & \textbf{Value}',90));
fprintf(fid,'        \\midrule\n');


n = 1;
noteSymbols = {'\dag', '\ddag', '\dag\dag', '\ddag\ddag'};

for row = rows
    [line, note] = row.printRow;
    if ~strcmp(note,'')
        line = strrep(line,'NOTESTRING',['\tnote{' noteSymbols{n} '}']);
        notes{n} = note;
        n = n + 1;
    end
    fprintf(fid,'        %s\\\\\n',pad(line,90));
end
fprintf(fid,'        \\bottomrule\n');
fprintf(fid,'    \\end{tabular}\n');
if n > 1
fprintf(fid,'    \\begin{tablenotes}\n');
for i=1:n-1
    fprintf(fid,['        \\item[' strrep(noteSymbols{i},'\','\\') '] ' notes{i} '\n']);
end
fprintf(fid,'    \\end{tablenotes}\n');
end
fprintf(fid,'\\end{threeparttable}\n');



fclose(fid);
