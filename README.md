# ServiceWrapperTool
<h4> Wrapper for systemctl with SysV style output. </h4>
<hr>

> [!NOTE]
> ServiceWrapperTool is currently in active development.
<hr>

> [!WARNING]
> This code is highly experiemental and has NOT been fully implemented or tested yet.
<hr>

> [!IMPORTANT]
> Code is not considered stable yet, and still lacks most features.

<hr>
<p>
  sc3.sh currently has bugs.  
  <ul>
  <li> - Currently locked to httpd (need to fix $SERVICE to map to $2) </li>
  <li> - Must manually call SC_StartService, SC_StopService, or SC_StatusService afrer running 'source sc3.sh'. </li>
  </ul>
</p>
