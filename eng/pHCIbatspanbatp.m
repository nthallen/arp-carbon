function pHCIbatspanbatp(varargin);
% pHCIbatspanbatp( [...] );
% BAT P
h = timeplot({'BAT_Px','BAT_Py','BAT_Pz','BAT_Ps'}, ...
      'BAT P', ...
      'P', ...
      {'BAT\_Px','BAT\_Py','BAT\_Pz','BAT\_Ps'}, ...
      varargin{:} );
