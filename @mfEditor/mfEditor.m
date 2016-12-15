classdef mfEditor
    %MFED�TOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=mfEditor(cmd,newfis)
            if nargin==0
                % Create it2fls
                newfis=it2flsSession;
                newfis=addvar2_type2(newfis,'input','input1',[-1 1],'init');
                newfis=addvar2_type2(newfis,'input','input2',[-1 1],'init');
                newfis=addvar2_type2(newfis,'output','output1',[0 1],'init');
                
            end
            
            mfEditorHndl = findall(0,'type','figure','Tag','mfEditor');
            if ~isempty(mfEditorHndl) && isequal(cmd,'initialize')
                figure(mfEditorHndl)
                return
            end
            
            %% colors
            figColor=[0.9 0.9 0.9];
            frmColor=192/255*[1 1 1];
            editColor=255/255*[1 1 1];
            selectColor=[1 0 0];
            unselectColor=[0 0 0];
            inputColor=[1 1 0.93];
            outputColor=[0.8 1 1];
            tickColor=[0.5 0.5 0.5];
            popupColor=192/255*[1 1 1];
            thisit2fls{1}=newfis;
            hMember = figure('Color',[0.8 0.8 0.8], ...
                'MenuBar','none', ...
                'NumberTitle','off', ...
                'Tag','mfEditor', ...
                'UserData',thisit2fls, ...
                'ToolBar','none',...
                'Visible','on',...
                'Name','Membership Function Editor');
            set(hMember,'Units','Normalized','Position',[0.05, 0.1, 0.4, 0.65]);
            movegui(hMember,'west');
            %         set(hMember, 'WindowStyle', 'docked')
            %         setFigDockGroup(hMember, 'Interval Type-2 Fuzzy Logic Systems Toolbox');
            %% Add Menus
            obj=addMenus('','',obj);
            param.CurrMF=-1;
            param.Action='';
            axPos = [0.3 0.5 0.65 0.4];
            if helper.isNewGraphics
                mainAxHndl=axes( ...
                    'Units','Normalized', ...
                    'XColor',tickColor,'YColor',tickColor, ...
                    'Color',inputColor, ...
                    'Position',axPos, ...
                    'Userdata', param, ...
                    'Tag','mainaxes', ...
                    'Box','on',...
                    'PickableParts','visible',...
                    'HitTest','off');
            else
                mainAxHndl=axes( ...
                    'Units','Normalized', ...
                    'XColor',tickColor,'YColor',tickColor, ...
                    'Color',inputColor, ...
                    'Position',axPos, ...
                    'Userdata', param, ...
                    'Tag','mainaxes', ...
                    'Box','on');
            end
            grid on;
            hold on
            titleStr='Membership function plots';
            title(titleStr,'Color','black','FontSize',8);
            
            %% Add buttons and other gui elements
            
            %draw frame
            mainFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','Normalized', ...
                'Position',[0.01 0.01 0.98 0.4], ...
                'BackgroundColor',frmColor);
            
            % The VARIABLE PALETTE axes
            axBorder=5;
            axPos=[0.02 0.45 0.23 0.45];
            if helper.isNewGraphics
                axHndl=axes( ...
                    'Units','Normalized', ...
                    'Visible','off', ...
                    'XColor',tickColor,'YColor',tickColor, ...
                    'Color',[0.8 0.8 0.8], ...
                    'Position',axPos, ...
                    'Tag','variables', ...
                    'Box','on',...
                    'PickableParts','visible',...
                    'HitTest','off');
            else
                axHndl=axes( ...
                    'Units','Normalized', ...
                    'Visible','off', ...
                    'XColor',tickColor,'YColor',tickColor, ...
                    'Color',[0.8 0.8 0.8], ...
                    'Position',axPos, ...
                    'Tag','variables', ...
                    'Box','on');
            end
            axes(mainAxHndl)
            
            %====================================
            % The VARIABLE frame
            
            varFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','Normalized', ...
                'Position',[0.02 0.02 0.35 0.38], ...
                'BackgroundColor',frmColor);
            
            
            %------------------------------------
            % The VARIABLE label field
            
            labelStr='Current Variable';
            pos=[0.04 0.27 0.2 0.1];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The VARIABLE NAME text field
            name='varname';
            labelStr='Name';
            pos=[0.04 0.21 0.2 0.1];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The VARIABLE NAME display field
            pos=[0.14 0.21 0.2 0.1];
            hndl=uicontrol( ...
                'Style','text', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',popupColor, ...
                'String',' ', ...
                'Tag',name);
            
            %------------------------------------
            % The VARIABLE TYPE text field
            labelStr='Type';
            pos=[0.04 0.15 0.2 0.1];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The VARIABLE TYPE display field
            labelStr=' input| output';
            name='vartype';
            pos=[0.14 0.15 0.2 0.1];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',popupColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Tag',name, ...
                'String',labelStr);
            
            %------------------------------------
            % The VARIABLE RANGE text field
            labelStr='Range';
            pos=[0.04 0.085 0.2 0.1];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The VARIABLE RANGE edit field
            name='varrange';
            pos=[0.17 0.16 0.17 0.03];
            hndl=uicontrol( ...
                'Style','edit', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',editColor, ...
                'Callback',{@localSelectmf obj}, ...
                'Tag',name);
            
            %------------------------------------
            % The VARIABLE DISPLAY RANGE text field
            labelStr='Display Range';
            pos=[0.04 0.09 0.2 0.03];
            hndl=uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The VARIABLE DISPLAY RANGE edit field
            name='disprange';
            pos=[0.17 0.085 0.17 0.03];
            hndl=uicontrol( ...
                'Style','edit', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',editColor, ...
                'Callback',{@disprange obj}, ...
                'Tag',name);
            
            %====================================
            % The MF frame
            frmPos=[0.4 0.02 0.58 0.377];
            mfFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','Normalized', ...
                'Position',frmPos, ...
                'BackgroundColor',frmColor);
            
            % Upper frame
            frmPos=[0.43 0.2 0.44 0.15];
            mfFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','Normalized', ...
                'Position',frmPos, ...
                'BackgroundColor',frmColor,...
                'tag','UpperFrame');
            
            % Lower frame
            frmPos=[0.43 0.04 0.44 0.15];
            mfFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','Normalized', ...
                'Position',frmPos, ...
                'BackgroundColor',frmColor,...
                'tag','LowerFrame');
            
            
            
            %------------------------------------
            % The MEMBERSHIP FUNCTION text field
            labelStr='Current Membership Function (click on MF to select)';
            pos=[0.45 0.35 0.4 0.03];
            uicontrol( ...
                'Style','text', ...
                'BackgroundColor',frmColor, ...
                'HorizontalAlignment','left', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %         callbackStr='paint_intervals';
            %         labelStr = 'Fill';
            %         name='FillInt';
            %         pos=[0.92 0.1 0.04 0.2];
            %         hndl=uicontrol( ...
            %             'Style','PushButton', ...
            %             'Units','Normalized', ...
            %             'Position',pos, ...
            %             'HorizontalAlignment','left', ...
            %             'BackgroundColor',[1 1 1], ...
            %             'Tag',name, ...
            %             'Callback',callbackStr, ...
            %             'String',labelStr );
            
            %------------------------------------
            % The MF Name text label
            labelStr='Name ';
            pos=[0.45 0.295 0.1 0.02];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The MF NAME edit field
            
            labelStr = 'test';
            name='mfname';
            pos=[0.75 0.29 0.1 0.025];
            hndl=uicontrol( ...
                'Style','edit', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',editColor, ...
                'Tag',name, ...
                'Callback',{@mfname obj}, ...
                'String','testval');
            
            %------------------------------------
            % The MF Name text label
            labelStr='Name Lower';
            pos=[0.45 0.26 0.1 0.02];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The MF NAME edit field
            
            labelStr = 'test';
            name='mfname Lower';
            pos=[0.75 0.26 0.1 0.025];
            hndl=uicontrol( ...
                'Style','edit', ...
                'Units','Normalized', ...
                'Position',pos, ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',editColor, ...
                'Tag',name, ...
                'Callback',{@mfname obj}, ...
                'String','testval');
            
            % Crisp Interval Text
            pos=[0.6,0.3,0.16,0.03];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String','Choose Output Type');
            
            % Radio buttons for crisp interval selection
            ChkBoxHandle=uicontrol('style','radiobutton',...
                'units','Normalized',...
                'position',[0.5,0.22,0.09,0.04],...
                'string','Crisp',...
                'tag','CheckboxCrips',...
                'Callback','helper.setCrispInterval(''crisp'')',...
                'BackgroundColor',frmColor);
            
            ChkBoxHandle=uicontrol('style','radiobutton',...
                'units','Normalized',...
                'position',[0.7,0.22,0.09,0.04],...
                'string','Interval',...
                'tag','CheckboxInterval',...
                'Callback','helper.setCrispInterval(''interval'')',...
                'BackgroundColor',frmColor);
            
            
            % Grid Frame
            frmPos=[0.88 0.23 0.09 0.12];
            mfFrmHndl=uicontrol( ...
                'Style','frame', ...
                'Units','Normalized', ...
                'Position',frmPos, ...
                'BackgroundColor',frmColor,...
                'tag','GridFrame');
            
            % Grid Text
            labelStr='Grid';
            pos=[0.91 0.32 0.05 0.02];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            % Radio buttons for grid selection
            uicontrol('style','radiobutton',...
                'units','Normalized',...
                'position',[0.9,0.28,0.05,0.03],...
                'string','On',...
                'tag','gridon',...
                'Callback',{@gridAxs obj 'on'},...
                'BackgroundColor',frmColor,...
                'Value',1);
            
            uicontrol('style','radiobutton',...
                'units','Normalized',...
                'position',[0.9,0.24,0.05,0.03],...
                'string','Off',...
                'tag','gridoff',...
                'Callback',{@gridAxs obj 'off'},...
                'BackgroundColor',frmColor,...
                'Value',0);
            
            
            
            %------------------------------------
            % The MF TYPE text label
            labelStr='Type ';
            pos=[0.45 0.165 0.1 0.03];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            % The MF TYPE text label
            labelStr='Type Lower';
            pos=[0.45 0.12 0.1 0.03];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The MF TYPE popup menu
            labelStr1=str2mat(' trimf',' trapmf',' gbellmf',' gaussmf',' gauss2mf',' sigmf');
            labelStr1=str2mat(labelStr1,' dsigmf',' psigmf',' pimf',' smf',' zmf');
            labelStr2=str2mat(' constant',' linear');
            name='mftype';
            pos=[0.75 0.165 0.1 0.03];
            hndl=uicontrol( ...
                'Style','popupmenu', ...
                'Units','Normalized', ...
                'UserData',labelStr2, ...
                'Position',pos, ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',popupColor, ...
                'Callback',{@mftype}, ...
                'String',labelStr1, ...
                'Tag',name);
            
            name='mftypelower';
            pos=[0.75 0.12 0.1 0.03];
            hndl=uicontrol( ...
                'Style','popupmenu', ...
                'Units','Normalized', ...
                'UserData',labelStr2, ...
                'Position',pos, ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',popupColor, ...
                'Callback',{@mftype}, ...
                'String',labelStr1, ...
                'Tag',name);
            
            %------------------------------------
            % The MF PARAMS text label
            labelStr='Params';
            pos=[0.45 0.12 0.2 0.03];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            %------------------------------------
            % The MF PARAMS edit field
            name='mfparams';
            pos=[0.65 0.12 0.2 0.03];
            hndl=uicontrol( ...
                'Style','edit', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',editColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Callback',{@mfparams obj}, ...
                'Tag',name);
            
            % The MF PARAMS2 text label
            labelStr='Params Lower';
            pos=[0.45 0.06 0.2 0.03];
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',frmColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'String',labelStr);
            
            % The MF PARAMS2 edit field
            name='mfparams2';
            pos=[0.65 0.06 0.2 0.03];
            hndl=uicontrol( ...
                'Style','edit', ...
                'HorizontalAlignment','left', ...
                'BackgroundColor',editColor, ...
                'Units','Normalized', ...
                'Position',pos, ...
                'Callback',{@mfparams obj}, ...
                'Tag',name);
            
            name='numpoints';
            pos=[0.851 0.94 0.10 0.05];
            hndl=uicontrol( ...
                'Style','edit', ...
                'HorizontalAlignment','right', ...
                'BackgroundColor',editColor, ...
                'Units','normal', ...
                'Position',pos, ...
                'String', '181', ...
                'Callback',{@plotmfs obj}, ...
                'Visible','off',...
                'Tag',name);
            pos=[0.74 0.94 0.10 0.05];
            
            hndl=uicontrol( ...
                'Style','text', ...
                'HorizontalAlignment','right', ...
                'BackgroundColor', figColor, ...
                'Units','normal', ...
                'Position',pos, ...
                'FontSize',8, ...
                'String', 'plot points:', ...
                'Visible', 'off',...
                'Tag','pointlabel');
            
            
            
            
            obj=plotvars(obj);
            obj=selectvar('','',obj);
            obj=plotmfs(obj);
            
        end
        
    end
end

function [ obj ] = mftype( ~,~,obj )
%MFTYPE Summary of this function goes here
%   Detailed explanation goes here
%% colors
figColor=[0.9 0.9 0.9];
frmColor=192/255*[1 1 1];
editColor=255/255*[1 1 1];
selectColor=[1 0 0];
unselectColor=[0 0 0];
inputColor=[1 1 0.93];
outputColor=[0.8 1 1];
tickColor=[0.5 0.5 0.5];
popupColor=192/255*[1 1 1];
% Determine Upper or Lower Type selection
if isequal(get(gcbo,'tag'),'mftype')
    isUpper=1;
elseif isequal(get(gcbo,'tag'),'mftypelower')
    isUpper=0;
end

%====================================
figNumber=gcf;
HandlInterval = findobj('Tag', 'CheckboxInterval');
isInterval=get(HandlInterval,'value');
%   mfTypeHndl=get(figNumber,'CurrentObject');
mfTypeHndl=gcbo;
fis=helper.getAppdata;
fisType=fis.type;
numInputs=length(fis.input);

% Is the current variable input or output?
currVarAxes=findobj(figNumber,'Type','axes','XColor',selectColor);
varIndex=get(currVarAxes,'UserData');
varType=get(currVarAxes,'Tag');
mainAxes=findobj(figNumber,'Type','axes','Tag','mainaxes');
%  currMF=get(mainAxes,'UserData');
param=get(mainAxes,'UserData');
if isequal(varType,'output')
    currMF=param.CurrMF;
else
    if isUpper % Type is upper
        if ~helper.isInt(param.CurrMF/2)
            currMF=param.CurrMF;
        elseif helper.isInt(param.CurrMF/2)
            currMF=param.CurrMF-1;
        end
        paramHndl=findobj(figNumber,'Tag','mfparams');
    else % Type is lower
        if ~helper.isInt(param.CurrMF/2)
            currMF=param.CurrMF+1;
        elseif helper.isInt(param.CurrMF/2)
            currMF=param.CurrMF;
        end
        paramHndl=findobj(figNumber,'Tag','mfparams2');
    end
end
if strcmp(varType,'input'),
    backgroundColor=inputColor;
else
    backgroundColor=outputColor;
end

typeList=get(mfTypeHndl,'String');
typeValue=get(mfTypeHndl,'Value');
newType=deblank(typeList(typeValue,:));
% Strip off the leading space
newType=fliplr(deblank(fliplr(newType)));
msgStr=['Changing type of "' fis.(varType)(varIndex).mf(currMF).name  '" to "' newType '"'];
statmsg(figNumber,msgStr);

% Now translate and insert the translated parameters
if strcmp(fisType,'sugeno') & strcmp(varType,'output'),
    % Handle the sugeno case
    oldParams=fis.(varType)(varIndex).mf(currMF).params;
    if strcmp(newType,'constant'),
        % Pick off only the constant term
        if  isInterval
            newParamsUpper=oldParams(length(oldParams));
            fis.(varType)(varIndex).mf(currMF).type=newType;
            fis.(varType)(varIndex).mf(currMF).params=newParamsUpper;
            fis.(varType)(varIndex).mf(currMF).params(2,1)=newParamsUpper;
        else
            newParamsUpper=oldParams(length(oldParams));
            fis.(varType)(varIndex).mf(currMF).type=newType;
            fis.(varType)(varIndex).mf(currMF).params=newParamsUpper;
        end
    else % linear to be improved
        fis.(varType)(varIndex).mf(currMF).type=newType;
        %if length(oldParams)==2
        %if isInterval
        fis.(varType)(varIndex).mf(currMF).params=[zeros(1,numInputs) oldParams(1)];
        for k=1:numInputs
            fis.(varType)(varIndex).mf(currMF).params(2,k)=0;
        end
        fis.(varType)(varIndex).mf(currMF).params(2,k+1)=1;
        %else
        %fis.(varType)(varIndex).mf(currMF).params=[zeros(1,numInputs) oldParams];
        %end
        %end
    end
    newParams=fis.(varType)(varIndex).mf(currMF).params;
    if helper.isInt(numel(newParams)/2)
        for k=1:numel(newParams)/2
            newParamsUpper(1,k)=newParams(1,k);
            newParamsLower=newParamsUpper;
        end
    else
        for k=1:numel(newParams)
            newParamsUpper(1,k)=newParams(1,k);
            newParamsLower=newParamsUpper;
        end
    end
    mfParamHndl=findobj(figNumber,'Type','uicontrol','Tag','mfparams');
    set(mfParamHndl,'String',[' ' mat2str(newParamsUpper,4)]);
    mfParamHndl2=findobj(figNumber,'Type','uicontrol','Tag','mfparams2');
    set(mfParamHndl2,'String',[' ' mat2str(newParamsLower,4)]);
    
    helper.setAppdata(fis);
else
    oldParams=fis.(varType)(varIndex).mf(currMF).params;
    oldType=fis.(varType)(varIndex).mf(currMF).type;
    oldType=deblank(oldType);
    newType=deblank(newType);
    varRange=fis.(varType)(varIndex).range;
    tol=1e-3*(varRange(2)-varRange(1));
    [newParamsUpper,errorStr]=mf2mf(oldParams,oldType,newType,tol);
    if helper.isInt(currMF/2)
        % newParamsUpper = helper.lowerMf(newParamsUpper,newType,varRange);
        newParamsUpper(end+1)=0.5;
    else
        newParamsUpper(end+1)=1;
    end
    if isempty(newParamsUpper),
        statmsg(figNumber,errorStr);
        set(paramHndl,'String',[' ' mat2str(oldParams,4)]);
        val=findrow(oldType,typeList);
        set(mfTypeHndl,'Value',val);
    else
        % Set the MF params to the right value
        set(paramHndl,'String',[' ' mat2str(newParamsUpper,4)]);
        
        % Replot the new curve
        lineHndl=findobj(mainAxes,'Tag','mfline','UserData',currMF);
        %       lineHndlList=findobj(mainAxes,'Type','mfline');
        %       for i=1:length(lineHndlList)
        %         thisparam=get(lineHndlList(i), 'UserData');
        %         if ~isempty(thisparam) & thisparam.CurrMF == currMF,
        %           lineHndl=lineHndlList(i);
        %          break;
        %         end
        %       end
        
        txtHndl=findobj(mainAxes,'Type','text','UserData',currMF);
        % First delete the old curve
        set(lineHndl,'Color',backgroundColor);
        set(txtHndl,'Color',backgroundColor);
        x=get(lineHndl,'XData');
        mfType=eval(['fis.' varType '(' num2str(varIndex) ').mf(' num2str(currMF) ').type']);
        
        try
            y=newParamsUpper(end)*evalmf(x,newParamsUpper(1:end-1),newType);
        catch ME
            y=nan(size(x));
        end
        
        set(lineHndl,'YData',y,'Color',selectColor);
        centerIndex=find(y==max(y));
        centerIndex=round(mean(centerIndex));
        txtPos=get(txtHndl,'Position');
        if ~isnan(centerIndex)
            txtPos(1)=x(centerIndex);
        end
        set(txtHndl,'Position',txtPos,'Color',selectColor);
        eval(['fis.' varType '(' num2str(varIndex) ').mf(' num2str(currMF) ').type=''' newType ''';']);
        eval(['fis.' varType '(' num2str(varIndex) ').mf(' num2str(currMF) ').params=' mat2str(newParamsUpper) ';']);
        helper.setAppdata(fis);
    end
    
end
%obj=fill('','',obj);

end

function obj=gridAxs(~,~,obj,cmd)
%GRID
%
% SYNTAX:
%     grid(...)
%
% INPUTS:
%
% OUTPUTS:
%
% EXAMPLE :
%
% See also

% Copyright (c) AVL Software and Functions GmbH 2014
% $Revision: 1.10 $, $Date: 2014/02/19 10:20:06VET $ by $Author: Dalon Thierry RGB (DALONT) $

% Calls:
figNumber=gcf;



HandlGridOn = findobj('Tag', 'gridon');
HandlGridOff = findobj('Tag', 'gridoff');
fis=helper.getAppdata;
% inputColor=[1 1 0.8];
mainAxes=findobj('tag','mainaxes');
axes(mainAxes(1))
% hold on;

% hold off;
switch cmd
    case 'on'
        set(HandlGridOff,'value',0)
        set(HandlGridOn,'value',1)
        grid on;
    case 'off'
        set(HandlGridOn,'value',0)
        set(HandlGridOff,'value',1)
        grid off;
end
end

function obj = mfparams( ~,~,obj )
%MFPARAMS Summary of this function goes here
%   Detailed explanation goes here
%====================================
%% colors
selectColor=[1 0 0];
inputColor=[1 1 0.93];
outputColor=[0.8 1 1];



mfParamHndl = gcbo;
figNumber=gcf;
fis=helper.getAppdata;
fisType=fis.type;

% Is the current variable input or output?
currVarAxes=findobj(figNumber,'Type','axes','XColor',selectColor);
varIndex=get(currVarAxes,'UserData');
varType=get(currVarAxes,'Tag');
if strcmp(varType,'input'),
    backgroundColor=inputColor;
else
    backgroundColor=outputColor;
end
mainAxes=findobj(figNumber,'Type','axes','Tag','mainaxes');
param=get(mainAxes,'UserData');
currMF=param.CurrMF;

HandlParamsUpper = findobj('Tag', 'mfparams');
% Read user input
newParamStr=get(HandlParamsUpper,'String');
% Params Edit Lower
HandlParamsLower = findobj('Tag', 'mfparams2');
newParamStrLower=get(HandlParamsLower,'String');
if isempty(newParamStr)
    newParamsUpper = [];
    newParamsLower = [];
else
    newParamsUpper = evalin('base',newParamStr,'[]');
    newParamsLower = evalin('base',newParamStrLower,'[]');
    if ~isreal(newParamsUpper)
        newParamsUpper = [];
        newParamsLower = [];
    else
        iscrisp=helper.setCrispInterval('iscrisp');
        newParamsUpper = reshape(newParamsUpper,[1 prod(size(newParamsUpper))]);
        if iscrisp
            newParamsLower=newParamsUpper;
        else
            newParamsLower = reshape(newParamsLower,[1 prod(size(newParamsLower))]);
        end
    end
end

isWarning = helper.compareMFs(fis,newParamsLower,newParamsUpper,currMF,varType,varIndex);
if isWarning
    warndlg({'The upper MF grade values must always be bigger then the lower MF ones for any crisp input.';...
        ' ';...
        'Please check Params Upper and Params Lower!!'},'!! Warning!!');
    drawnow
    return
end




% ii = 1 for first membership function and ii = 2 for second msfnc
for ii=1:2
    if ii==1
        if isequal(varType,'output')
            newParamsUse=newParamsUpper;
        elseif ~helper.isInt(currMF/2) % Upper Membership Function
            newParamsUse=newParamsUpper;
        elseif helper.isInt(currMF/2) % Lower Membership Function
            newParamsUse=newParamsLower;
        end
    elseif ii==2
        if isequal(varType,'output')
            newParamsUse(1,2)=newParamsLower;
        elseif ~helper.isInt(currMF/2) % Upper Membership Function
            newParamsUse=newParamsLower;
            currMF=currMF+1;
        elseif helper.isInt(currMF/2) % Lower Membership Function
            newParamsUse=newParamsUpper;
            currMF=currMF-1;
        end
    end
    % Use the old parameters for error-checking
    RefStruct = substruct('.',varType,'()',{varIndex},'.','mf','()',{currMF});
    EditedMF = subsref(fis,RefStruct);
    oldParams = EditedMF.params;
    
    % Resolve length discrepancies for Sugeno outputs
    if length(newParamsUse)==1 & strcmpi(fisType,'sugeno') & strcmpi(varType,'output')
        newParamsUse = [zeros(1,length(fis.input)*strcmp(EditedMF.type,'linear')),newParamsUse];
    end
    
    % Update FIS data
    if 0%length(newParams)~=length(oldParams),
        % Back out change
        newParams = oldParams;
        msgStr = sprintf('Invalid parameter vector. No change made to MF %d',currMF);
    else
        % Send status message to the user
        msgStr=sprintf('Changing parameter for MF %d to %s',currMF,newParamStr);
        
        if strcmp(fisType,'sugeno') & strcmp(varType,'output'),
            % Nothing to do for sugeno output case...
            EditedMF.params = newParamsUse;
            fis = subsasgn(fis,RefStruct,EditedMF);
            helper.setAppdata(fis);
        else
            lineHndl=findobj(mainAxes,'Type','line','UserData',currMF);
            x=get(lineHndl,'XData');
            try
                y = newParamsUse(end)*evalmf(x,newParamsUse(1:end-1),EditedMF.type);
                % New data OK. Update FIS
                EditedMF.params = newParamsUse;
                fis = subsasgn(fis,RefStruct,EditedMF);
                % Replot the curve
                txtHndl=findobj(mainAxes,'Type','text','UserData',currMF);
                centerIndex=find(y==max(y));
                centerIndex=round(mean(centerIndex));
                txtPos=get(txtHndl,'Position');
                if ~isnan(centerIndex)
                    txtPos(1) = x(centerIndex);
                    txtPos(2) = y(centerIndex) + 0.1;
                end
                set(txtHndl,'Position',txtPos,'Color',selectColor);
                set(lineHndl,'YData',y,'Color',selectColor);
                helper.setAppdata(fis);
                
            catch ME
                % There's been an error in the MF code, so don't change anything
                uiwait(errordlg(sprintf('Invalid parameter vector. No change made to MF %s',EditedMF.type),'Membership Function Error', 'modal'))
                newParamsUse=oldParams;
            end
        end
    end
end
set(HandlParamsUpper,'String',[' ' mat2str(newParamsUpper,4)]);
set(HandlParamsLower,'String',[' ' mat2str(newParamsLower,4)]);
statmsg(figNumber,msgStr);
obj=fill('','',obj);

end

