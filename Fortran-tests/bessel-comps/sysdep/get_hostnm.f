      function get_hostnm(host_name)
      character*8 procname
      parameter (procname='get_host')
      integer get_hostnm
      character*125 host_name

ccc#ifdef AIX
      get_hostnm = gethostname(host_name,125)
ccc#else
cccTemp      get_hostnm = hostnm(host_name)
ccc#endif
ccc   get_hostnm=hostnam(host_name)
cc      host_name='rhodium '
      get_hostnm=0

      return
      end
