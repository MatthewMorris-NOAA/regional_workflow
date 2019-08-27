#
#-----------------------------------------------------------------------
#
# Set variables that depend on the external model from which to obtain
# the ICs (specified in EXTRN_MDL_NAME_ICSSURF).  These variables (with
# corresponding descriptions) are:
#
# EXTRN_MDL_FILES_BASEDIR_ICSSURF:
# The base directory in which we will create subdirectories for each cy-
# cle in which to store the analysis and/or surface files generated by
# the external model for the ICs.  This directory will be created if if
# doesn't already exist.
#
# EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF:
# The system directory (i.e. a location on disk, not on HPSS) in which
# the files generated by the external model for the ICs are stored (usu-
# ally for a limited time, e.g. for the FV3GFS external model, 2 weeks
# on WCOSS and 2 days on theia).  Note that this is a directory that al-
# ready exists on the specified machine; it is not a directory that is
# created by the FV3SAR workflow.  If for a given cycle start date and 
# hour the external model files are available in this system directory,
# they will be copied over to a cycle-dependent subdirectory under EX-
# TRN_MDL_FILES_BASEDIR_ICSSURF (which is the location where the preprocessing tasks
# that generate the IC and surface files look for these files.  If these
# files are not available in the system directory, then we search for 
# them elsewhere, e.g. in the mass store (HPSS).
# 
#
#-----------------------------------------------------------------------
#
case $EXTRN_MDL_NAME_ICSSURF in
"GSMGFS")
  EXTRN_MDL_FILES_BASEDIR_ICSSURF="${WORKDIR}/GSMGFS/ICSSURF"
  ;;
"FV3GFS")
  EXTRN_MDL_FILES_BASEDIR_ICSSURF="${WORKDIR}/FV3GFS/ICSSURF"
  ;;
"RAPX")
  EXTRN_MDL_FILES_BASEDIR_ICSSURF="${WORKDIR}/RAPX/ICSSURF"
  ;;
"HRRRX")
  EXTRN_MDL_FILES_BASEDIR_ICSSURF="${WORKDIR}/HRRRX/ICSSURF"
  ;;
esac
#
#-----------------------------------------------------------------------
#
# Set the system directory (i.e. location on disk, not on HPSS) in which
# the files generated by the external model specified by EXTRN_MDL_-
# NAME_ICSSURF that are necessary for generating initial condition (IC)
# and surface files for the FV3SAR are stored (usually for a limited 
# time, e.g. for the GFS external model, 2 weeks on WCOSS and 2 days on
# theia).  If for a given forecast start date and time these files are
# available in this system directory, they will be copied over to EX-
# TRN_MDL_FILES_DIR, which is the location where the preprocessing tasks
# that generate the IC and surface files look for these files.  If these
# files are not available in the system directory, then we search for 
# them elsewhere, e.g. in the mass store (HPSS).
#
#-----------------------------------------------------------------------
#
if [ "${RUN_ENVIR}" = "nco" ]; then

  EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF="$COMINgfs"

else

  case $EXTRN_MDL_NAME_ICSSURF in
  
  
  "GSMGFS")
    case $MACHINE in
    "WCOSS_C")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF=""
      ;;
    "THEIA")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF=""
      ;;
    "JET")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF=""
      ;;
    "ODIN")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF=""
      ;;
    *)
      print_err_msg_exit "\
The system directory in which to look for the files generated by the ex-
ternal model specified by EXTRN_MDL_NAME_ICSSURF has not been specified
for this machine and external model combination:
  MACHINE = \"$MACHINE\"
  EXTRN_MDL_NAME_ICSSURF = \"$EXTRN_MDL_NAME_ICSSURF\"
"
      ;;
    esac
    ;;
  
  
  "FV3GFS")
    case $MACHINE in
    "WCOSS_C")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF="/gpfs/hps/nco/ops/com/gfs/prod"
      ;;
    "THEIA")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF="/scratch4/NCEPDEV/rstprod/com/gfs/prod"
      ;;
    "JET")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF="/lfs3/projects/hpc-wof1/ywang/regional_fv3/gfs"
      ;;
    "ODIN")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF="/scratch/ywang/test_runs/FV3_regional/gfs"
      ;;
    *)
      print_err_msg_exit "\
The system directory in which to look for the files generated by the ex-
ternal model specified by EXTRN_MDL_NAME_ICSSURF has not been specified
for this machine and external model combination:
  MACHINE = \"$MACHINE\"
  EXTRN_MDL_NAME_ICSSURF = \"$EXTRN_MDL_NAME_ICSSURF\"
"
      ;;
    esac
    ;;
  
  
  "RAPX")
    case $MACHINE in
    "THEIA")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF="/scratch4/BMC/public/data/gsd/rr/full/wrfnat"
      ;;
    *)
      print_err_msg_exit "\
The system directory in which to look for the files generated by the ex-
ternal model specified by EXTRN_MDL_NAME_ICSSURF has not been specified
for this machine and external model combination:
  MACHINE = \"$MACHINE\"
  EXTRN_MDL_NAME_ICSSURF = \"$EXTRN_MDL_NAME_ICSSURF\"
"
      ;;
    esac
    ;;


  "HRRRX")
    case $MACHINE in
    "THEIA")
      EXTRN_MDL_FILES_SYSBASEDIR_ICSSURF="/scratch4/BMC/public/data/gsd/hrrr/conus/wrfnat"
      ;;
    *)
      print_err_msg_exit "\
The system directory in which to look for the files generated by the ex-
ternal model specified by EXTRN_MDL_NAME_ICSSURF has not been specified
for this machine and external model combination:
  MACHINE = \"$MACHINE\"
  EXTRN_MDL_NAME_ICSSURF = \"$EXTRN_MDL_NAME_ICSSURF\"
"
      ;;
    esac
    ;;


  esac

fi
#
#-----------------------------------------------------------------------
#
# Set the variable EXTRN_MDL_FILES_BASEDIR_LBCS that will contain the 
# location of the directory in which we will create subdirectories for 
# each forecast (i.e. for each CDATE) in which to store the forecast 
# files generated by the external model specified in EXTRN_MDL_NAME_-
# LBCS.  These files will be used to generate input lateral boundary 
# condition files for the FV3SAR (one per boundary update time).
#
# Also, set EXTRN_MDL_LBCS_OFFSET_HRS, which is the number of hours to
# shift the starting time of the external model that provides lateral
# boundary conditions.
#
#-----------------------------------------------------------------------
#
case $EXTRN_MDL_NAME_LBCS in
"GSMGFS")
  EXTRN_MDL_FILES_BASEDIR_LBCS="${WORKDIR}/GSMGFS/LBCS"
  EXTRN_MDL_LBCS_OFFSET_HRS="0"
  ;;
"FV3GFS")
  EXTRN_MDL_FILES_BASEDIR_LBCS="${WORKDIR}/FV3GFS/LBCS"
  EXTRN_MDL_LBCS_OFFSET_HRS="0"
  ;;
"RAPX")
  EXTRN_MDL_FILES_BASEDIR_LBCS="${WORKDIR}/RAPX/LBCS"
  EXTRN_MDL_LBCS_OFFSET_HRS="3"
  ;;
"HRRRX")
  EXTRN_MDL_FILES_BASEDIR_LBCS="${WORKDIR}/HRRRX/LBCS"
  EXTRN_MDL_LBCS_OFFSET_HRS="0"
  ;;
esac
#
#-----------------------------------------------------------------------
#
# Set the system directory (i.e. location on disk, not on HPSS) in which
# the files generated by the external model specified by EXTRN_MDL_-
# NAME_LBCS that are necessary for generating lateral boundary condition
# (LBC) files for the FV3SAR are stored (usually for a limited time, 
# e.g. for the GFS external model, 2 weeks on WCOSS and 2 days on the-
# ia).  If for a given forecast start date and time these files are
# available in this system directory, they will be copied over to EX-
# TRN_MDL_FILES_DIR, which is the location where the preprocessing tasks
# that generate the LBC files look for these files.  If these files are
# not available in the system directory, then we search for them else-
# where, e.g. in the mass store (HPSS).
#
#-----------------------------------------------------------------------
#
if [ "${RUN_ENVIR}" = "nco" ]; then

  EXTRN_MDL_FILES_SYSBASEDIR_LBCS="$COMINgfs"

else

  case $EXTRN_MDL_NAME_LBCS in
  
  
  "GSMGFS")
    case $MACHINE in
    "WCOSS_C")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS=""
      ;;
    "THEIA")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS=""
      ;;
    "JET")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS=""
      ;;
    "ODIN")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS=""
      ;;
    *)
      print_err_msg_exit "\
  The system directory in which to look for the files generated by the ex-
  ternal model specified by EXTRN_MDL_NAME_LBCS has not been specified for
  this machine and external model combination:
    MACHINE = \"$MACHINE\"
    EXTRN_MDL_NAME_LBCS = \"$EXTRN_MDL_NAME_LBCS\"
  "
      ;;
    esac
    ;;


  "FV3GFS")
  
    case $MACHINE in
    "WCOSS_C")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS="/gpfs/hps/nco/ops/com/gfs/prod"
      ;;
    "THEIA")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS="/scratch4/NCEPDEV/rstprod/com/gfs/prod"
      ;;
    "JET")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS="/lfs3/projects/hpc-wof1/ywang/regional_fv3/gfs"
      ;;
    "ODIN")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS="/scratch/ywang/test_runs/FV3_regional/gfs"
      ;;
    *)
      print_err_msg_exit "\
  The system directory in which to look for the files generated by the ex-
  ternal model specified by EXTRN_MDL_NAME_LBCS has not been specified for
  this machine and external model combination:
    MACHINE = \"$MACHINE\"
    EXTRN_MDL_NAME_LBCS = \"$EXTRN_MDL_NAME_LBCS\"
  "
      ;;
    esac
    ;;


  "RAPX")
  
    case $MACHINE in
    "THEIA")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS="/scratch4/BMC/public/data/gsd/rr/full/wrfnat"
      ;;
    *)
      print_err_msg_exit "\
  The system directory in which to look for the files generated by the ex-
  ternal model specified by EXTRN_MDL_NAME_LBCS has not been specified for
  this machine and external model combination:
    MACHINE = \"$MACHINE\"
    EXTRN_MDL_NAME_LBCS = \"$EXTRN_MDL_NAME_LBCS\"
  "
      ;;
    esac
    ;;
  
  
  
  "HRRRX")
  
    case $MACHINE in
    "THEIA")
      EXTRN_MDL_FILES_SYSBASEDIR_LBCS="/scratch4/BMC/public/data/gsd/hrrr/conus/wrfnat"
      ;;
    *)
      print_err_msg_exit "\
  The system directory in which to look for the files generated by the ex-
  ternal model specified by EXTRN_MDL_NAME_LBCS has not been specified for
  this machine and external model combination:
    MACHINE = \"$MACHINE\"
    EXTRN_MDL_NAME_LBCS = \"$EXTRN_MDL_NAME_LBCS\"
  "
      ;;
    esac
    ;;
  
  
  
  esac

fi
