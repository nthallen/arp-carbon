Engineering Graphs in Matlab
  Setup
    There are three Matlab libraries you will need to install to run the
    engineering plot gui:
      nort: A set of general utility functions
      nort/ne: Functions for engineering plots
      HCIeng: HCI-specific engineeering plots
    Installation involves checking out the libraries from CVS and adding
    them to your Matlab path.
    
    Decide where you want the Matlab libraries to go.
      You probably want to create a base directory for your Matlab
      libraries. This could be a Matlab directory in "My Documents" or
      C:\Matlab. All three of these libraries could then be subdirectories
      of this root directory. On the other hand, you might have all of
      the HCI source code checked out somewhere, so it might make sense
      to leave the HCI-specific engineering plot library where it is.
    
    Download Nort's matlab libraries:
      cvs -d :ext:forge.abcd.harvard.edu:/cvsroot/arp-das co -d nort Matlab/nort
        or
      cvs -d :pserver:anonymous@forge.abcd.harvard.edu:/cvsroot/arp-das login
      cvs -d :pserver:anonymous@forge.abcd.harvard.edu:/cvsroot/arp-das co -d nort Matlab/nort
      
      There are several directories included in this download, but only two that
      should be added to your Matlab path: nort and nort/ne. The others contain
      examples of installation-specific configuration hooks to make other parts
      of the libraries work.

    Download HCI engineering plot directory
      svn checkout https://forge.abcd.harvard.edu/svn/arp-carbon/trunk/HCI/eng HCIeng
        Note that this is part of the HCI source hierarchy, so if you already have
        that checked out, you can use it where it is.
    
    Add nort, nort/ne and HCIeng directories to your Matlab path

    Decide on a root directory for flight/run data
      This directory will contain a subdirectory for each run using the same
      run numbering as under QNX. If you append an 'F' to the name of flight
      runs, then the plots will note that this is flight data.
      
      Each run directory will contain .mat files with all the engineering
      data.

    The following step will be handled interactively the first time you
    invoke ui_cc:
    
    Create HCI_Data_Dir.m (probably in your HCIeng directory):
      function path = HCI_Data_Dir
      % path = HCI_Data_Dir;
      path = 'C:\Data\HCI';

  Setup for a specific run:
    Extract engineering data on QNX:
      extract raw/flight/120504.2 HCIengext
    Copy extract .csv files into HCI_Data_Dir
      I have a script called 'getrun' that I place in the HCI_Data_Dir:
      
        #! /bin/bash
        flt=''
        gse=htwgse
        HomeDir=/home/hci
        Exp=HCI
        for run in $*; do
          if [ $run = "-f" ]; then
            flt=F
          else
            echo $run
            [ -d $run$flt ] || mkdir $run$flt
            scp $gse:$HomeDir/anal/$run/*.csv $run$flt
            [ -n "$flt" ] && scp $gse:$HomeDir/raw/flight/$run/$Exp.log $run$flt/$Exp.log
          fi
        done

      Then 'getrun -f 120504.2' will collect the necessary files. You will need to edit
      this as appropriate.
    
    Convert the .csv files to .mat files:
      In Matlab, cd to the run directory and run csv2mat. You can delete the .csv files
      after the .mat files are created.
      
    Now you have completed the setup for this run. Hereafter, this run's data will be
    readily accessible to the GUI.
    
  Run the GUI:
    ui_cc
      Select the run from the list on the right. The most recent run is the default.
      Each button in the main area generates a graph. The larger buttons represent
      groups that put multiple graphs on one figure. The grouping is easily
      configurable, so if there are different combinations you'd like to see, let
      me know.
      
      I have added some menu items to the graph displays.
        Zoom: Added before Matlab added their zoom buttons, but still sometimes
          a little easier to use.
        MatchX: After zooming in on an X-axis region in one graph, MatchX will
          zoom all the other graphs in the figure to the same X range.
        Edit: Allows you to further customize the graphs.
        Expand: Allows you to open any of the graphs in it's own figure.
      
  Customization:
    The selection of which data gets displayed in which group is determined
    by the file genui.txt in the telemetry source directory. The program
    that generates the .m files is called 'genui', and it also creates
    the extraction required. The format of genui.txt is documented in
    the usage message for genui, so 'use genui' will explain it.
    
    You will often want to further customize individual graphs. The use of
    lines may be inappropriate on particularly noisy data, for example, or
    the default limits may reflect a transient startup condition, not the
    region of interest. You can customize any graph by selecting from the
    'edit' menu. This creates and/or edits a customization function for
    the specified graph given a vector of graphic object handles.
    You can add statements that alter the graphic
    objects. This is an example from the Harvard Water Vapor instrument:
    
      function cust_phwvsdpdp(h)
      % cust_phwvsdpdp(h)
      % Customize plot created by phwvsdpdp

      % phwvsdpdp's definition:

      % function phwvsdpdp(varargin);
      % % phwvsdpdp( [...] );
      % % SDP DP
      % h = timeplot({'SDPDP'}, ...
      %       'SDP DP', ...
      %       'DP', ...
      %       {'SDPDP'}, ...
      %       varargin{:} );

      % Example customizations include:
      %   set(h,'LineStyle','none','Marker','.');
      %   ax = get(h(1),'parent');
      %   set(ax,'ylim',[0 800]);

      set(h,'LineStyle','none','Marker','.');
      ax = get(h,'parent');
      set(ax,'ylim',[-.125 15]);

    This switches the graphs from lines to symbols and fixes the Y-axis
    limits at [0 800].
    
    Such modifications can be checked back in to CVS/SVN to make them
    available to other team members. Subsequent changes to genui.txt
    should not overwrite the modifications.
    