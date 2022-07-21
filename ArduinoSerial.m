Duration = 15;                         %Length of logging time in seconds.

%Auto find serial devices
PortList = seriallist;
if length(PortList) > 1
    PortList = cellstr(PortList);
    ComPort = PortList{listdlg('SelectionMode','single','PromptString','Select A COM Port.', 'ListString', PortList)};
elseif isempty(PortList)
    error('No serial device connected');
else
    ComPort = PortList(1);
end
clear('PortList');

SerialPort = serial(ComPort);
fopen(SerialPort);

tic();
while(toc < Duration)
    while SerialPort.BytesAvailable > 1
        RawOut = fscanf(SerialPort);
    end
end

fclose(SerialPort);
delete(SerialPort);
clear('SerialPort');
