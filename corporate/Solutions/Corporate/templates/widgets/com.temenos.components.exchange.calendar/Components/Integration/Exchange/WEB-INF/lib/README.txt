The sources of the Exchange component depend on the following jars:

- specific, available under the provided Solution/WEB-INF/lib
joda-time-2.7.jar
These need to be added to the java path in the Developer.lax file

- common, available under IDE/lib
Acquire.jar
iforms.jar
commons-codec-1.11.jar
commons-logging-1.2.jar
httpcore-4.4.9.jar
httpclient-4.5.5.jar
These should be already present in the java path in the Developer.lax file; no change required.

The sources used by this Integration component are compiled and packaged in the Exchange Solution 
under Solution/WEB-INF/lib/exchange-calendar.jar.

When including this component into another solution, copy into its WEB-INF/lib folder the following jars from Solution/WEB-INF/lib :
exchange-calendar.jar
joda-time-2.7.jar

EOF