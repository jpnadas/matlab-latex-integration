classdef TableRow
    properties
        name,
        value,
        unit,
        variable,
        reference,
        note,
        printDb,
        tenPower,
        precision
    end
    methods
        function obj = TableRow(name, value, varargin)
            p = inputParser;
            p.addRequired('name');
            p.addRequired('value');
            p.addOptional('unit','',@(x) ischar(x));
            p.addOptional('variable','',@(x) ischar(x));
            p.addOptional('reference','',@(x) ischar(x));
            p.addParameter('note','');
            p.addParameter('isDb',false);
            p.addParameter('printDb',false);
            p.addParameter('tenPower',false);
            p.addParameter('precision',10);
            
            p.parse(name, value, varargin{:});
            
            
            
            obj.name = p.Results.name;
            if p.Results.isDb
                obj.value = 10^(.1*p.Results.value);
            else
                obj.value = p.Results.value;
            end
            
            obj.unit = p.Results.unit;
            obj.variable = p.Results.variable;
            obj.reference = p.Results.reference;
            obj.note = p.Results.note;
            obj.printDb = p.Results.printDb;
            obj.tenPower = p.Results.tenPower;
            
            if p.Results.isDb
                obj.printDb = true;
            end
            obj.precision = p.Results.precision;
            
            
        end
        function [ret, note] = printRow(obj)
            if obj.printDb == true
                this.value = 10*log10(obj.value);
                this.unit = 'dB';
            else
                this.value = obj.value;
                this.unit = obj.unit;
            end
            
            
            
            
            if ~strcmp(this.unit, '%')
                this.unit = [' ' this.unit];
            else
                this.unit = ['\' this.unit];
                this.value = 100*this.value;
            end
            
            if ~strcmp(obj.variable,'')
                this.variable = ['~($' obj.variable '$)'];
            else
                this.variable = obj.variable;
            end
            
            if ~strcmp(obj.reference,'')
                this.reference = ['~\cite{' obj.reference '}'];
            else
                this.reference = obj.reference;
            end
            
            if obj.tenPower == true
                this.value = ['$10^{' num2str(log10(this.value)) '}$'];
            else
                this.value = num2str(this.value,obj.precision);
            end
            
            note = obj.note;
            if strcmp(obj.note,'')
                this.noteMark = '';                
            else
                note = obj.note;
                this.noteMark = 'NOTESTRING';
            end
            
            
            ret = [pad([obj.name this.variable],50) '& ' this.value this.unit this.reference this.noteMark];
        end
    end
end
